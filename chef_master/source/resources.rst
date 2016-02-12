=====================================================
Resources Reference
=====================================================

.. include:: ../../includes_resources_common/includes_resources_common.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_platform.rst

This reference describes each of the resources available to the |chef client|, including a list of actions, a list of properties, (when applicable) a list of providers, and examples of using each resource.


Common Functionality
=====================================================
The properties and actions in this section apply to all resources.

Actions
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_actions.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use common actions in a recipe.

**Use the :nothing action**

.. include:: ../../step_resource/step_resource_service_use_nothing_action.rst

Properties
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_attributes.rst

Provider
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use common properties in a recipe.

**Use the ignore_failure common property**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst

**Use the provider common property**

.. include:: ../../step_resource/step_resource_package_use_provider_attribute.rst

**Use the supports common property**

.. include:: ../../step_resource/step_resource_service_use_supports_attribute.rst

**Use the supports and providers common properties**

.. include:: ../../step_resource/step_resource_service_use_provider_and_supports_attributes.rst

Guards
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guards.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guards_attributes.rst

Arguments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guards_arguments.rst

not_if Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use ``not_if`` as a condition in a recipe:

**Create a file, but not if an attribute has a specific value**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_attribute_has_value.rst

**Create a file with a Ruby block, but not if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_ruby.rst

**Create a file with Ruby block that has curly braces, but not if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_ruby_with_curly_braces.rst

**Create a file using a string, but not if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_string.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

only_if Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use ``only_if`` as a condition in a recipe:

**Create a file, but only if an attribute has a specific value**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_attribute_has_value.rst

**Create a file with a Ruby block, but only if "/etc/passwd" does not exist**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_ruby.rst

**Create a file using a string, but only if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_string.rst

Guard Interpreters
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_attributes.rst

Inheritance
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_attributes_inherit.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_example_default.rst


Lazy Evaluation
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_lazy_evaluation.rst

Notifications
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_notifications.rst

Notifications Timers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

Notifies Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following examples show how to use the ``notifies`` notification in a recipe.

**Delay notifications**

.. include:: ../../step_resource/step_resource_template_notifies_delay.rst

**Notify immediately**

.. include:: ../../step_resource/step_resource_template_notifies_run_immediately.rst

**Enable a service after a restart or reload**

.. include:: ../../step_resource/step_resource_service_notifies_enable_after_restart_or_reload.rst

**Notify multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_multiple_resources.rst

**Notify in a specific order**

.. include:: ../../step_resource/step_resource_execute_notifies_specific_order.rst

**Reload a service**

.. include:: ../../step_resource/step_resource_template_notifies_reload_service.rst

**Restart a service when a template is modified**

.. include:: ../../step_resource/step_resource_template_notifies_restart_service_when_template_modified.rst

**Send notifications to multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_send_notifications_to_multiple_resources.rst

**Execute a command using a template**

.. include:: ../../step_resource/step_resource_execute_command_from_template.rst

**Restart a service, and then notify a different service**

.. include:: ../../step_resource/step_resource_service_restart_and_notify.rst

**Notify when a remote source changes**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst

Subscribes Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following examples show how to use the ``subscribes`` notification in a recipe.

**Prevent restart and reconfigure if configuration is broken**

.. include:: ../../step_resource/step_resource_execute_subscribes_prevent_restart_and_reconfigure.rst

**Reload a service using a template**

.. include:: ../../step_resource/step_resource_service_subscribes_reload_using_template.rst

**Stash a file in a data bag**

.. include:: ../../step_resource/step_resource_ruby_block_stash_file_in_data_bag.rst


Relative Paths
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_relative_paths.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_resource/step_resource_template_use_relative_paths.rst


Run in Compile Phase
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_compile.rst

run_action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_compile_begin.rst


Atomic File Updates
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_atomic_update.rst

Windows File Security
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_windows_security.rst

**Access Control Lists (ACLs)**

.. include:: ../../includes_resources_common/includes_resources_common_windows_security_acl.rst

**Inheritance**

.. include:: ../../includes_resources_common/includes_resources_common_windows_security_inherits.rst


Resources
=====================================================
The following resources are built-in to the |chef client|:

* apt_package (based on the package resource)
* bash
* batch
* bff_package (based on the package resource)
* breakpoint
* chef_gem (based on the package resource)
* chef_handler (available from the chef_handler cookbook)
* cookbook_file
* cron
* csh
* deploy (including |git| and |svn|)
* directory
* dpkg_package (based on the package resource)
* dsc_resource
* dsc_script
* easy_install_package (based on the package resource)
* env
* erl_call
* execute
* file
* freebsd_package (based on the package resource)
* gem_package (based on the package resource)
* git
* group
* homebrew_package (based on the package resource)
* http_request
* ifconfig
* ips_package (based on the package resource)
* link
* log
* macports_package (based on the package resource)
* mdadm
* mount
* ohai
* openbsd_package (based on the package resource)
* package
* pacman_package (based on the package resource)
* paludis_package (based on the package resource)
* perl
* portage_package (based on the package resource)
* powershell_script
* python
* reboot
* registry_key
* remote_directory
* remote_file
* route
* rpm_package (based on the package resource)
* ruby
* ruby_block
* script
* service
* smartos_package (based on the package resource)
* solaris_package (based on the package resource)
* subversion
* template
* user
* windows_package
* windows_service
* yum (based on the package resource)

