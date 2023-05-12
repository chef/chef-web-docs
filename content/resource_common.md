+++
title = "Common Resource Functionality"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/resource_common.html"]

[menu]
  [menu.infra]
    title = "Common Resource Functionality"
    identifier = "chef_infra/resources/resource_common.md Common Resource Functionality"
    parent = "chef_infra/resources"
    weight = 30
+++
<!-- markdownlint-disable-file MD036 -->

All resources (including custom resources) share a set of common
actions, properties, conditional executions, notifications, and relative
path options.

## Actions

The following actions may be used with any resource:

`:nothing`

: {{ readFile "layouts/shortcodes/resources_common_actions_nothing.md" | markdownify }}

### Examples

The following examples show how to use common actions in a recipe.

**Use the :nothing action**

{{< readfile file="content/reusable/md/resource_service_use_nothing_action.md" >}}

## Properties

{{< readfile file="content/reusable/md/resources_common_properties.md" >}}

### Examples

The following examples show how to use common properties in a recipe.

**Use the ignore_failure common property**

{{< readfile file="content/reusable/md/resource_package_use_ignore_failure_attribute.md" >}}

**Use the retries and retry_delay common properties**

{{< readfile file="content/reusable/md/resource_service_use_retries_properties.md" >}}

## Guards

{{< readfile file="content/reusable/md/resources_common_guards.md" >}}

{{< note >}}

When using the `not_if` and `only_if` guards with the **execute**
resource, the guard's environment is inherited from the resource's
environment. For example:

```ruby
execute 'bundle install' do
  cwd '/myapp'
  not_if 'bundle check' # This is run from /myapp
end
```

{{< /note >}}

### Properties

{{< readfile file="content/reusable/md/resources_common_guards_properties.md" >}}

### Arguments

{{< readfile file="content/reusable/md/resources_common_guards_arguments.md" >}}

### not_if Examples

**Update if not already updated**

The following example shows how to use `not_if` to guard against running
the `apt-get-update` command when a file already exists that is the same
as the updated file:

```ruby
execute 'apt-get-update' do
  command 'apt-get update'
  ignore_failure true
  not_if { ::File.exist?('/var/lib/apt/periodic/update-success-stamp') }
end
```

**Ensure a node can resolve a host**

The following example shows how to use a custom block of Ruby code to
ensure that a node can resolve the host. If the node can resolve the
host, Chef Infra Client will do nothing. If the node cannot resolve the
host, Chef Infra Client will configure the host:

```ruby
ruby_block 'ensure node can resolve API FQDN' do
  block do
    fe = Chef::Util::FileEdit.new('/etc/hosts')
    fe.insert_line_if_no_match(/#{node['chef-server']['api_fqdn']}/,
                               "127.0.0.1 #{node['chef-server']['api_fqdn']}")
    fe.write_file
  end
  not_if { Resolv.getaddress(node['chef-server']['api_fqdn']) rescue false }
end
```

**Prevent installs on older versions**

The following example shows how to use `not_if` to prevent ZeroMQ from
being installed when the node on which the install is to occur has a
version of Red Hat Enterprise Linux that is older than version 6.0:

```ruby
ark 'test_autogen' do
  url 'https://github.com/zeromq/libzmq/tarball/master'
  extension 'tar.gz'
  action :configure
  not_if { platform_family?('rhel') && node['platform_version'].to_f < 6.0 }
end
```

**Set the administrator if not already set**

The following example shows how to set the administrator for Nagios on
multiple nodes, except when the package already exists on a node:

```ruby
%w(adminpassword adminpassword-repeat).each do |setting|
  execute "debconf-set-selections::#{node['nagios']['server']['vname']}-cgi::#{node['nagios']['server']['vname']}/#{setting}" do
    command "echo #{node['nagios']['server']['vname']}-cgi #{node['nagios']['server']['vname']}/#{setting} password #{random_initial_password} | debconf-set-selections"
    not_if "dpkg -l #{node['nagios']['server']['vname']}"
  end
end
```

### only_if Examples

**Install packages only when necessary**

The following example shows how to use `only_if` with one (or more)
cookbook attributes to ensure that packages are only installed when
necessary. In this case, three attributes exist in the
`/attributes/default.rb` file: `use_openssl`, `use_pcre`, and
`use_zlib`. Each of these attributes are defined as `false` by default.
The `only_if` attributes are used to test for the presence of these
packages on the target node before then asking Chef Infra Client to
complete the process of installing these packages. If the packages are
already present, Chef Infra Client will do nothing.

```ruby
package 'libpcre3-dev' do
  only_if { node['haproxy']['source']['use_pcre'] }
end

package 'libssl-dev' do
  only_if { node['haproxy']['source']['use_openssl'] }
end

package 'zlib1g-dev' do
  only_if { node['haproxy']['source']['use_zlib'] }
end
```

**Remove a recipe if it belongs to a specific run-list**

The following example shows how to use `only_if` to only remove a recipe
named `recipe[ntp::undo]`, but only when that recipe is part of the
`recipe[ntp::default]` run-list:

