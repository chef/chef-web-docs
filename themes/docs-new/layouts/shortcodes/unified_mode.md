<!-- markdownlint-disable MD041 -->
Unified Mode combines the compile and converge stages of the Chef Infra Client run into one phase. Unified mode means that the Chef Infra Client compiles and applies a custom resource in order, from top to bottom. The impact of Unified Mode is limited to the individual custom resource--other resources or recipes remain unchanged. Enable Unified Mode by setting `unified_mode true` on a custom resource. Left unset, the behavior defaults to `unified_mode false`, which means that the custom resource will continue to work as it has in the past (using separate Chef Infra Client run compile and converge stages), with an additional deprecation message warning that those resources should be converted.

Unified Mode is required for custom resources in Chef Infra Client 17.0 and higher.
Unified Mode is available for custom resources in Chef Infra Client 15.3.
Unified Mode is **NOT** available for custom resources in Chef Infra Client 15.0.
Unified Mode is available for custom resources in Chef Infra Client 14.14.

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

### Resources that Create and Edit Sub-resources

Some resources create and edit other resources. In Unified Mode, the resource parses a codeblock that creates or edits a sub-resource and immediately applies that change, which will result in the execution of an incomplete resource.

For example, with unified mode enabled, this code from the _dhcp cookbook_ that creates a resource and
subsequently edits it will not work as expected:

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

Another solution is to is declaring the resource as `action :nothing` and then explicitly run it:

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

## Unified Mode Delays Immediate Notifications to Later Resources

Since Unified Mode is one pass, immediate notifications to resources that have not yet been parsed cannot be executed. Those notifications are now saved and executed when the resource is parsed. This could cause subtle changes in behaviors in some resources. The common idiom of chaining immediate notifications forward will result in the same behavior:

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

Even with this pattern, shuffling the resources in any arbitrary order will result in the same behavior in Unified Mode since the notification chain will still fire in the same order, and either the target resource will be already parsed and fire immediately or else will be fired when the resource is parsed.

We are unaware of any common pattern of writing a resource that would be broken by this behavior of Unified Mode.

The behavior of immediate notifications to prior resources and the behavior of delayed notification is unchanged.

## Unified Mode Can Break Resources Intended to Have Out Of Order Execution

Unified Mode does fundamentally alter the execution of the resource so that it is one pass from the top to the bottom. If a resource was written previously to require out of execution so that compile-time statements later in the resource must be run before resources declared earlier than Unified Mode would break those resources.

In all the resources converted internally in Core Chef Infra this was not observed in any one of them. The more common finding was that the author of the resource intended code to be executed in order but was unaware that it was executing out of order and enabling Unified Mode fixed those errors rather than introducing bugs.

Since the natural tendency of authors is to write resources so that they read in the same order to the author intends to have them execute we do not anticipate finding many resources broken by enabling Unified Mode, but it remains a possibility which is why there must be an action to use Unified Mode, and why we recommend testing.

## Unified Mode Breaks Before Notifications To Resources Declared Later

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

We are not aware of any examples of either of these patterns being used in community cookbooks at all, and we expect no impact to users, but this is included out of completeness.
