+++
title = "About Unified Mode"
draft = false

gh_repo = "chef-web-docs"
product = ["client"]

[menu]
  [menu.infra]
    identifier = "chef_infra/resources/unified_mode.md Use Unified Mode"
    parent = "chef_infra/resources"
    weight = 20
+++

{{% unified_mode %}}
[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/unified_mode.md)

## Unified Mode

Unified mode is a setting which eliminates the distinction between the compile and converge modes
in the way that Chef Infra recipe and resources are parsed.  The setting replaces Chef Infra's two pass
parsing with single pass parsing, so that resources are executed as soon as they are declared.

This results in considerably clearer code, with considerably less Ruby knowledge required to understand
the order of operations.

### Unified Mode for Custom Resources

Unified mode can be turned on for a resource, with the `unified_mode` method, which takes a Boolean argument:

```ruby
unifed_mode true

provides :my_resource_name

action :run do
  # implementation code goes here
end
```

### Unified Mode for Recipe Code

This has not yet been written, so there is no setting for this yet.  It is planned to be delivered in 2020.
Currently, `unified_mode` can only be set for resources.

### Unified Mode Isolation

If a `unified_mode` resource calls a non-`unified_mode` resource the called resource is not executed in
`unified_mode`.  Each resource maintains its own state as being in `unified_mode` or not.  Custom
Resources do not need to worry about if their calling state is in `unified_mode` or not since that
calling context will not affect the resources execution.  Resources using `unified_mode` may call
resources not using `unified_mode` and vice versa.

## Benefits of Unified Mode

### Single Pass Execution

In Unified Mode the Chef Infra Language executes from top to bottom, eliminating the compile and converge phases.

With the deferred execution of resources to converge time, the user has to understand many different details
of the Ruby parser to understand what constructs relate to Chef Resources and what constructs are parts of
the core Ruby language to determine when those expression are executed.  All of that complexity is removed
in Unified Mode.

### Elimination of Lazy Constructs

Several aspects of the Chef Language still work, but are no longer useful in Unified Mode.  The need for
`lazy` blocks is entirely eliminated.  The need to lazy ruby code via a `ruby_block` is also eliminated.

### Rescue Blocks And Other Ruby Constructs Work Correctly

In `unifed_mode` it is now easy to write a rescue wrapper around a Chef resource:

```ruby
begin
  execute "a command that fails" do
    command "/bin/false"
  end
rescue Mixlib::ShellOut::ShellCommandFailed => e
  raise "failing because /bin/false returned a failed exit status"
end
```

## Examples of Unified Mode Advantages

### Simple Example

A simple motivating example is to have a resource which downloads a JSON message using the `remote_file` resource, parses the
JSON and then renders a value into a `file` or `template` resource.

Without `unified_mode` correctly writing this simple resource is complicated:

```ruby
provides :downloader

action :doit do

  remote_file "/tmp/users.json" do
    source "https://jsonplaceholder.typicode.com/users"
  end

  array = nil

  ruby_block "convert" do
    block do
      array = FFI_Yajl::Parser.parse(IO.read("/tmp/users.json"))
    end
  end

  file "/tmp/phone" do
    content lazy { array.last["phone"] }
  end
end
```

Since the `remote_file` and `file` resources execute at converge time, the ruby code to parse the JSON needs to be wrapped in a
`ruby_block` resource, the local variable then needs to be declared outside of that scope (requiring a fairly deep knowledge of
ruby variable scoping rules) and then the content rendered into the `file` resource must be wrapped with `lazy` since the ruby
parses all arguments of properties at compile time instead of converge time.

Using `unified_mode` this resource is greatly simplified:

```ruby
unified_mode true

provides :downloader

action :doit do
  remote_file "/tmp/users.json" do
    source "https://jsonplaceholder.typicode.com/users"
  end

  array = FFI_Yajl::Parser.parse(IO.read("/tmp/users.json"))

  file "/tmp/phone" do
    content array.last["phone"]
  end
end
```

