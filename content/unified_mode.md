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

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/unified_mode.md)

Unified mode is a setting which eliminates the distinction between the compile and converge modes in the way that Chef Infra recipe and resources are parsed. The setting replaces Chef Infra's two pass parsing with single pass parsing, so that resources are executed as soon as they are declared.

This results in considerably clearer code, with considerably less Ruby knowledge required to understand the order of operations.

## Unified Mode for Custom Resources

Unified mode can be turned on for a resource, with the `unified_mode` method, which takes a Boolean argument:

```ruby
unifed_mode true

provides :my_resource_name

action :run do
  # implementation code goes here
end
```

## Unified Mode for Recipe Code

This has not yet been written, so there is no setting for this yet. It is planned to be delivered in 2020.
Currently, `unified_mode` can only be set for resources.

## Unified Mode Isolation

If a `unified_mode` resource calls a non-`unified_mode` resource the called resource is not executed in `unified_mode`. Each resource maintains its own state as being in `unified_mode` or not. Custom Resources do not need to worry about if their calling state is in `unified_mode` or not since that calling context will not affect the resources execution. Resources using `unified_mode` may call resources not using `unified_mode` and vice versa.

## Benefits of Unified Mode

### Single Pass Execution

In Unified Mode the Chef Infra Language executes from top to bottom, eliminating the compile and converge phases.

With the deferred execution of resources to converge time, the user has to understand many different details of the Ruby parser to understand what constructs relate to Chef Infra Resources and what constructs are parts of the core Ruby language to determine when those expression are executed. All that complexity is removed
in Unified Mode.

### Elimination of Lazy Constructs

Several aspects of the Chef Infra Language still work, but are no longer useful in Unified Mode. The need for `lazy` blocks is entirely eliminated. The need to lazy ruby code via a `ruby_block` is also eliminated.

### Rescue Blocks And Other Ruby Constructs Work Correctly

In `unified_mode` it is now easy to write a rescue wrapper around a Chef Infra resource:

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

A simple motivating example is to have a resource which downloads a JSON message using the `remote_file` resource, parses the JSON and then renders a value into a `file` or `template` resource.

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

Since the `remote_file` and `file` resources execute at converge time, the ruby code to parse the JSON needs to be wrapped in a `ruby_block` resource, the local variable then needs to be declared outside of that scope (requiring a fairly deep knowledge of ruby variable scoping rules) and then the content rendered into the `file` resource must be wrapped with `lazy` since the ruby parses all arguments of properties at compile time instead of converge time.

Using `unified_mode` this resource is simplified:

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

The need for the `ruby_block`, the `lazy` and the variable declaration are all removed, and all that is left is how a beginning programmer would attempt to write this resource without the need for deep Chef Infra or Ruby knowledge.

### Recovery and Exception Handling

Another advantage is in error recovery and the use of rescue:

```ruby
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

This simplified example shows how to trap exceptions from resources using normal ruby syntax and to clean up the resource. Without `unified_mode` this syntax is impossible. Normally the `execute` resources when they are parsed only creates the objects in the `resource_collection` to later be evaluated so that no exception is thrown while ruby is parsing the `action` block at all. Every action is delayed to the later converge phase. In `unified_mode` the resource runs when ruby is done parsing its block, so exceptions happen in-line with ruby parsing, so the `rescue` now works as naively expected.

The usefulness of this is that if the tar extraction throws an exception (for example, it could be out of disk space), then that Exception causes the tar file to be deleted and then redownloaded the next time `chef-client` is run. Without the cleanup the tar file would exist, but the resource would not have completed, the extraction would not happen and the resource would be left in a broken, indeterminate state.

[NOTE: UNIFIED MODE SHORTCODE STARTS HERE]

{{% unified_mode %}}

### Notifications and Accumulators

The Accumulator pattern works unchanged. Notifications to the `:root` run context still behave identically. Since the compile and converge phases of Custom Resources both fire in the converge time (typically) of the enclosing `run_context` the effect of eliminating the separate compile and converge phases of the Custom Resource has no visible effect from the outer context.

