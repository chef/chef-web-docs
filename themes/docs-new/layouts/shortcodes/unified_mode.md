<!-- markdownlint-disable MD041 -->
Unified Mode combines the compile and converge stages of the Chef Infra Client run into one phase. In unified mode, Chef Infra Client compiles and applies a custom resource once, starting at the top of the file and working down to the bottom. Unified mode is only available on custom resources. Chef Infra Client will continue to process other resources with separate compile and converge phases.

Set `unified_mode true` to enable unified mode on a custom resource. Left unset, the default behavior is `unified_mode false`, and Chef Infra Client will show a deprecation message warning you to enable unified mode.

|Chef Infra Client  | Unified Mode|
|-------------------|------------|
| 18.x (in 2022)    | Default: `unified_mode true` |
| 17.x              | Default: `unified_mode false`|
| 16.x              | Default: `unified_mode false`|
| 15.3 and higher   | Default: `unified_mode false`|
| 15.0 - 15.2       | Not available              |
| 14.14 and higher  | Default: `unified_mode false`|
| Lower than 14.14  | Not available              |


## Enable Unified Mode

Most resources can be converted to use Unified Mode with no work, apart from testing, by adding the flag to turn it on anywhere in the resource declaration:

```ruby
unified_mode true

provides :myresource

actions :run do
  [...]
end
```

For most resources, no further action should be required aside from testing and validation.

## Troubleshoot Unified Mode

Unified Mode fundamentally alters the execution of a custom resource so it is run in one phase, from top to bottom. Custom resources designed to use two phases may need modification. These fall into three general types:

- Actions in resources during declaration
- Actions on resources that are not yet declared
- Out-of-order execution of the custom resource file

In unified mode,

- Fully declare resources before acting on them
- Write custom resources in run-time order, from start to finish

### Resources that Create and Modifiy Sub-resources

Some resources are designed to create and edit other resources in one declaration. In unified mode, the resource parses a codeblock that creates or edits a sub-resource and immediately applies that change, resulting in the execution of an incomplete resource.

For example, with unified mode enabled, this code from the _dhcp cookbook_ creates a resource and subsequently edits it will not work as expected:

```ruby
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

#### Fix: Apply Properties in the Codeblock

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

#### Fix: Run the Resource Explicitly

Another solution is to declare the resource as `action :nothing` and then explicitly run it:

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

sr.run_action(:create)
```

<!-- This also shows that the pattern of saving a resource to a variable and forcing it to run at compile time with an explicit `run_action` still works, but it is redundant with Unified Mode which forces all resource execution to compile time by default. -->

## Notifications

### Unified Mode Delays Immediate Notifications to Later Resources

Since unified mode runs your file from top to bottom, you cannot send immediate notifications to resources described later in the file. Instead, these notifications are saved and executed when the resource is parsed. The behavior of immediate notifications to prior resources and the behavior of delayed notification are unchanged.

The common idiom of chaining immediate notifications forward will result in the same behavior:

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

Even with this pattern, shuffling the resources in any arbitrary order will result in the same behavior in unified mode since the notification chain will still fire in the same order, and either the target resource will be already parsed and fire immediately or else will be fired when the resource is parsed.

This could cause subtle changes in behaviors in some resources.
We are unaware of any common pattern of writing a resource that would be broken by this behavior of Unified Mode.
### `:before` Notifications To Resources Declared Later

One known breaking change with Unified Mode is that resources notified with a `:before` notification must be declared before they are notified:

Change post-declarations:

```ruby
package "myservice" do
  notifies :stop, "service[myservice]", :before
  notifies :start, "service[myservice]", :immediately
end

service "myseervice" do
  action :nothing
end
```

To pre-declarations:

```ruby
service "myseervice" do
  action :nothing
end

package "myservice" do
  notifies :stop, "service[myservice]", :before
  notifies :start, "service[myservice]", :immediately
end
```

The same is true for pre-declarations of resources that subscribe to a before notification of later resources which must be moved to a post-declaration.

We are unaware of either of these patterns being used in community cookbooks and we expect no impact to users, but this is included out of completeness.

### Out Of Order Execution

Out-of-order execution means that compile-time statements positioned later in the custom resource must be executed before resources declared earlier in the file. Custom resources using out-of-order execution will break in unified mode.

Out-of-order execution is theoretically possible, but rare. Custom resource authors generally write resources in the order that they are intended to execute.

Chef experienced zero cases of out-of-order execution breakage during the conversion of Chef Infra resources to unified mode. We did discover cases where the author of the resource intended code to be executed in order and was unaware that the Chef Infra Client executed it out of order. In these cases, enabling unified mode fixed errors instead of introducing bugs.

Breaking custom resources that rely on out-of-order execution by enabling unified mode is unlikely, but it theoretically possible. To avoid inadvertently breaking resources, we have introduced unified mode as positive declaration instead of as default. As always, we recommend recommend testing your changes.