The need for the `ruby_block`, the `lazy` and the variable declaration are all removed, and all that is left is how a beginning
programmer would attempt to write this resource without the need for deep Chef or Ruby knowledge.

### Recovery and Exception Handling

Another advantage is in error recovery and the use of rescue:

```
unified_mode true

provides :redis_install

action :install do
  version = "5.0.5"

  # the downloading of this file acts as a guard for all the later
  # resources -- but if the download is successful while the later
  # resources fail for some transient issue, will will not redownload on
  # the next run -- we lose our edge trigger.
  #
  remote_file "/tmp/redis-#{version}.tar.gz" do
    source "http://download.redis.io/releases/redis-#{version}.tar.gz"
    notifies :run, "execute[unzip_redis_archive]", :immediately
  end

  begin
    execute "unzip_redis_archive" do
      command "tar xzf redis-#{version}.tar.gz"
      cwd "/tmp"
      action :nothing
      notifies :run, "execute[build_and_install_redis]", :immediately
    end

    execute "build_and_install_redis" do
      command 'make && make install'
      cwd "/tmp/redis-#{version}"
      action :nothing
    end
  rescue Exception
    file "/tmp/redis-#{version}.tar.gz" do
      action :delete
    end
    raise
  end
end
```

This simplified example shows how to trap exceptions from resources using normal ruby syntax and to clean up the resource.  Without
`unified_mode` this syntax is not possible. Normally the `execute` resources when they are parsed only creates the objects in the
`resource_collection` to later be evaluated so that no exception is thrown while ruby is parsing the `action` block at all.  Every
action is delayed to the later converge phase.   In `unified_mode` the resource runs when ruby is done parsing its block, so exceptions
happen in-line with ruby parsing, so the `rescue` now works as naively expected.

The usefulness of this is that if the tar extraction throws an exception (for example, it could be out of disk space), then that Exception causes
the tar file to be deleted and then redownloaded the next time `chef-client` is run.  Without the cleanup the tar file would exist, but
the resource would not have completed, the extraction would not happen and the resource would be left in a broken, indeterminate state.

## Converting Resources to Unified Mode

## Unified Mode and Notifications

Most Chef notification idioms continue to work exactly or nearly identically to how they worked without `unified_mode`, but there are
a few notable exceptions which are due to the fact that `unified_mode` is now one-pass.  This means that the resources are evaluated
only once and the target resource of a notification may or may not have been parsed already.  The implementation of `unified_mode`
does a lot of work to make it so that nearly all uses cases will still work unmodified, but there are some issues that users should
be aware of.

There are 12 different notification cases to consider between two resources.  There are three different notifications types:
`:immediate`, `:delayed` and `:before`.  There are also two different ways to do notifications using either `notifies` or `subscribes`.
Then the two resources involved in the notification may be declared one way, or their ordering may be reversed.  The product of all
those gives 12 combinations.  Many of them are very similar however.

### Delayed Notifications Work Identically

Since delayed notifications involve a later phase of execution they work identically the same.  If a delayed notification is encountered
and the other resource has not yet been parsed yet, only a string label is used internally to reference the resource.  Before the
execution of the delayed notification phase all labels are resolved to the declared resources.

``` ruby
# delayed notification to a previously declared resource works identically
service "ntpd" do
  action :nothing
end

template "/etc/ntp/ntpd.conf" do
  source "ntpd.conf.erb"
  notifies :restart, 'service[ntpd]', :delayed
end
```

``` ruby
# delayed subscribes to a subsequently declared resource works identically
service "ntpd" do
  action :nothing
  subscribes :restart, 'template[/etc/ntp/ntpd.conf]', :delayed
end

template "/etc/ntp/ntpd.conf" do
  source "ntpd.conf.erb"
end
```

