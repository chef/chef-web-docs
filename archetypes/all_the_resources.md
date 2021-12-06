+++
title = "All Infra Resources"
draft = false
description = "This reference describes each of the resources available to Chef Infra Client, including a list of actions, properties, and usage examples."
gh_repo = "chef-web-docs"
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

{{% resources_common_actions %}}

#### Examples

The following examples show how to use common actions in a recipe.

**Use the :nothing action**

{{% resource_service_use_nothing_action %}}

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

{{% resource_package_use_ignore_failure_attribute %}}

**Use the retries and retry_delay common properties**

{{% resource_service_use_retries_properties %}}

### Guards

{{% resources_common_guards %}}

#### Properties

{{% resources_common_guards_properties %}}

#### Arguments

{{% resources_common_guards_arguments %}}

#### not_if Examples

The following examples show how to use `not_if` as a condition in a recipe:

**Create a file, but not if an attribute has a specific value**

{{% resource_template_add_file_not_if_attribute_has_value %}}

**Create a file with a Ruby block, but not if "/etc/passwd" exists**

{{% resource_template_add_file_not_if_ruby %}}

**Create a file with Ruby block that has curly braces, but not if "/etc/passwd" exists**

{{% resource_template_add_file_not_if_ruby_with_curly_braces %}}

**Create a file using a string, but not if "/etc/passwd" exists**

{{% resource_template_add_file_not_if_string %}}

#### only_if Examples

The following examples show how to use `only_if` as a condition in a recipe:

**Create a file, but only if an attribute has a specific value**

{{% resource_template_add_file_only_if_attribute_has_value %}}

**Create a file with a Ruby block, but only if "/etc/passwd" does not exist**

{{% resource_template_add_file_only_if_ruby %}}

**Create a file using a string, but only if "/etc/passwd" exists**

{{% resource_template_add_file_only_if_string %}}

### Guard Interpreters

{{% resources_common_guard_interpreter %}}

#### Attributes

{{% resources_common_guard_interpreter_attributes %}}

#### Inheritance

{{% resources_common_guard_interpreter_attributes_inherit %}}

#### Examples

{{% resources_common_guard_interpreter_example_default %}}

### Lazy Evaluation

{{% resources_common_lazy_evaluation %}}

### Notifications

{{% resources_common_notification %}}

#### Timers

{{% resources_common_notification_timers %}}

#### Notifies

{{% resources_common_notification_notifies %}}

{{% resources_common_notification_notifies_syntax %}}

##### Examples

The following examples show how to use the `notifies` notification in a recipe.

**Delay notifications**

{{% resource_template_notifies_delay %}}

**Notify immediately**

{{% resource_template_notifies_run_immediately %}}

**Notify multiple resources**

{{% resource_template_notifies_multiple_resources %}}

**Notify in a specific order**

{{% resource_execute_notifies_specific_order %}}

**Reload a service**

{{% resource_template_notifies_reload_service %}}

**Restart a service when a template is modified**

{{% resource_template_notifies_restart_service_when_template_modified %}}

**Send notifications to multiple resources**

{{% resource_template_notifies_send_notifications_to_multiple_resources %}}

**Execute a command using a template**

{{% resource_execute_command_from_template %}}

**Restart a service, and then notify a different service**

{{% resource_service_restart_and_notify %}}

**Restart one service before restarting another**

{{% resource_before_notification_restart %}}

**Notify when a remote source changes**

{{% resource_remote_file_transfer_remote_source_changes %}}

#### Subscribes

{{% resources_common_notification_subscribes %}}

{{% resources_common_notification_subscribes_syntax %}}

##### Examples

The following examples show how to use the `subscribes` notification in a recipe.

**Prevent restart and reconfigure if configuration is broken**

{{% resource_execute_subscribes_prevent_restart_and_reconfigure %}}

**Reload a service using a template**

{{% resource_service_subscribes_reload_using_template %}}

**Stash a file in a data bag**

{{% resource_ruby_block_stash_file_in_data_bag %}}

### Relative Paths

{{% resources_common_relative_paths %}}

#### Examples

{{% resource_template_use_relative_paths %}}

### Run in Compile Phase

{{% resources_common_compile %}}

#### run_action

{{% resources_common_compile_begin %}}

### Atomic File Updates

{{% resources_common_atomic_update %}}

### Windows File Security

{{% resources_common_windows_security %}}

**Access Control Lists (ACLs)**

{{% resources_common_windows_security_acl %}}

**Inheritance**

{{% resources_common_windows_security_inherits %}}

## Resources

The following resources are built into the Chef Infra Client:
