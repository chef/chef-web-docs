+++
title = "All Infra Resources"
draft = false
description = "This reference describes each of the resources available to Chef Infra Client, including a list of actions, properties, and usage examples."
gh_repo = "chef-web-docs"
aliases = ["/resource_reference.html", "/resources.html", "resource_examples.html", "/chef/resources.html"]
data_path = ["infra","resources"]
layout = "infra_resources_all"
toc_layout = "infra_resources_all_toc"
[cascade]
  product = ["client"]

[menu]
  [menu.infra]
    title = "All Resources (Single Page)"
    identifier = "chef_infra/resources/All Resources"
    parent = "chef_infra/resources"
    weight = 60
+++

<!-- The contents of this page are generated from the Markdown below and from YAML files in the data/infra/resources directory. -->
<!-- To suggest a change to the yaml data files, submit a pull request to the https://github.com/chef/chef repository. -->

<!-- NOTE: The Markdown in this page comes from the archetype file archetypes/all_the_resources.md. If you update the Markdown in this page,
you must also update the Markdown in the archetype page as well, otherwise your changes in this page may be overwritten. -->

<!-- markdownlint-disable-file -->

This reference describes each of the resources available to Chef Infra Client, including a list of actions, properties, and usage examples.

## Common Functionality

The properties and actions in this section apply to all resources.

### Actions

{{< readfile file="content/reusable/md/resources_common_actions.md" >}}

#### Examples

The following examples show how to use common actions in a recipe.

**Use the :nothing action**

{{< readfile file="content/reusable/md/resource_service_use_nothing_action.md" >}}

### Properties

The following properties are common to every resource:

`ignore_failure`
: **Ruby Type:** true, false | **Default Value:** `false`

  Continue running a recipe if a resource fails for any reason.

`retries`
: **Ruby Type:** Integer | **Default Value:** `0`

  The number of attempts to catch exceptions and retry the resource.

`retry_delay`
: **Ruby Type:** Integer | **Default Value:** `2`

  The retry delay (in seconds).

`sensitive`
: **Ruby Type:** true, false | **Default Value:** `false`

  Ensure that sensitive resource data is not logged by Chef Infra Client.

#### Examples

The following examples show how to use common properties in a recipe.

**Use the ignore_failure common property**

{{< readfile file="content/reusable/md/resource_package_use_ignore_failure_attribute.md" >}}

**Use the retries and retry_delay common properties**

{{< readfile file="content/reusable/md/resource_service_use_retries_properties.md" >}}

### Guards

{{< readfile file="content/reusable/md/resources_common_guards.md" >}}

#### Properties

{{< readfile file="content/reusable/md/resources_common_guards_properties.md" >}}

#### Arguments

{{< readfile file="content/reusable/md/resources_common_guards_arguments.md" >}}

#### not_if Examples

The following examples show how to use `not_if` as a condition in a recipe:

**Create a file, but not if an attribute has a specific value**

The following example shows how to use the `not_if` condition to create
a file based on a template and using the presence of an attribute value
on the node to specify the condition:

```ruby
template '/tmp/somefile' do
  mode '0755'
  source 'somefile.erb'
  not_if { node['some_value'] }
end
```

**Create a file with a Ruby block, but not if "/etc/passwd" exists**

The following example shows how to use the `not_if` condition to create
a file based on a template and then Ruby code to specify the condition:

```ruby
template '/tmp/somefile' do
  mode '0755'
  source 'somefile.erb'
  not_if do
    ::File.exist?('/etc/passwd')
  end
end
```


**Create a file with Ruby block that has curly braces, but not if "/etc/passwd" exists**

The following example shows how to use the `not_if` condition to create
a file based on a template and using a Ruby block (with curly braces) to
specify the condition:

```ruby
template '/tmp/somefile' do
  mode '0755'
  source 'somefile.erb'
  not_if { ::File.exist?('/etc/passwd') }
end
```

**Create a file using a string, but not if "/etc/passwd" exists**

The following example shows how to use the `not_if` condition to create
a file based on a template and using a string to specify the condition:

```ruby
template '/etc/some_config' do
  mode '0640'
  source 'some_config.erb'
  not_if 'some_app --check-config'
end
```

#### only_if Examples

The following examples show how to use `only_if` as a condition in a recipe:

**Create a file, but only if an attribute has a specific value**

