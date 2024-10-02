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

{{< readfile file="content/reusable/md/unified_mode_overview.md" >}}

{{< readfile file="content/reusable/md/unified_mode_client_releases.md" >}}

## Enable Unified Mode

{{< readfile file="content/reusable/md/unified_mode_enable.md" >}}

## Unified Mode isolation

If a Unified Mode resource calls a non-Unified Mode resource, the called resource is not executed in Unified Mode. Each resource maintains its own state whether it is in Unified Mode or not. You do not need to modify a custom resource that calls a Unified Mode resource since the calling context will not affect the resource's execution. Resources using Unified Mode may call resources not using Unified Mode and vice versa.

## Benefits of Unified Mode

### Single-pass execution

In Unified Mode, the Chef Infra Language executes from top to bottom, eliminating the compile and converge phases.

With the deferred execution of resources to converge time, the user has to understand many different details of the Ruby parser to understand what constructs relate to Chef Infra resources and what constructs are parts of the core Ruby language to determine when those expression are executed. All that complexity is removed in Unified Mode.

### Elimination of lazy blocks

Several aspects of the Chef Infra Language still work but are no longer necessary in Unified Mode. Unified Mode eliminates the need for lazy blocks and the need to lazy Ruby code through a Ruby block.

### Rescue blocks and other Ruby constructs work correctly

In Unified Mode, it is now easy to write a rescue wrapper around a Chef Infra resource:

```ruby
begin
  execute "a command that fails" do
    command "/bin/false"
  end
rescue Mixlib::ShellOut::ShellCommandFailed => e
  raise "failing because /bin/false returned a failed exit status"
end
```

## Examples

### Basic example

A simple motivating example is to have a resource that downloads a JSON message using the [remote_file]({{< relref "/resources/remote_file" >}}) resource, parse the JSON using the [ruby_block]({{< relref "/resources/ruby_block" >}}), and then render a value into a [file]({{< relref "/resources/file" >}}) or [template]({{< relref "/resources/template" >}}) resource.

Without Unified Mode, correctly writing this simple resource is complicated:

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

Since the remote_file and file resources execute at converge time, the Ruby code to parse the JSON needs to be wrapped in a `ruby_block` resource, the local variable then needs to be declared outside of that scope (requiring a deep knowledge of Ruby variable scoping rules), and then the content rendered into the file resource must be wrapped with `lazy` since the Ruby parses all arguments of properties at compile time instead of converge time.

Unified Mode simplifies this resource:

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

Unified Mode eliminates the need for the `ruby_block` resource, the `lazy` evaluation, and the variable declaration, simplifying how the cookbook is authored.

### Recovery and exception handling

Another advantage is in error recovery and the use of rescue.

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

This simplified example shows how to trap exceptions from resources using normal Ruby syntax and to clean up the resource. Without Unified Mode, this syntax is impossible. Normally when the [execute]({{< relref "resources/execute" >}}) resources are parsed, they only create the objects in the `resource_collection` to later be evaluated so that no exception is thrown while Ruby is parsing the `action` block. Every action is delayed to the later converge phase. In Unified Mode, the resource runs when Ruby is done parsing its block, so exceptions happen in-line with Ruby parsing and the rescue clause now works as expected.

This is useful because the TAR extraction throws an exception (for example, the node could be out of disk space), which deletes the TAR file. The next time Chef Infra Client runs, the TAR file will be redownload. If the resource did not have file cleanup after an exception, the TAR file would remain on the client node even though the resource is not complete and the extraction did not happen, leaving the resource in a broken, indeterminate state.

{{< readfile file="content/reusable/md/unified_mode_actions_later_resources.md" >}}

### Notifications and accumulators

The accumulator pattern works unchanged. Notifications to the `:root` run context still behave identically. Since the compile and converge phases of custom resources both fire in the converge time (typically) of the enclosing `run_context`, the effect of eliminating the separate compile and converge phases of the custom resource has no visible effect from the outer context.

{{< readfile file="content/reusable/md/unified_mode_troubleshooting.md" >}}
