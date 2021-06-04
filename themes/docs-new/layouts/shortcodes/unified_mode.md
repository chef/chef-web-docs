<!-- markdownlint-disable MD041 -->
Unified mode combines the compile and converge stages of the Chef Infra Client run into one phase. In unified mode, Chef Infra Client compiles and converges a custom resource in one pass and in the order that the code is compiled, from the beginning to the end.

Unified mode is only available on custom resources. Chef Infra Client processes all other resources with separate compile and converge phases.

In Chef Infra Client 17 (April 2021) and some earlier versions, the default behavior is `unified_mode false`. Enable unified mode on a custom resource with `unified_mode true`. Chef Infra Client displays a deprecation message with `unified_mode false`.

In Chef Infra Client 18 (April 2022), `unified_mode true` will become the default behavior.

|Chef Infra Client  | Unified Mode                 |
|-------------------|-----------------------------|
| 18.x (2022)       | Default: `unified_mode true` |
| 17.x (2021)              | Default: `unified_mode false`|
| 16.x (2020)              | Default: `unified_mode false`|
| 15.3 and higher   | Default: `unified_mode false`|
| 15.0–15.2        | Not available               |
| 14.14 and higher  | Default: `unified_mode false`|
| Lower than 14.14  | Not available               |

## Enable Unified Mode

Enable unified mode by adding the `unified_mode true` in the custom resource. You can upgrade most custom resources to use unified mode without additional work other than testing and validation.

```ruby
# enable unified mode
unified_mode true

provides :myresource

actions :run do
  [...]
end

```

## Troubleshoot Unified Mode

Unified mode changes the execution of a custom resource to run in one phase, in the order that the code is written, from first line of the code to the last. Custom resources designed to use two phases may need modification. These fall into three general types:

- Resources with changes to internal sub-resources
- Resources with actions on later resources
- Resources that rely on the out-of-order execution

When designing a custom resource for unified mode:

- Declare a resource first and then declare actions on it
- Write resources in run-time order

### Resources with Changes to Internal Sub-resources

Some custom resources are designed to create and edit other sub-resources as part of the resource declaration. In unified mode, the Chef Infra Client parses a resource code block that creates or edits a sub-resource and immediately tries to apply that change, even though the sub-resource does not yet exist. This results in the execution of an incomplete resource.

For example, with unified mode enabled, this code from the _dhcp cookbook_ is designed to create and edit a shared `dhcp_subnet` resource, but it will not work as expected:

```ruby
# 'edit_resource' results in an incomple subresource
sr = edit_resource(:dhcp_subnet, "#{new_resource.name}_sharedsubnet_#{subnet}") do
  owner new_resource.owner
  group new_resource.group
  mode new_resource.mode

  ip_version new_resource.ip_version
  conf_dir new_resource.conf_dir
  shared_network true
end

properties.each do |property, value|
  sr.send(property, value)
end
```

To correct custom resources that change sub-resources during their declaration, you can:

- Apply properties in the code block (preferred)
- Run the resource explicitly (not preferred)

#### Apply Properties in the Code Block

This pattern declares the sub-resource in one code block and then changes it in the next code block. This is the preferred pattern in unified mode because all resources execute in order at compile time.

```ruby
dhcp_subnet "#{new_resource.name}_sharedsubnet_#{subnet}" do
  owner new_resource.owner
  group new_resource.group
  mode new_resource.mode

  ip_version new_resource.ip_version
  conf_dir new_resource.conf_dir
  shared_network true

  properties.each do |property, value|
    send(property, value)
  end
end
```

#### Run the Resource Explicitly

Another solution is to continue saving the resource as a variable, declaring `action :nothing` within the codeblock and then explicitly running the action in another codeblock.

The pattern of saving a resource as a variable and then forcing it to run at compile time with an explicit `run_action` works as it has in the past, but it not a preferred pattern. Unified mode forces resource execution to compile time by default, which makes this pattern redundant.

```ruby
sr = edit_resource(:dhcp_subnet, "#{new_resource.name}_sharedsubnet_#{subnet}") do
  owner new_resource.owner
  group new_resource.group
  mode new_resource.mode

  ip_version new_resource.ip_version
  conf_dir new_resource.conf_dir
  shared_network true

  action :nothing
end

properties.each do |property, value|
  sr.send(property, value)
end

# Run the action explicitly
sr.run_action(:create)
```

## Actions on Later Resources

Since unified mode executes your resource as it is compiled, `:immediate` notifications that execute later resources are handled differently than in the past.

### `:immediate` Notifications to Later Resources

Unified mode delays immediate notifications to later resources.
In unified mode the Chef Infra Client saves immediate notifications and executes them when the later resource is parsed. Immediate notifications to prior resources and delayed notifications behave the same as they did before unified mode.

The end result of sequentially chaining immediate notifications is the same as before unified mode. Instead of immediately notifying results, the notifications fire _in order_ as they are parsed, which has the same outcome. If the parse order and the intended execution order are very different, then the results may be different and are a reflection of the parse order.

The changes to sending immediate notification could result in subtle changes to behaviors in some resources, but it not a breaking change to common patterns of writing resources.

Chaining immediate notifications to later resources:

```ruby
remote_file "#{Chef::Config[:file_cache_path]}/myservice.tgz" do
  source "http://acme.com/myservice.tgz"
  notifies :extract, "archive_file[myservice.tgz]", :immediately
end

archive_file "#{Chef::Config[:file_cache_path]}/myservice.tgz" do
  destination '/srv/myservice'
  notifies :start, "service[myservice]", :immediately
  action :nothing
end

service "myservice" do
  action :nothing
end
```

### `:before` Notifications to Later Resources

In unified mode, you must declare a resource before sending a `before` notification to it.

Resources that subscribe to a `before` notification to a later resource must be declared after the resource that triggers the notification.

This resource declares a `before` notification to a later resource and will no longer work:

```ruby
package "myservice" do
  notifies :stop, "service[myservice]", :before
  notifies :start, "service[myservice]", :immediately
end

service "myservice" do
  action :nothing
end
```

Instead, declare the resource and then declare actions. For example:

```ruby
service "myservice" do
  action :nothing
end

package "myservice" do
  notifies :stop, "service[myservice]", :before
  notifies :start, "service[myservice]", :immediately
end
```

### Out Of Order Execution

Unified mode breaks custom resources that rely on the out-of-order execution of compile-time statements. Move any affected compile-time statements to the location in the code where they are intended to execute.

Out-of-order execution is rare. Internally at Chef, none of our custom resources broke during our migration to unified mode. Instead, we discovered a few cases in which custom resource code was intended to run in order, but Chef Infra Client executed it out of order. In these cases, unified mode fixed errors instead of introducing bugs.