The following example shows how to use the `only_if` condition to create
a file based on a template and using the presence of an attribute on the
node to specify the condition:

```ruby
template '/tmp/somefile' do
  mode '0755'
  source 'somefile.erb'
  only_if { node['some_value'] }
end
```

**Create a file with a Ruby block, but only if "/etc/passwd" does not exist**

The following example shows how to use the `only_if` condition to create
a file based on a template, and then use Ruby to specify a condition:

```ruby
template '/etc/some_app/some_config' do
  mode '0640'
  source 'some_config.erb'
  only_if { ::File.exist?('/etc/some_app/') }
end
```

**Create a file using a string, but only if "/etc/passwd" exists**

The following example shows how to use the `only_if` condition to create
a file based on a template and using a string to specify the condition:

```ruby
template '/tmp/somefile' do
  mode '0755'
  source 'somefile.erb'
  only_if 'test -f /etc/passwd'
end
```

### Guard Interpreters

{{< readfile file="content/reusable/md/resources_common_guard_interpreter.md" >}}

#### Attributes

{{< readfile file="content/reusable/md/resources_common_guard_interpreter_attributes.md" >}}

#### Inheritance

{{< readfile file="content/reusable/md/resources_common_guard_interpreter_attributes_inherit.md" >}}

#### Examples

{{< readfile file="content/reusable/md/resources_common_guard_interpreter_example_default.md" >}}

### Lazy Evaluation

{{< readfile file="content/reusable/md/resources_common_lazy_evaluation.md" >}}

### Notifications

{{< readfile file="content/reusable/md/resources_common_notification.md" >}}

#### Timers

{{< readfile file="content/reusable/md/resources_common_notification_timers.md" >}}

#### Notifies

{{< readfile file="content/reusable/md/resources_common_notification_notifies.md" >}}

{{< readfile file="content/reusable/md/resources_common_notification_notifies_syntax.md" >}}

##### Examples

The following examples show how to use the `notifies` notification in a recipe.

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

#### Subscribes

{{< readfile file="content/reusable/md/resources_common_notification_subscribes.md" >}}

{{< readfile file="content/reusable/md/resources_common_notification_subscribes_syntax.md" >}}

##### Examples

The following examples show how to use the `subscribes` notification in a recipe.

**Prevent restart and reconfigure if configuration is broken**

{{< readfile file="content/reusable/md/resource_execute_subscribes_prevent_restart_and_reconfigure.md" >}}

**Reload a service using a template**

{{< readfile file="content/reusable/md/resource_service_subscribes_reload_using_template.md" >}}

**Stash a file in a data bag**

The following example shows how to use the **ruby_block** resource to
stash a BitTorrent file in a data bag so that it can be distributed to
nodes in the organization.

```ruby
# the following code sample comes from the ``seed`` recipe
# in the following cookbook: https://github.com/mattray/bittorrent-cookbook

ruby_block 'share the torrent file' do
  block do
    f = File.open(node['bittorrent']['torrent'], 'rb')
    #read the .torrent file and base64 encode it
    enc = Base64.encode64(f.read)
    data = {
      'id' => bittorrent_item_id(node['bittorrent']['file']),
      'seed' => node['ipaddress'],
      'torrent' => enc,
    }
    item = Chef::DataBagItem.new
    item.data_bag('bittorrent')
    item.raw_data = data
    item.save
  end
  action :nothing
  subscribes :create, "bittorrent_torrent[#{node['bittorrent']['torrent']}]", :immediately
end
```

### Relative Paths

{{< readfile file="content/reusable/md/resources_common_relative_paths.md" >}}

#### Examples

{{< readfile file="content/reusable/md/resource_template_use_relative_paths.md" >}}

### Run in Compile Phase

{{< readfile file="content/reusable/md/resources_common_compile.md" >}}

#### run_action

{{< readfile file="content/reusable/md/resources_common_compile_begin.md" >}}

### Atomic File Updates

{{< readfile file="content/reusable/md/resources_common_atomic_update.md" >}}

### Windows File Security

{{< readfile file="content/reusable/md/resources_common_windows_security.md" >}}

**Access Control Lists (ACLs)**

{{< readfile file="content/reusable/md/resources_common_windows_security_acl.md" >}}

**Inheritance**

{{< readfile file="content/reusable/md/resources_common_windows_security_inherits.md" >}}

## Resources

The following resources are built into the Chef Infra Client:
