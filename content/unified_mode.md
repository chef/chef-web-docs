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
in the way that Chef recipe and resources are parsed.  The setting replaces Chef's two pass
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

In Unified Mode the Chef Language executes from top to bottom, eliminating the compile and converge phases.

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

## Converting Resources to Unified Mode

### Identification of Declared Sub-Resources

In order to safely convert Custom Resources to `unified_mode` is necessary to be able to read the Custom Resource and
determine if the Resource is doing its work entirely at compile time, or entirely at converge time, or via some more
complicated mix of compile and converge time.  The large majority of resources can be converted trivially to
`unified_mode` by simply setting `unified_mode true` and then confirming that tests of the resource pass.  Users are
encouraged, however, to scan and assess how their Custom Resources were written, and to make some modifications to
the Custom Resource to clean up no longer useful idioms.

Declared Sub-Resources are define as resources which are declared in the Custom Resource's `resource_collection` and are
run in the converge phase.  Resources declared normally via the Chef language (e.g. `file`, `template`, etc) are
declared sub-resources.  Resources which are declared using `declare_resource` (e.g. `declare_resource(:file,...)`) are
also declared sub-resources.

Examples of declared sub-resource:

``` ruby
action :run do
  # This is the typical of a properly declared sub-resource
  file "/tmp/file1.xyz" do
    contents "mycontents"
  end

  # This is an alternative way to properly declare a sub-resource
  declare_resource(:file, "/tmp/file2.xyz") do
    contents "mycontents"
  end
end
```

Resources forced to the compile phase (e.g. using `run_action(:create)`), resources built using `build_resource` (e.g.
`build_resource(:file, ...)` or resources built using the normal Ruby constructor (e.g. `Chef::Resource::File.new(..)`)
are not declared sub-resources since they are not doing work in the converge phase.

Examples of the use of Chef resources which are not declared sub-resources:

``` ruby
action :run do
  # This is a compile time resource
  file "/tmp/file3.xyz" do
    contents "mycontents"
    action :nothing
  end.run_action(:create)

  # This is a "built" and not a "declared" resource
  build_resource(:file, "/tmp/file4.xyz") do
    contents "mycontents"
  end.run_action(:create)

  # This is a "built" and not a "declared" resource
  file_resource = Chef::Resource::File.new("/tmp/file5.xyz")
  file.resource.run_action(:create)

  # This is using the declared resource API but does not count
  # as a proper declared sub-resource due to forcing execution to compile time
  declare_resource(:file, "/tmp/file6.xyz") do
    contents "mycontents"
    action :nothing
  end.run_action(:create)
end
```

Any work done by ruby code inside a `converge_by` block is also clearly not a declared sub-resource, although they may
be declared inside of a `converge_by` block.  This is almost certainly code written by someone who misunderstood the
two-pass model and possibly a bug (although the resource may still work correctly if there is no other interaction).
This complexity is the kind of issue that `unified_mode` is expected to eliminate, since the sub-resource is only
declared when the `converge_by` block.

``` ruby
action_class do
  def should_create_file?
    ...
  end
end

action :run do
  if should_create_file?
    converge_by "creating a file" do
      # this counts as a subresource, and its action is deferred until later
      file "/tmp/file3.xyz" do
        contents "mycontents"
      end
    end
  end

  Chef::Log.warn "the file will be created after this line is output"
end
```

This pattern is usually a bug and the author intends the file resource to run when the `converge_by` block is being
parsed, which is not how Chef has behaved.  Unified mode will actually correct this execution order bug, so that the
`file` resource in this example does its work during the execution of the `converge_by` block.

Note, in general this mixing of resources inside of `converge_by` blocks is "code smell" and usually the `converge_by` block
is being used in an attempt to only provide logging, and the author was unaware of the way that the `converge_by` is intended
to be used to protect blocks against `why_run` mode and to dirty the updated status of the containing resource and to cause
any notification to fire, which is often not what the author intended.  Consider removing the `converge_by` block entirely
when this pattern is encountered.

### Resources Without Sub-Resources

Resources without any sub-resources do not strictly require any modification.  This is because they already do no work at
converge time, and the `resource_collection` of the Custom Resource is not being used.  These are resources written
"Chef-10 Style".

It is highly encouraged, however, that any resources which are being invoked at compile time through any of the methods
above (e.g. `Chef::Resource::File.new`) be converted to use the Chef language and become proper sub-resources.  This will
allow the Custom Resource to do notifications correctly.  The only exception being where the built resource is deliberately
not being placed in the resource collection to avoid causing the Custom Resource to fire notifications.

### Resource With Sub-Resources

Custom Resources that use Sub-Resources that are written with good style and do not mix proper Sub-Resources with out of order
ruby code and compile-time resources (most of them), do not require any modification.  This may, however, be difficult to determine
and proper testing will be essential.  Since all of the execution of the Sub-Resources move from the end of execution during the
compile time phase, into where they are actually declared resources may not behave exactly the same.

Once the resource has been converted to Unified Mode, additional cleanup can make the code considerably easier to read:

- Eliminate all `ruby_block` (or `whyrun_safe_ruby_block`) resources and just execute the code inside the block
- Eliminate all use of `lazy {}`
- In Chef Infra Client 16 calls to Chef::Log may be converted to log resources

### Notifications and Accumulators

The Accumulator pattern works unchanged.  Notifications to the `:root` run context still behave identically.  Since the compile and
converge phases of Custom Resources both fire in the converge time (typically) of the enclosing `run_context` the effect of eliminating
the separate compile and converge phases of the Custom Resource has no visible effect from the outer context.

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

### Before Notifications to Previous Resource Works


### Before Notifications to Subsequent Resource is Broken

