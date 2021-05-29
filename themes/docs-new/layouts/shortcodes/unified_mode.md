<!-- markdownlint-disable MD041 -->
Unified mode combines the compile and converge stages of the Chef Infra Client run into one phase. In unified mode, Chef Infra Client compiles and converges a custom resource in one pass and in the order that the code is compiled, from the beginning to the end.

Unified mode is only available on custom resources. Chef Infra Client processes all other resources with separate compile and converge phases.

In Chef Infra Client 17.x and some earlier versions, the default behavior is `unified_mode false`. Enable unified mode on a custom resource with `unified_mode true`. Chef Infra Client displays a deprecation message with `unified_mode false`.

In Chef Infra Client 18.x, `unified_mode true` will become the default behavior.

|Chef Infra Client  | Unified Mode                 |
|-------------------|-----------------------------|
| 18.x (2022)       | Default: `unified_mode true` |
| 17.x              | Default: `unified_mode false`|
| 16.x              | Default: `unified_mode false`|
| 15.3 and higher   | Default: `unified_mode false`|
| 15.0–15.2        | Not available               |
| 14.14 and higher  | Default: `unified_mode false`|
| Lower than 14.14  | Not available               |

## Enable Unified Mode

Enable unified mode by adding the `unified_mode true` in the resource declaration. You can upgrade most custom resources to use unified mode without additional work other than testing and validation.

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

Some resources are designed to create and edit other sub-resources as part of the resource declaration. In unified mode, the Chef Infra Client parses a resource codeblock that creates or edits a sub-resource and immediately and tries to apply that change, even though the sub-resource does not yet exist. This results in the execution of an incomplete resource.

For example, with unified mode enabled, this code from the _dhcp cookbook_ is designed to create and edit a shared `dhcp_subnet` resource does not work as expected:

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

To fix resources that change sub-resources during their declaration, you can:

- Apply properties in the codeblock (preferred)
- Run the resource explicitly (not preferred)

#### Apply Properties in the Codeblock

This pattern declares the sub-resource in one codeblock and then changes it in the next codeblock. This is the preferred pattern in unified mode because all resources execute in order at compile time.

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

Since unified mode executes your resource as it is compiled, you cannot send immediate notifications to resources declared later.

### `:immediate` Notifications to Later Resources

Unified mode delays immediate notifications to later resources.
In unified mode the Chef Infra Client saves immediate notifications and executes them when the later resource is parsed. Immediate notifications to prior resources and delayed notifications behave the same as they did before unified mode.

Chaining immediate notifications results in the same behavior as before unified mode. Changing the order of resources results does not change the results of a notification chain. Chained notifications in the same order during the Chef Infra Client run and immediately sends a notification to a target resource that was parsed earlier and saves a notification and sends it immediately after it parses a later resource.

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

Unified mode breaks resources with `before` notifications to later resources. In unified mode, you must declare a resource before you can act on it.

Resources that subscribe to a `before` notification to a later resource must be declared after the resource that triggers the notification.

This resource declares `before` notification to a later resource and will no longer work:

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

Unified mode  break custom resources that rely on the out-of-order execution of compile-time statements. Move any affected compile-time statements to the location in the code where they are intended to execute.

Out-of-order execution is rare. At Chef, none of our custom resources broke during our conversion custom resources to unified mode. Instead, we discovered a few cases in which custom resource code was intended run in order, but Chef Infra Client executed it out of order. In these cases, unified mode fixed errors instead of introducing bugs.