See below for more information about each of these resources, their related actions and properties, and examples of how these resources can be used in recipes.

apt_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_apt.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_apt_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_apt_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_apt_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_apt_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package using package manager** 

.. include:: ../../step_resource/step_resource_apt_package_install_package.rst

**Install a package using local file** 

.. include:: ../../step_resource/step_resource_apt_package_install_package_using_local_file.rst

**Install without using recommend packages as a dependency**

.. include:: ../../step_resource/step_resource_apt_package_install_without_recommends_suggests.rst

bash
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_bash.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_bash_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_bash_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_bash_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_bash_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Use a named provider to run a script**

.. include:: ../../step_resource/step_resource_script_bash_provider_and_interpreter.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst


batch
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_batch.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_attributes.rst

Guards
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources_common/includes_resources_common_guards.rst

**Attributes**

.. include:: ../../includes_resources_common/includes_resources_common_guards_attributes.rst

**Arguments**

.. include:: ../../includes_resources_common/includes_resources_common_guards_arguments.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_batch_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Unzip a file, and then move it**

.. include:: ../../step_resource/step_resource_batch_unzip_file_and_move.rst


bff_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_bff.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_bff_package_install.rst




breakpoint
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_breakpoint.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_breakpoint_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**A recipe without a breakpoint**

.. include:: ../../step_resource/step_resource_breakpoint_no.rst

**The same recipe with breakpoints**

.. include:: ../../step_resource/step_resource_breakpoint_yes.rst


chef_gem
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_chef_gem.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_chef_gem_vs_gem_package.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chef_gem_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chef_gem_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chef_gem_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chef_gem_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a gems file for use in recipes**

.. include:: ../../step_resource/step_resource_chef_gem_install_for_use_in_recipes.rst

**Install MySQL for Chef**

.. include:: ../../step_resource/step_resource_chef_gem_install_mysql.rst



chef_handler
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_chef_handler.rst

Handler Types
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_types.rst

Exception / Report
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_type_exception_report.rst

.. include:: ../../includes_handler/includes_handler_type_exception_report_run_from_recipe.rst

Start
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_type_start.rst

.. include:: ../../includes_handler/includes_handler_type_start_run_from_recipe.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_chef_handler_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_chef_handler_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_chef_handler_attributes.rst


Custom Handlers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_custom.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_custom_syntax.rst

report Interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_custom_interface_report.rst

Optional Interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following interfaces may be used in a handler in the same way as the ``report`` interface to override the default handler behavior in the |chef client|. That said, the following interfaces are not typically used in a handler and, for the most part, are completely unnecessary for a handler to work properly and/or as desired.

**data**

.. include:: ../../includes_handler/includes_handler_custom_interface_data.rst

**run_report_safely**

.. include:: ../../includes_handler/includes_handler_custom_interface_run_report_safely.rst

**run_report_unsafe**

.. include:: ../../includes_handler/includes_handler_custom_interface_run_report_unsafe.rst

run_status Object
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_custom_object_run_status.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Enable the CloudkickHandler handler**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_enable_cloudkickhandler.rst

**Enable handlers during the compile phase**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_enable_during_compile.rst

**Handle only exceptions**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_exceptions_only.rst

**Cookbook Versions (a custom handler)**

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions.rst

cookbook_versions.rb:

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions_handler.rst

default.rb:

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions_recipe.rst

**JsonFile Handler**

.. include:: ../../includes_handler/includes_handler_custom_example_json_file.rst

**Register the JsonFile handler**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_register.rst

**ErrorReport Handler**

.. include:: ../../includes_handler/includes_handler_custom_example_error_report.rst




cookbook_file
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_cookbook_file.rst

.. include:: ../../includes_resources/includes_resource_cookbook_file_transfers.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cookbook_file_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cookbook_file_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cookbook_file_attributes.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_selinux_file_based_resources.rst
.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_cookbook_file_providers.rst
.. 

File Specificity
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_file/includes_file_cookbook_specificity.rst

.. include:: ../../includes_file/includes_file_cookbook_specificity_pattern.rst

.. include:: ../../includes_file/includes_file_cookbook_specificity_example.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Transfer a file**

.. include:: ../../step_resource/step_resource_cookbook_file_transfer_a_file.rst

**Handle cookbook_file and yum_package resources in the same recipe**