``` ruby
# delayed notification to a subsequently declared resource works identically
template "/etc/ntp/ntpd.conf" do
  source "ntpd.conf.erb"
  notifies :restart, 'service[ntpd]', :delayed
end

service "ntpd" do
  action :nothing
end
```

``` ruby
# delayed subscribes to a subsequently declared resource works identically
template "/etc/ntp/ntpd.conf" do
  source "ntpd.conf.erb"
end

service "ntpd" do
  action :nothing
  subscribes :restart, 'template[/etc/ntp/ntpd.conf]', :delayed
end
```

### Immediate Notifications To Previous Resource Work Identically

When a resource notifies a resource which has already been declared this works trivially as before
since when parsing the second resource, the first resource has already been parsed and is available
to be notified.

``` ruby
# immediate notification to a previously declared resource works identically
service "ntpd" do
  action :nothing
end

template "/etc/ntp/ntpd.conf" do
  source "ntpd.conf.erb"
  notifies :restart, 'service[ntpd]', :immediate
end
```

When a resource subscribes to a resource which is later declared this also works the same way as
before, and this is exactly comparable to the above use case.  While the subscribes line references
a resource that has not yet been declared, by the time the template resource updates, then the
service resource has been declared.

``` ruby
# immediate subscribes to a subsequently declared resource works identically
service "ntpd" do
  action :nothing
  subscribes :restart, 'template[/etc/ntp/ntpd.conf]', :immediate
end

template "/etc/ntp/ntpd.conf" do
  source "ntpd.conf.erb"
end
```

### Immediate Notifications To Subsequent Resource Works (with caveats)

The behavior of an immediate notification to a subsequent resource still works, but it is not possible
to maintain identical "immediate" semantics.  Instead the target resource is fired immediately when the
subsequent resource is parsed.

If there were other resources in between the two resources, the order of execution will change.

``` ruby
# immediate notification to a previously declared resource fires when the resource is parsed
template "/etc/ntp/ntpd.conf" do
  source "ntpd.conf.erb"
  notifies :restart, 'service[ntpd]', :immediate
end

# any resource declared in between the two resources will now fire before the "immediate" resource fires

service "ntpd" do
  action :nothing
end
```

Similarly an immediate subscribes to the prior resource will not fire until the service resource is
parsed.  With the subscribes syntax it may be easier to understand that the immediate subscription cannot
fire until the resource that does the subscription is parsed.  With the old two-pass model as the template
resource was updated it would then immediately execute the service resource before jumping back and continuing
processing any resources in between the two resources in the `resource_collection`.

``` ruby
# immediate notification to a previously declared resource fires when the resource is parsed
template "/etc/ntp/ntpd.conf" do
  source "ntpd.conf.erb"
end

# any resource declared in between the two resources will now fire before the "immediate" resource fires

service "ntpd" do
  action :nothing
  subscribes :restart, 'template[/etc/ntp/ntpd.conf]', :immediate
end
```

It is not possible to notify a resource before it has been parsed in `unified_mode` so total backwards compatibility
could not be preserved.  This is still a useful feature since simple forward immediate notifications to a sequence
of resources will still work, and does not require rewriting the sequence of resources backward.  

### Before Notifications to Previous Resource Works

A before notification to a prior declared resource (or a before subscribes to a later declared resource) works identically
with `unified_mode` set.   Since the resource is parsed first, it can be notified before the signaling
resource runs, and everything works as expected.

### Before Notifications to Subsequent Resource is Broken

A before notification to a later declared resource is a hard API break in `unified_mode` and cannot be made to work short of
rearranging the resources to declare the notified resource first.  A before subscribes to an earlier declared resource is also
broken (mentioned here for completeness since it is not likely to have ever been used).

### Notifications and Accumulators

The Accumulator pattern works unchanged.  Notifications to the `:root` run context still behave identically.  Since the compile and
converge phases of Custom Resources both fire in the converge time (typically) of the enclosing `run_context` the effect of eliminating
the separate compile and converge phases of the Custom Resource has no visible effect from the outer context.
