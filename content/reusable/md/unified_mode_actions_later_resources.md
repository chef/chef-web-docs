
## Actions on Later Resources

Since unified mode executes your resource as it is compiled, `:immediate` notifications that execute later resources are handled differently than in the past.

### `:immediate` Notifications to Later Resources

Unified mode delays immediate notifications to later resources.
In unified mode, the Chef Infra Client saves immediate notifications and executes them when the later resource is parsed. Immediate notifications to prior resources and delayed notifications behave the same as they did before unified mode.

The end result of sequentially chaining immediate notifications is the same as before unified mode. Instead of immediately notifying results, the notifications fire _in order_ as they are parsed, which has the same outcome. If the parse order and the intended execution order are different, then the results may be different and are a reflection of the parse order.

The changes to sending immediate notification could result in subtle changes to behaviors in some resources, but it is not a breaking change to common patterns of writing resources.

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

### Out of Order Execution

Unified mode breaks custom resources that rely on the out-of-order execution of compile-time statements. Move any affected compile-time statements to the location in the code where they are intended to execute.

Out-of-order execution is rare. Internally at Chef, none of our custom resources broke during our migration to unified mode. Instead, we discovered a few cases in which custom resource code was intended to run in order, but Chef Infra Client executed it out of order. In these cases, unified mode fixed errors instead of introducing bugs.
