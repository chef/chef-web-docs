+++
title = "Deprecation: Enabling Unified Mode (CHEF-33)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"


aliases = "/deprecations_unified_mode.html"
+++

Starting in Chef Infra Client 17.0 resources should be converted to use Unified Mode, which eliminates the split between the compile and converge modes in the specific resource where it is declared.

Unified Mode has been available starting with Chef Infra Client 14.14.14, Chef Infra Client 15.3.14, and Chef Infra Client 16.0.

Unified Mode is a setting which is local to the resource it is declared inside, and it does not affect calling recipes or resources, and does not affect any sub-resources which are used.

The default behavior of Chef Infra Client 17 is that resources do not run in Unified Mode, which is the same behavior as explicitly setting the Unified Mode flag to false. Resources will continue to run the say way, but a message will be emitted warning that those resources should be converted.

## Enabling Unified Mode

Most resources can be converted to use Unified Mode with no work, apart from testing, by adding the flag to turn it on anywhere in the resource declaration:

```ruby
unified_mode true

provides :myresource

actions :run do
  [...]
end
```

For the vast majority of resources, no further action should be required aside from testing and validation.

## Unified Mode Delays Immediate Notifications to Later Resources

Since Unified Mode is one pass, immediate notifications to resources which have not yet been parsed cannot be executed. Those notifications are now saved and executed when the resource is parsed. This could cause subtle changes in behaviors in some resources. The common idiom of chaining immediate notifications forward will result in the same behavior:

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

We are unaware of any common pattern of writing a resource which would be broken by this behavior of Unified Mode.

The behavior of immediate notifications to prior resources and the behavior of delayed notification is unchanged.

## Unified Mode Can Break Resources Intended to Have Out Of Order Execution

Unified Mode does fundamentally alter the execution of the resource so that it is one pass from the top to the bottom. If a resource was written previously to require out of execution so that compile time statements later in the resource must be run before resources declared earlier than Unified Mode would break those resources.

In all the resources converted internally in Core Chef Infra this was not observed in any one of them. The more common finding was that the author of the resource intended code to be executed in order but was unaware that it was executing out of order and enabling Unified Mode fixed those errors rather than introducing bugs.

Since the natural tendency of authors is to write resources so that they read in the same order to the author intends to have them execute we do not anticipate to find many resources broken by enabling Unified Mode, but it remains a possibility which is why there must be an action to use Unified Mode, and why we recommend testing.

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

The same is true pre-declarations of resources which subscribe to a before notification of later resources which must be moved to a post-declaration.

We are not aware of any examples of either of these patterns being used in community cookbooks at all, and we expect no impact to users, but this is included out of completeness.