.. include:: ../../step_resource/step_resource_yum_package_handle_cookbook_file_and_yum_package.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Use a case statement**

.. include:: ../../step_resource/step_resource_cookbook_file_use_case_statement.rst


cron
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_cron.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cron_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cron_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cron_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_cron_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Run a program at a specified interval**

.. include:: ../../step_resource/step_resource_cron_run_program_on_fifth_hour.rst

**Run an entry if a folder exists**

.. include:: ../../step_resource/step_resource_cron_run_entry_when_folder_exists.rst

**Run every Saturday, 8:00 AM**

.. include:: ../../step_resource/step_resource_cron_run_every_saturday.rst

**Run only in November**

.. include:: ../../step_resource/step_resource_cron_run_only_in_november.rst


csh
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_csh.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_csh_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_csh_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_csh_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_csh_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


deploy
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_deploy.rst

.. include:: ../../includes_resources/includes_resource_deploy_capistrano.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_syntax.rst

Deploy Strategies
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_strategy.rst

**Deploy Cache File**

.. include:: ../../includes_resources/includes_resource_deploy_strategy_start_over.rst

Deploy Phases
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_strategy_phases.rst

Callbacks
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_strategy_callbacks.rst

**Callbacks and Capistrano**

.. include:: ../../includes_resources/includes_resource_deploy_capistrano_callbacks.rst

Layout Modifiers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_strategy_layouts.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_providers.rst

deploy_branch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_providers_deploy_branch.rst

deploy_revision
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_providers_deploy_revision.rst

timestamped_deploy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_providers_timestamped_deploy.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Modify the layout of a Ruby on Rails application**

.. include:: ../../step_resource/step_resource_deploy_custom_application_layout.rst

**Use resources within callbacks**

.. include:: ../../step_resource/step_resource_deploy_embedded_recipes_for_callbacks.rst

**Deploy from a private git repository without using the application cookbook**

.. include:: ../../step_resource/step_resource_deploy_private_git_repo_using_application_cookbook.rst

**Use an SSH wrapper**

.. include:: ../../step_resource/step_resource_deploy_recipe_uses_ssh_wrapper.rst

**Use a callback to include a file that will be passed as a code block**

.. include:: ../../step_resource/step_resource_deploy_use_callback_to_include_code_from_file.rst

**Use a callback to pass a code block**

.. include:: ../../step_resource/step_resource_deploy_use_callback_to_pass_python.rst

**Use the same API for all recipes using the same gem**

.. include:: ../../step_resource/step_resource_deploy_use_same_api_as_gitdeploy_gems.rst

**Deploy without creating symbolic links to a shared folder**

.. include:: ../../step_resource/step_resource_deploy_without_symlink_to_shared.rst

**Clear a layout modifier attribute**

.. include:: ../../step_resource/step_resource_deploy_clear_layout_modifiers.rst


directory
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_directory.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_directory_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_directory_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_directory_attributes.rst

Recursive Directories
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_directory_recursive.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_directory_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create a directory**

.. include:: ../../step_resource/step_resource_directory_create.rst

**Create a directory in Microsoft Windows**

.. include:: ../../step_resource/step_resource_directory_create_in_windows.rst

**Create a directory recursively**

.. include:: ../../step_resource/step_resource_directory_create_recursively.rst

**Delete a directory**

.. include:: ../../step_resource/step_resource_directory_delete.rst

**Set directory permissions using a variable**

.. include:: ../../step_resource/step_resource_directory_set_permissions_with_variable.rst

**Set directory permissions for a specific type of node**

.. include:: ../../step_resource/step_resource_directory_set_permissions_for_specific_node.rst

**Reload the configuration**

.. include:: ../../step_resource/step_resource_ruby_block_reload_configuration.rst


dpkg_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_dpkg.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_dpkg_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_dpkg_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_dpkg_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_dpkg_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_dpkg_package_install.rst


dsc_resource
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell_dsc.rst

.. include:: ../../includes_resources/includes_resource_dsc_resource.rst

.. warning:: .. include:: ../../includes_resources/includes_resource_dsc_resource_requirements.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Open a Zip file**

.. include:: ../../step_resource/step_resource_dsc_resource_zip_file.rst

**Manage users and groups**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_users.rst

**Create a test message queue**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_msmq.rst


dsc_script
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell_dsc.rst

.. include:: ../../includes_resources/includes_resource_dsc_script.rst

.. note:: |windows powershell| 4.0 is required for using the |resource dsc_script| resource with |chef|.

.. note:: The |windows remote management| service must be enabled. (Use ``winrm quickconfig`` to enable the service.)

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Specify DSC code directly**

.. include:: ../../step_resource/step_resource_dsc_script_code.rst

**Specify DSC code using a Windows Powershell data file**

.. include:: ../../step_resource/step_resource_dsc_script_command.rst

**Pass parameters to DSC configurations**

.. include:: ../../step_resource/step_resource_dsc_script_flags.rst