```ruby
ruby_block 'remove ntp::undo from run list' do
  block do
    node.run_list.remove('recipe[ntp::undo]')
  end
  only_if { node.run_list.include?('recipe[ntp::default]') }
end
```

**Re-register ASP.Net if it is already installed**

The following example shows how to use `only_if` to ensure that Chef
Infra Client will attempt to register ASP.NET only if the executable is
installed on the system, on both 32- and 64-bit systems:

```ruby
aspnet_regiis = "#{ENV['WinDir']}\\Microsoft.NET\\Framework\\v4.0.30319\\aspnet_regiis.exe"
execute 'Register ASP.NET v4' do
  command "#{aspnet_regiis} -i"
  only_if { ::File.exist?(aspnet_regiis) }
  action :nothing
end

aspnet_regiis64 = "#{ENV['WinDir']}\\Microsoft.NET\\Framework64\\v4.0.30319\\aspnet_regiis.exe"
execute 'Register ASP.NET v4 (x64)' do
  command "#{aspnet_regiis64} -i"
  only_if { ::File.exist?(aspnet_regiis64) }
  action :nothing
end
```

## Guard Interpreters

{{< readfile file="content/reusable/md/resources_common_guard_interpreter.md" >}}

### Attributes

{{< readfile file="content/reusable/md/resources_common_guard_interpreter_attributes.md" >}}

### Inheritance

{{< readfile file="content/reusable/md/resources_common_guard_interpreter_attributes_inherit.md" >}}

### Examples

{{< readfile file="content/reusable/md/resources_common_guard_interpreter_example_default.md" >}}

## Lazy Evaluation

{{< readfile file="content/reusable/md/resources_common_lazy_evaluation.md" >}}

## Notifications

{{< readfile file="content/reusable/md/resources_common_notification.md" >}}

### Timers

{{< readfile file="content/reusable/md/resources_common_notification_timers.md" >}}

### Notifies

{{< readfile file="content/reusable/md/resources_common_notification_notifies.md" >}}

{{< readfile file="content/reusable/md/resources_common_notification_notifies_syntax.md" >}}

Changed in Chef Infra Client 12.6 to use `:before` timer with the `notifies`
and `subscribes` properties to specify that the action on a notified
resource should be run before processing the resource block in which the
notification is located.

#### Examples

The following examples show how to use the `notifies` notification in a
recipe.

**Delay notifications**

{{< readfile file="content/reusable/md/resource_template_notifies_delay.md" >}}

**Notify immediately**

{{< readfile file="content/reusable/md/resource_template_notifies_run_immediately.md" >}}

**Notify multiple resources**

{{< readfile file="content/reusable/md/resource_template_notifies_multiple_resources.md" >}}

**Notify in a specific order**

{{< readfile file="content/reusable/md/resource_execute_notifies_specific_order.md" >}}

**Reload a service**

{{< readfile file="content/reusable/md/resource_template_notifies_reload_service.md" >}}

**Restart a service when a template is modified**

{{< readfile file="content/reusable/md/resource_template_notifies_restart_service_when_template_modified.md" >}}

**Send notifications to multiple resources**

{{< readfile file="content/reusable/md/resource_template_notifies_send_notifications_to_multiple_resources.md" >}}

**Execute a command using a template**

{{< readfile file="content/reusable/md/resource_execute_command_from_template.md" >}}

**Restart a service, and then notify a different service**

{{< readfile file="content/reusable/md/resource_service_restart_and_notify.md" >}}

**Restart one service before restarting another**

{{< readfile file="content/reusable/md/resource_before_notification_restart.md" >}}

**Notify when a remote source changes**

{{< readfile file="content/reusable/md/resource_remote_file_transfer_remote_source_changes.md" >}}

### Subscribes

{{< readfile file="content/reusable/md/resources_common_notification_subscribes.md" >}}

{{< readfile file="content/reusable/md/resources_common_notification_subscribes_syntax.md" >}}

#### Examples

The following examples show how to use the `subscribes` notification in
a recipe.

**Verify a configuration update**

{{< readfile file="content/reusable/md/resource_execute_subscribes_prevent_restart_and_reconfigure.md" >}}

**Reload a service when a template is updated**

{{< readfile file="content/reusable/md/resource_service_subscribes_reload_using_template.md" >}}

## Relative Paths

{{< readfile file="content/reusable/md/resources_common_relative_paths.md" >}}

### Examples

{{< readfile file="content/reusable/md/resource_template_use_relative_paths.md" >}}

## Run in Compile Phase

{{< readfile file="content/reusable/md/resources_common_compile.md" >}}

### Using the compile_time property

{{< readfile file="content/reusable/md/resources_common_compile_begin.md" >}}

## Windows File Security

{{< readfile file="content/reusable/md/resources_common_windows_security.md" >}}

### Access Control Lists (ACLs)

{{< readfile file="content/reusable/md/resources_common_windows_security_acl.md" >}}

### Inheritance

{{< readfile file="content/reusable/md/resources_common_windows_security_inherits.md" >}}