**Use custom configuration data**

Configuration data in |windows powershell_dsc_short| scripts may be customized from a recipe. For example, scripts are typically customized to set the behavior for |windows powershell| credential data types. Configuration data may be specified in one of three ways: by using the ``configuration_data`` or ``configuration_data_script`` attributes or by specifying the path to a valid |windows powershell| data file. 

.. include:: ../../step_resource/step_resource_dsc_script_configuration_data.rst

.. include:: ../../step_resource/step_resource_dsc_script_configuration_name.rst

**Using DSC with other Chef resources**

.. include:: ../../step_resource/step_resource_dsc_script_remote_files.rst



easy_install_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_easy_install.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_easy_install_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_easy_install_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_easy_install_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_easy_install_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_easy_install_package_install.rst


env
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_env.rst

.. note:: .. include:: ../../includes_notes/includes_notes_env_resource_variable_on_unix.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_env_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Set an environment variable**

.. include:: ../../step_resource/step_resource_environment_set_variable.rst


erl_call
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_erlang_call.rst

.. note:: .. include:: ../../includes_notes/includes_notes_erlang_call_resource_must_be_on_path.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_erlang_call_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_erlang_call_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_erlang_call_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_erlang_call_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Run a command**

.. include:: ../../step_resource/step_resource_erlang_call_run_command_on_node.rst


execute
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_execute.rst

.. note:: .. include:: ../../includes_notes/includes_notes_execute_resource_intepreter.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_execute_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_execute_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_execute_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_execute_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Run a command upon notification**

.. include:: ../../step_resource/step_resource_execute_command_upon_notification.rst

**Run a touch file only once while running a command**

.. include:: ../../step_resource/step_resource_execute_command_with_touch_file.rst

**Run a command which requires an environment variable**

.. include:: ../../step_resource/step_resource_execute_command_with_variable.rst

**Delete a repository using yum to scrub the cache**

.. include:: ../../step_resource/step_resource_yum_package_delete_repo_use_yum_to_scrub_cache.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Prevent restart and reconfigure if configuration is broken**

.. include:: ../../step_resource/step_resource_execute_subscribes_prevent_restart_and_reconfigure.rst

**Notify in a specific order**

.. include:: ../../step_resource/step_resource_execute_notifies_specific_order.rst

**Execute a command using a template**

.. include:: ../../step_resource/step_resource_execute_command_from_template.rst

**Add a rule to an IP table**

.. include:: ../../step_resource/step_resource_execute_add_rule_to_iptable.rst

**Stop a service, do stuff, and then restart it**

.. include:: ../../step_resource/step_resource_service_stop_do_stuff_start.rst

**Use the platform_family? method**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

**Control a service using the execute resource**

.. include:: ../../step_resource/step_resource_execute_control_a_service.rst

**Use the search recipe DSL method to find users**

.. include:: ../../step_resource/step_resource_execute_use_search_dsl_method.rst

**Enable remote login for Mac OS X**

.. include:: ../../step_resource/step_resource_execute_enable_remote_login.rst

**Execute code immediately, based on the template resource**

.. include:: ../../step_resource/step_resource_template_notifies_run_immediately.rst

**Run a Knife command**

.. include:: ../../step_resource/step_resource_execute_knife_user_create.rst

**Run install command into virtual environment**

.. include:: ../../step_resource/step_resource_execute_install_q.rst

**Run a command as a named user**

.. include:: ../../step_resource/step_resource_execute_bundle_install.rst


file
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_file.rst

.. note:: .. include:: ../../includes_notes/includes_notes_file_resource_use_other_resources.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_file_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_file_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_file_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_file_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create a file**

.. include:: ../../step_resource/step_resource_file_create.rst

**Create a file in Microsoft Windows**

.. include:: ../../step_resource/step_resource_file_create_in_windows.rst

**Remove a file**

.. include:: ../../step_resource/step_resource_file_remove.rst

**Set file modes**

.. include:: ../../step_resource/step_resource_file_set_file_mode.rst

**Delete a repository using yum to scrub the cache**

.. include:: ../../step_resource/step_resource_yum_package_delete_repo_use_yum_to_scrub_cache.rst

**Add the value of a data bag item to a file**

.. include:: ../../step_resource/step_resource_file_content_data_bag.rst

**Write a YAML file**

.. include:: ../../step_resource/step_resource_file_content_yaml_config.rst

**Write a string to a file**

.. include:: ../../step_resource/step_resource_file_content_add_string.rst

**Create a file from a copy**

.. include:: ../../step_resource/step_resource_file_copy.rst


freebsd_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_freebsd.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_freebsd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_freebsd_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_freebsd_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_freebsd_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_freebsd_package_install.rst


gem_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_gem.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_chef_gem_vs_gem_package.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_gem_syntax.rst

Gem Package Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_options.rst

Use a Hash
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_hash.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_hash_options.rst

Use a String
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_string.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_options_string.rst

Use a .gemrc File
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_gemrc.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_gemrc.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_gem_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_gem_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_gem_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a gems file from the local file system**

.. include:: ../../step_resource/step_resource_package_install_gems_from_local.rst

**Use the ignore_failure common attribute**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst



git
-----------------------------------------------------

.. include:: ../../includes_resources/includes_resource_scm_git.rst

.. note:: .. include:: ../../includes_notes/includes_notes_scm_resource_use_with_resource_deploy.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_git_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_git_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_git_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_scm_git_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Use the git mirror**

.. include:: ../../step_resource/step_resource_scm_use_git_mirror.rst

**Use different branches**

.. include:: ../../step_resource/step_resource_scm_use_different_branches.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Upgrade packages from git**

.. include:: ../../step_resource/step_resource_scm_upgrade_packages.rst


group
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_group.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_group_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_group_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_group_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_group_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Append users to groups**

.. include:: ../../step_resource/step_resource_group_append_user.rst



homebrew_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_homebrew.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_homebrew_package_install.rst

**Specify the Homebrew user with a UUID**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_uuid.rst

**Specify the Homebrew user with a string**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_string.rst




http_request
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_http_request.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_http_request_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_http_request_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_http_request_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_http_request_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Send a GET request**

.. include:: ../../step_resource/step_resource_http_request_send_get.rst

**Send a POST request**

.. include:: ../../step_resource/step_resource_http_request_send_post.rst

**Transfer a file only when the remote source changes**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst

ifconfig
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ifconfig.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ifconfig_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ifconfig_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ifconfig_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_ifconfig_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Configure a network interface**

.. include:: ../../step_resource/step_resource_ifconfig_configure_network_interface.rst

ips_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_ips.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_ips_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_ips_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_ips_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_ips_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_ips_package_install.rst


link
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_link.rst

.. include:: ../../includes_resources/includes_resource_link_about.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_link_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_link_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_link_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_link_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create symbolic links**

.. include:: ../../step_resource/step_resource_link_create_symbolic.rst

**Create hard links**

.. include:: ../../step_resource/step_resource_link_create_hard.rst

**Delete links**

.. include:: ../../step_resource/step_resource_link_delete.rst

**Create multiple symbolic links**

.. include:: ../../step_resource/step_resource_link_multiple_links_files.rst

**Create platform-specific symbolic links**

.. include:: ../../step_resource/step_resource_link_multiple_links_redhat.rst


log
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_log.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_log_providers.rst
.. 

Chef::Log Entries
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_chef_log.rst

.. include:: ../../step_ruby/step_ruby_class_chef_log_fatal.rst

.. include:: ../../step_ruby/step_ruby_class_chef_log_multiple.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Set default logging level**

.. include:: ../../step_resource/step_resource_log_set_info.rst

**Set debug logging level**

.. include:: ../../step_resource/step_resource_log_set_debug.rst

**Add a message to a log file**

.. include:: ../../step_resource/step_resource_log_add_message.rst




macports_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_macports.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_macports_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_macports_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_macports_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_macports_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_macports_package_install.rst


mdadm
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_mdadm.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mdadm_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mdadm_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mdadm_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_mdadm_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create and assemble a RAID 0 array**

.. include:: ../../step_resource/step_resource_mdadm_raid0.rst

**Create and assemble a RAID 1 array**

.. include:: ../../step_resource/step_resource_mdadm_raid1.rst

**Create and assemble a RAID 5 array**

.. include:: ../../step_resource/step_resource_mdadm_raid5.rst


mount
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_mount.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mount_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mount_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mount_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mount_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Mount a labeled file system**

.. include:: ../../step_resource/step_resource_mount_labeled_file_system.rst

**Mount a local block drive**

.. include:: ../../step_resource/step_resource_mount_local_block_device.rst

**Mount a non-block file system**

.. include:: ../../step_resource/step_resource_mount_nonblock_file_system.rst

**Mount and add to the file systems table**

.. include:: ../../step_resource/step_resource_mount_remote_file_system_add_to_fstab.rst

**Mount a remote file system**

.. include:: ../../step_resource/step_resource_mount_remote_file_system.rst

**Mount a remote folder in Microsoft Windows**

.. include:: ../../step_resource/step_resource_mount_remote_windows_folder.rst

**Unmount a remote folder in Microsoft Windows**

.. include:: ../../step_resource/step_resource_mount_unmount_remote_windows_drive.rst

**Stop a service, do stuff, and then restart it**

.. include:: ../../step_resource/step_resource_service_stop_do_stuff_start.rst


ohai
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ohai.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ohai_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ohai_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ohai_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_ohai_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Reload Ohai**

.. include:: ../../step_resource/step_resource_ohai_reload.rst

**Reload Ohai after a new user is created**

.. include:: ../../step_resource/step_resource_ohai_reload_after_create_user.rst


openbsd_package
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_package_openbsd.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_openbsd_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_openbsd_package_install.rst



package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package.rst

.. note:: .. include:: ../../includes_notes/includes_notes_available_package_resources.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_syntax.rst

Gem Package Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_options.rst

Specify Options with a Hash
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_hash.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_hash_options.rst

Specify Options with a String
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_string.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_options_string.rst

Specify Options with a .gemrc File
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_gemrc.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_gemrc.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_11-16_package_attributes.rst

Multiple Packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources_common/includes_resources_common_multiple_packages.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_11-16_package_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a gems file for use in recipes**

.. include:: ../../step_resource/step_resource_package_install_gems_for_chef_recipe.rst

**Install a gems file from the local file system**

.. include:: ../../step_resource/step_resource_package_install_gems_from_local.rst

**Install a package**

.. include:: ../../step_resource/step_resource_package_install.rst

**Install a package version**

.. include:: ../../step_resource/step_resource_package_install_version.rst

**Install a package with options**

.. include:: ../../step_resource/step_resource_package_install_with_options.rst

**Install a package with a response_file**

.. include:: ../../step_resource/step_resource_package_install_with_response_file.rst

**Install a package using a specific provider**

.. include:: ../../step_resource/step_resource_package_install_with_specific_provider.rst

**Install a specified architecture using a named provider**

.. include:: ../../step_resource/step_resource_package_install_with_yum.rst

**Purge a package**

.. include:: ../../step_resource/step_resource_package_purge.rst

**Remove a package**

.. include:: ../../step_resource/step_resource_package_remove.rst

**Upgrade a package**

.. include:: ../../step_resource/step_resource_package_upgrade.rst

**Avoid unnecessary string interpolation**

.. include:: ../../step_resource/step_resource_package_avoid_unnecessary_string_interpolation.rst

**Install a package in a platform**

.. include:: ../../step_resource/step_resource_package_install_package_on_platform.rst

**Install sudo, then configure /etc/sudoers/ file**

.. include:: ../../step_resource/step_resource_package_install_sudo_configure_etc_sudoers.rst

**Use a case statement to specify the platform**

.. include:: ../../step_resource/step_resource_package_use_case_statement.rst

**Use symbols to reference attributes**

.. include:: ../../step_resource/step_resource_package_use_symbols_to_reference_attributes.rst

**Use a whitespace array to simplify a recipe**

.. include:: ../../step_resource/step_resource_package_use_whitespace_array.rst

pacman_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_pacman.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_pacman_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_pacman_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_pacman_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_pacman_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_pacman_package_install.rst



paludis_package
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_package_paludis.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_paludis_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_paludis_package_install.rst




perl
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_perl.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_perl_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_perl_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_perl_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_perl_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


portage_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_portage.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_portage_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_portage_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_portage_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_portage_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_portage_package_install.rst


powershell_script
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_powershell_script.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_powershell_script_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Write to an interpolated path**

.. include:: ../../step_resource/step_resource_powershell_write_to_interpolated_path.rst

**Change the working directory**

.. include:: ../../step_resource/step_resource_powershell_cwd.rst

**Change the working directory in Microsoft Windows**

.. include:: ../../step_resource/step_resource_powershell_cwd_microsoft_env.rst

**Pass an environment variable to a script**

.. include:: ../../step_resource/step_resource_powershell_pass_env_to_script.rst

**Rename computer, join domain, reboot**

.. include:: ../../step_resource/step_resource_powershell_rename_join_reboot.rst



python
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_python.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_python_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_python_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_python_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_python_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.




reboot
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service_reboot.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_service_reboot_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Reboot a node immediately**

.. include:: ../../step_resource/step_resource_service_reboot_immediately.rst

**Reboot a node at the end of a chef-client run**

.. include:: ../../step_resource/step_resource_service_reboot_request.rst

**Cancel a reboot**

.. include:: ../../step_resource/step_resource_service_reboot_cancel.rst

**Rename computer, join domain, reboot**

.. include:: ../../step_resource/step_resource_powershell_rename_join_reboot.rst


registry_key
-----------------------------------------------------

.. include:: ../../includes_resources/includes_resource_registry_key.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_syntax.rst

**Registry Key Path Separators**

.. include:: ../../includes_windows/includes_windows_registry_key_backslashes.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_registry_key_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create a registry key**

.. include:: ../../step_resource/step_resource_registry_key_create.rst

**Delete a registry key value**

.. include:: ../../step_resource/step_resource_registry_key_delete_value.rst

**Delete a registry key and its subkeys, recursively**

.. include:: ../../step_resource/step_resource_registry_key_delete_recursively.rst

**Use re-directed keys**

.. include:: ../../step_resource/step_resource_registry_key_redirect.rst

**Set proxy settings to be the same as those used by the chef-client**

.. include:: ../../step_resource/step_resource_registry_key_set_proxy_settings_to_same_as_chef_client.rst

**Set the name of a registry key to "(Default)"**

.. include:: ../../step_resource/step_resource_registry_key_set_default.rst

remote_directory
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_remote_directory.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_directory_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_directory_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_directory_attributes.rst

Recursive Directories
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_remote_directory_recursive.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_remote_directory_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Recursively transfer a directory from a remote location**

.. include:: ../../step_resource/step_resource_remote_directory_recursive_transfer.rst

**Use with the chef_handler lightweight resource**

.. include:: ../../step_resource/step_resource_remote_directory_report_handler.rst


remote_file
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_remote_file.rst

.. note:: .. include:: ../../includes_notes/includes_notes_remote_file_resource_fetch_from_files_directory.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_file_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_file_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_file_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_remote_file_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Transfer a file from a URL**

.. include:: ../../step_resource/step_resource_remote_file_transfer_from_url.rst

**Transfer a file only when the source has changed**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst

**Use the platform_family? method**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

**Specify local Windows file path as a valid URI**

.. include:: ../../step_resource/step_resource_remote_file_local_windows_path.rst

route
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_route.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_route_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_route_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_route_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_route_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Add a host route**

.. include:: ../../step_resource/step_resource_route_add_host.rst

**Delete a network route**

.. include:: ../../step_resource/step_resource_route_delete_network.rst

rpm_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_rpm.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_rpm_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_rpm_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_rpm_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_rpm_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_rpm_package_install.rst

ruby
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_ruby.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ruby_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ruby_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ruby_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ruby_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


ruby_block
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ruby_block.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ruby_block_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ruby_block_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ruby_block_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_ruby_block_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Re-read configuration data**

.. include:: ../../step_resource/step_resource_ruby_block_reread_chef_client.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Use an if statement with the platform recipe DSL method**

.. include:: ../../step_resource/step_resource_ruby_block_if_statement_use_with_platform.rst

**Stash a file in a data bag**

.. include:: ../../step_resource/step_resource_ruby_block_stash_file_in_data_bag.rst

**Update the /etc/hosts file**

.. include:: ../../step_resource/step_resource_ruby_block_update_etc_host.rst

**Set environment variables**

.. include:: ../../step_resource/step_resource_ruby_block_use_variables_to_set_env_variables.rst

**Set JAVA_HOME**

.. include:: ../../step_resource/step_resource_ruby_block_use_variables_to_set_java_home.rst

**Run specific blocks of Ruby code on specific platforms**

.. include:: ../../step_resource/step_resource_ruby_block_run_specific_ruby_blocks_on_specific_platforms.rst

**Reload the configuration**

.. include:: ../../step_resource/step_resource_ruby_block_reload_configuration.rst


script
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Use a named provider to run a script**

.. include:: ../../step_resource/step_resource_script_bash_provider_and_interpreter.rst

**Run a script**

.. include:: ../../step_resource/step_resource_script_bash_script.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst



service
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Start a service**

.. include:: ../../step_resource/step_resource_service_start_service.rst

**Start a service, enable it**

.. include:: ../../step_resource/step_resource_service_start_service_and_enable_at_boot.rst

**Use a pattern**

.. include:: ../../step_resource/step_resource_service_process_table_has_different_value.rst

**Manage a service, depending on the node platform**

.. include:: ../../step_resource/step_resource_service_manage_ssh_based_on_node_platform.rst

**Change a service provider, depending on the node platform**

.. include:: ../../step_resource/step_resource_service_change_service_provider_based_on_node.rst

**Set an IP address using variables and a template**

.. include:: ../../step_resource/step_resource_template_set_ip_address_with_variables_and_template.rst

**Use a cron timer to manage a service**

.. include:: ../../step_resource/step_resource_service_use_variable.rst

**Restart a service, and then notify a different service**

.. include:: ../../step_resource/step_resource_service_restart_and_notify.rst

**Stop a service, do stuff, and then restart it**

.. include:: ../../step_resource/step_resource_service_stop_do_stuff_start.rst

**Control a service using the execute resource**

.. include:: ../../step_resource/step_resource_execute_control_a_service.rst


smartos_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_smartos.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_smartos_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_smartos_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_smartos_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_smartos_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_smartos_package_install.rst


solaris_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_solaris.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_solaris_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_solaris_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_solaris_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_solaris_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_solaris_package_install.rst



subversion
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_scm_subversion.rst

.. note:: .. include:: ../../includes_notes/includes_notes_scm_resource_use_with_resource_deploy.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_subversion_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_subversion_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_subversion_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_scm_subversion_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Get the latest version of an application**

.. include:: ../../step_resource/step_resource_scm_get_latest_version.rst


template
-----------------------------------------------------
.. include:: ../../includes_template/includes_template.rst

.. include:: ../../includes_resources/includes_resource_template.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_template_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_template_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_template_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_template_providers.rst
.. 

Using Templates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_requirements.rst

File Specificity
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_specificity.rst

**Pattern**

.. include:: ../../includes_template/includes_template_specificity_pattern.rst

**Example**

.. include:: ../../includes_template/includes_template_specificity_example.rst

Helpers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_template_helper.rst

**Inline Methods**

.. include:: ../../step_resource/step_resource_template_inline_method.rst

**Inline Modules**

.. include:: ../../step_resource/step_resource_template_inline_module.rst

**Library Modules**

.. include:: ../../step_resource/step_resource_template_library_module.rst

Host Notation
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_host_notation.rst

Partial Templates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_partials.rst

**render Method**

.. include:: ../../includes_template/includes_template_partials_render_method.rst

Transfer Frequency
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_transfer_frequency.rst

Variables
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_variables.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Configure a file from a template**

.. include:: ../../step_resource/step_resource_template_configure_file.rst

**Configure a file from a local template**

.. include:: ../../step_resource/step_resource_template_configure_file_from_local.rst

**Configure a file using a variable map**

.. include:: ../../step_resource/step_resource_template_configure_file_with_variable_map.rst

**Use the not_if condition**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_attribute_has_value.rst

.. include:: ../../step_resource/step_resource_template_add_file_not_if_ruby.rst

.. include:: ../../step_resource/step_resource_template_add_file_not_if_ruby_with_curly_braces.rst

.. include:: ../../step_resource/step_resource_template_add_file_not_if_string.rst

**Use the only_if condition**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_attribute_has_value.rst

.. include:: ../../step_resource/step_resource_template_add_file_only_if_ruby.rst

.. include:: ../../step_resource/step_resource_template_add_file_only_if_string.rst

**Use a whitespace array (%w)**

.. include:: ../../step_resource/step_resource_template_use_whitespace_array.rst

**Use a relative path**

.. include:: ../../step_resource/step_resource_template_use_relative_paths.rst

**Delay notifications**

.. include:: ../../step_resource/step_resource_template_notifies_delay.rst

**Notify immediately**

.. include:: ../../step_resource/step_resource_template_notifies_run_immediately.rst

**Notify multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_multiple_resources.rst

**Reload a service**

.. include:: ../../step_resource/step_resource_template_notifies_reload_service.rst

**Restart a service when a template is modified**

.. include:: ../../step_resource/step_resource_template_notifies_restart_service_when_template_modified.rst

**Send notifications to multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_send_notifications_to_multiple_resources.rst

**Execute a command using a template**

.. include:: ../../step_resource/step_resource_execute_command_from_template.rst

**Set an IP address using variables and a template**

.. include:: ../../step_resource/step_resource_template_set_ip_address_with_variables_and_template.rst

**Add a rule to an IP table**

.. include:: ../../step_resource/step_resource_execute_add_rule_to_iptable.rst

**Apply proxy settings consistently across a Chef organization**

.. include:: ../../step_resource/step_resource_template_consistent_proxy_settings.rst

**Get template settings from a local file**

.. include:: ../../step_resource/step_resource_template_get_settings_from_local_file.rst

**Pass values from recipe to template**

.. include:: ../../step_resource/step_resource_template_pass_values_to_template_from_recipe.rst




user
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_user.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_attributes.rst

Supported Features
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_supported_features.rst

Password Shadow Hash
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_password_shadow_hash.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create a user named "random"**

.. include:: ../../step_resource/step_resource_user_create_random.rst

**Create a system user**

.. include:: ../../step_resource/step_resource_user_create_system.rst

**Create a system user with a variable**

.. include:: ../../step_resource/step_resource_user_create_system_user_with_variable.rst


windows_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_windows.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_windows_package_install.rst



windows_service
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service_windows.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_service_windows_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Start a service manually**

.. include:: ../../step_resource/step_resource_service_windows_manual_start.rst






yum_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_yum.rst

.. note:: .. include:: ../../includes_notes/includes_notes_yum_resource_using_file_names.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_yum_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_yum_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_yum_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_yum_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install an exact version**

.. include:: ../../step_resource/step_resource_yum_package_install_exact_version.rst

**Install a minimum version**

.. include:: ../../step_resource/step_resource_yum_package_install_minimum_version.rst

**Install a minimum version using the default action**

.. include:: ../../step_resource/step_resource_yum_package_install_package_using_default_action.rst

**To install a package**

.. include:: ../../step_resource/step_resource_yum_package_install_package.rst

**To install a partial minimum version**

.. include:: ../../step_resource/step_resource_yum_package_install_partial_minimum_version.rst

**To install a specific architecture**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_architecture.rst

**To install a specific version-release**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_version_release.rst

**To install a specific version (even when older than the current)**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_version.rst

**Handle cookbook_file and yum_package resources in the same recipe**

.. include:: ../../step_resource/step_resource_yum_package_handle_cookbook_file_and_yum_package.rst
