=====================================================
Resource Code Examples
=====================================================

This reference contains code examples for many of the core resources that are built in to the |chef client|, sorted by resource. This topic is a subset of the topic that contains a `complete description of all resources <https://docs.chef.io/chef/resources.html>`_, including actions, properties, and providers (in addition to these examples).


Common Examples
=====================================================
The examples in this section show functionality that is common across all resources.

**Use the :nothing action**

.. include:: ../../step_resource/step_resource_service_use_nothing_action.rst

**Use the ignore_failure common attribute**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst

**Use the provider common attribute**

.. include:: ../../step_resource/step_resource_package_use_provider_attribute.rst

**Use the supports common attribute**

.. include:: ../../step_resource/step_resource_service_use_supports_attribute.rst

**Use the supports and providers common attributes**

.. include:: ../../step_resource/step_resource_service_use_provider_and_supports_attributes.rst

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

**Create a file, but only if an attribute has a specific value**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_attribute_has_value.rst

**Create a file with a Ruby block, but only if "/etc/passwd" does not exist**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_ruby.rst

**Create a file using a string, but only if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_string.rst

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

**Prevent restart and reconfigure if configuration is broken**

.. include:: ../../step_resource/step_resource_execute_subscribes_prevent_restart_and_reconfigure.rst

**Reload a service using a template**

.. include:: ../../step_resource/step_resource_service_subscribes_reload_using_template.rst

**Stash a file in a data bag**

.. include:: ../../step_resource/step_resource_ruby_block_stash_file_in_data_bag.rst

**Relative Paths**

.. include:: ../../step_resource/step_resource_template_use_relative_paths.rst



apt_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_apt.rst

**Install a package using package manager** 

.. include:: ../../step_resource/step_resource_apt_package_install_package.rst

**Install a package using local file** 

.. include:: ../../step_resource/step_resource_apt_package_install_package_using_local_file.rst

**Install without using recommend packages as a dependency**

.. include:: ../../step_resource/step_resource_apt_package_install_without_recommends_suggests.rst



bash
=====================================================
.. include:: ../../includes_resources/includes_resource_script_bash.rst

**Use a named provider to run a script**

.. include:: ../../step_resource/step_resource_script_bash_provider_and_interpreter.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst



batch
=====================================================
.. include:: ../../includes_resources/includes_resource_batch.rst

**Unzip a file, and then move it**

.. include:: ../../step_resource/step_resource_batch_unzip_file_and_move.rst



bff_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_bff.rst

**Install a package**

.. include:: ../../step_resource/step_resource_bff_package_install.rst



breakpoint
=====================================================
.. include:: ../../includes_resources/includes_resource_breakpoint.rst

**A recipe without a breakpoint**

.. include:: ../../step_resource/step_resource_breakpoint_no.rst

**The same recipe with breakpoints**

.. include:: ../../step_resource/step_resource_breakpoint_yes.rst



chef_gem
=====================================================
.. include:: ../../includes_resources/includes_resource_package_chef_gem.rst

**Install a gems file for use in recipes**

.. include:: ../../step_resource/step_resource_chef_gem_install_for_use_in_recipes.rst

**Install MySQL for Chef**

.. include:: ../../step_resource/step_resource_chef_gem_install_mysql.rst



chef_handler
=====================================================
.. include:: ../../includes_resources/includes_resource_chef_handler.rst

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
=====================================================
.. include:: ../../includes_resources/includes_resource_cookbook_file.rst

**Transfer a file**

.. include:: ../../step_resource/step_resource_cookbook_file_transfer_a_file.rst

**Handle cookbook_file and yum_package resources in the same recipe**

.. include:: ../../step_resource/step_resource_yum_package_handle_cookbook_file_and_yum_package.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Use a case statement**

.. include:: ../../step_resource/step_resource_cookbook_file_use_case_statement.rst

**Manage dotfiles**

.. include:: ../../step_resource/step_resource_directory_manage_dotfiles.rst



cron
=====================================================
.. include:: ../../includes_resources/includes_resource_cron.rst

**Run a program at a specified interval**

.. include:: ../../step_resource/step_resource_cron_run_program_on_fifth_hour.rst

**Run an entry if a folder exists**

.. include:: ../../step_resource/step_resource_cron_run_entry_when_folder_exists.rst

**Run every Saturday, 8:00 AM**

.. include:: ../../step_resource/step_resource_cron_run_every_saturday.rst

**Run only in November**

.. include:: ../../step_resource/step_resource_cron_run_only_in_november.rst



csh
=====================================================
.. include:: ../../includes_resources/includes_resource_script_csh.rst

No examples.



deploy
=====================================================
.. include:: ../../includes_resources/includes_resource_deploy.rst

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
=====================================================
.. include:: ../../includes_resources/includes_resource_directory.rst

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

**Manage dotfiles**

.. include:: ../../step_resource/step_resource_directory_manage_dotfiles.rst


dpkg_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_dpkg.rst

**Install a package**

.. include:: ../../step_resource/step_resource_dpkg_package_install.rst



dsc_resource
=====================================================
.. include:: ../../includes_resources/includes_resource_dsc_resource.rst

**Open a Zip file**

.. include:: ../../step_resource/step_resource_dsc_resource_zip_file.rst

**Manage users and groups**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_users.rst

**Create a test message queue**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_msmq.rst



dsc_script
=====================================================
.. include:: ../../includes_resources/includes_resource_dsc_script.rst

**Specify DSC code directly**

.. include:: ../../step_resource/step_resource_dsc_script_code.rst

**Specify DSC code using a Windows Powershell data file**

.. include:: ../../step_resource/step_resource_dsc_script_command.rst

**Pass parameters to DSC configurations**

.. include:: ../../step_resource/step_resource_dsc_script_flags.rst

**Use custom configuration data**

.. include:: ../../includes_resources/includes_resource_dsc_script_custom_config_data.rst

.. include:: ../../step_resource/step_resource_dsc_script_configuration_data.rst

.. include:: ../../step_resource/step_resource_dsc_script_configuration_name.rst

**Using DSC with other Chef resources**

.. include:: ../../step_resource/step_resource_dsc_script_remote_files.rst



easy_install_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_easy_install.rst

**Install a package**

.. include:: ../../step_resource/step_resource_easy_install_package_install.rst



env
=====================================================
.. include:: ../../includes_resources/includes_resource_env.rst

**Set an environment variable**

.. include:: ../../step_resource/step_resource_environment_set_variable.rst



erl_call
=====================================================
.. include:: ../../includes_resources/includes_resource_erlang_call.rst

**Run a command**

.. include:: ../../step_resource/step_resource_erlang_call_run_command_on_node.rst



execute
=====================================================
.. include:: ../../includes_resources/includes_resource_execute.rst

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

**Sourcing a file**

.. include:: ../../step_resource/step_resource_execute_source_a_file.rst

**Run a Knife command**

.. include:: ../../step_resource/step_resource_execute_knife_user_create.rst

**Run install command into virtual environment**

.. include:: ../../step_resource/step_resource_execute_install_q.rst

**Run a command as a named user**

.. include:: ../../step_resource/step_resource_execute_bundle_install.rst



file
=====================================================
.. include:: ../../includes_resources/includes_resource_file.rst

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
=====================================================
.. include:: ../../includes_resources/includes_resource_package_freebsd.rst

**Install a package**

.. include:: ../../step_resource/step_resource_freebsd_package_install.rst


gem_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_gem.rst

**Install a gems file from the local file system**

.. include:: ../../step_resource/step_resource_package_install_gems_from_local.rst

**Use the ignore_failure common attribute**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst



git
=====================================================
.. include:: ../../includes_resources/includes_resource_scm_git.rst

**Use the git mirror**

.. include:: ../../step_resource/step_resource_scm_use_git_mirror.rst

**Use different branches**

.. include:: ../../step_resource/step_resource_scm_use_different_branches.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Upgrade packages from git**

.. include:: ../../step_resource/step_resource_scm_upgrade_packages.rst

**Pass in environment variables**

.. include:: ../../step_resource/step_resource_scm_git_environment_variables.rst



group
=====================================================
.. include:: ../../includes_resources/includes_resource_group.rst

**Append users to groups**

.. include:: ../../step_resource/step_resource_group_append_user.rst

**Add a user to group on the Windows platform**

.. include:: ../../step_resource/step_resource_group_add_user_on_windows.rst


homebrew_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_homebrew.rst

**Install a package**

.. include:: ../../step_resource/step_resource_homebrew_package_install.rst

**Specify the Homebrew user with a UUID**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_uuid.rst

**Specify the Homebrew user with a string**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_string.rst



http_request
=====================================================
.. include:: ../../includes_resources/includes_resource_http_request.rst

**Send a GET request**

.. include:: ../../step_resource/step_resource_http_request_send_get.rst

**Send a POST request**

.. include:: ../../step_resource/step_resource_http_request_send_post.rst

**Transfer a file only when the remote source changes**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst



ifconfig
=====================================================
.. include:: ../../includes_resources/includes_resource_ifconfig.rst

**Configure a network interface**

.. include:: ../../step_resource/step_resource_ifconfig_boot_protocol.rst

**Specify a boot protocol**

.. include:: ../../step_resource/step_resource_ifconfig_configure_network_interface.rst

**Specify a static IP address**

.. include:: ../../step_resource/step_resource_ifconfig_static_ip_address.rst

**Update a static IP address with a boot protocol**

.. include:: ../../step_resource/step_resource_ifconfig_update_static_ip_with_boot_protocol.rst



ips_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_ips.rst

**Install a package**

.. include:: ../../step_resource/step_resource_ips_package_install.rst


ksh
=====================================================
.. include:: ../../includes_resources/includes_resource_script_ksh.rst

No examples.



link
=====================================================
.. include:: ../../includes_resources/includes_resource_link.rst

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
=====================================================
.. include:: ../../includes_resources/includes_resource_log.rst

**Set default logging level**

.. include:: ../../step_resource/step_resource_log_set_info.rst

**Set debug logging level**

.. include:: ../../step_resource/step_resource_log_set_debug.rst

**Add a message to a log file**

.. include:: ../../step_resource/step_resource_log_add_message.rst



macports_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_macports.rst

**Install a package**

.. include:: ../../step_resource/step_resource_macports_package_install.rst



mdadm
=====================================================
.. include:: ../../includes_resources/includes_resource_mdadm.rst

**Create and assemble a RAID 0 array**

.. include:: ../../step_resource/step_resource_mdadm_raid0.rst

**Create and assemble a RAID 1 array**

.. include:: ../../step_resource/step_resource_mdadm_raid1.rst

**Create and assemble a RAID 5 array**

.. include:: ../../step_resource/step_resource_mdadm_raid5.rst



mount
=====================================================
.. include:: ../../includes_resources/includes_resource_mount.rst

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
=====================================================
.. include:: ../../includes_resources/includes_resource_ohai.rst

**Reload Ohai**

.. include:: ../../step_resource/step_resource_ohai_reload.rst

**Reload Ohai after a new user is created**

.. include:: ../../step_resource/step_resource_ohai_reload_after_create_user.rst



openbsd_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_openbsd.rst

**Install a package**

.. include:: ../../step_resource/step_resource_openbsd_package_install.rst



package
=====================================================
.. include:: ../../includes_resources/includes_resource_package.rst

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

**Use the ignore_failure common attribute**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst

**Use the provider common attribute**

.. include:: ../../step_resource/step_resource_package_use_provider_attribute.rst

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

**Specify the Homebrew user with a UUID**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_uuid.rst

**Specify the Homebrew user with a string**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_string.rst



pacman_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_pacman.rst

**Install a package**

.. include:: ../../step_resource/step_resource_pacman_package_install.rst



paludis_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_paludis.rst

**Install a package**

.. include:: ../../step_resource/step_resource_paludis_package_install.rst



perl
=====================================================
.. include:: ../../includes_resources/includes_resource_script_perl.rst

No examples.



portage_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_portage.rst

**Install a package**

.. include:: ../../step_resource/step_resource_portage_package_install.rst



powershell_script
=====================================================
.. include:: ../../includes_resources/includes_resource_powershell_script.rst

**Write to an interpolated path**

.. include:: ../../step_resource/step_resource_powershell_write_to_interpolated_path.rst

**Change the working directory**

.. include:: ../../step_resource/step_resource_powershell_cwd.rst

**Change the working directory in Microsoft Windows**

.. include:: ../../step_resource/step_resource_powershell_cwd_microsoft_env.rst

**Pass an environment variable to a script**

.. include:: ../../step_resource/step_resource_powershell_pass_env_to_script.rst

**Evaluate for true and/or false**

.. include:: ../../step_resource/step_resource_powershell_convert_boolean_return.rst

**Use the flags attribute**

.. include:: ../../step_resource/step_resource_powershell_script_use_flag.rst

**Rename computer, join domain, reboot**

.. include:: ../../step_resource/step_resource_powershell_rename_join_reboot.rst



python
=====================================================
.. include:: ../../includes_resources/includes_resource_script_python.rst

No examples.




reboot
=====================================================
.. include:: ../../includes_resources/includes_resource_service_reboot.rst

**Reboot a node immediately**

.. include:: ../../step_resource/step_resource_service_reboot_immediately.rst

**Reboot a node at the end of a chef-client run**

.. include:: ../../step_resource/step_resource_service_reboot_request.rst

**Cancel a reboot**

.. include:: ../../step_resource/step_resource_service_reboot_cancel.rst

**Rename computer, join domain, reboot**

.. include:: ../../step_resource/step_resource_powershell_rename_join_reboot.rst



registry_key
=====================================================
.. include:: ../../includes_resources/includes_resource_registry_key.rst

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
=====================================================
.. include:: ../../includes_resources/includes_resource_remote_directory.rst

**Recursively transfer a directory from a remote location**

.. include:: ../../step_resource/step_resource_remote_directory_recursive_transfer.rst

**Use with the chef_handler lightweight resource**

.. include:: ../../step_resource/step_resource_remote_directory_report_handler.rst



remote_file
=====================================================
.. include:: ../../includes_resources/includes_resource_remote_file.rst

**Transfer a file from a URL**

.. include:: ../../step_resource/step_resource_remote_file_transfer_from_url.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst

**Use the platform_family? method**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

**Specify local Windows file path as a valid URI**

.. include:: ../../step_resource/step_resource_remote_file_local_windows_path.rst




route
=====================================================
.. include:: ../../includes_resources/includes_resource_route.rst

**Add a host route**

.. include:: ../../step_resource/step_resource_route_add_host.rst

**Delete a network route**

.. include:: ../../step_resource/step_resource_route_delete_network.rst



rpm_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_rpm.rst

**Install a package**

.. include:: ../../step_resource/step_resource_rpm_package_install.rst



ruby
=====================================================
.. include:: ../../includes_resources/includes_resource_script_ruby.rst

No examples.



ruby_block
=====================================================
.. include:: ../../includes_resources/includes_resource_ruby_block.rst

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

**Reload the configuration**

.. include:: ../../step_resource/step_resource_ruby_block_reload_configuration.rst



script
=====================================================
.. include:: ../../includes_resources/includes_resource_script.rst

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
=====================================================
.. include:: ../../includes_resources/includes_resource_service.rst

**Start a service**

.. include:: ../../step_resource/step_resource_service_start_service.rst

**Start a service, enable it**

.. include:: ../../step_resource/step_resource_service_start_service_and_enable_at_boot.rst

**Use a pattern**

.. include:: ../../step_resource/step_resource_service_process_table_has_different_value.rst

**Use the :nothing common action**

.. include:: ../../step_resource/step_resource_service_use_nothing_action.rst

**Use the supports common attribute**

.. include:: ../../step_resource/step_resource_service_use_supports_attribute.rst

**Use the supports and providers common attributes**

.. include:: ../../step_resource/step_resource_service_use_provider_and_supports_attributes.rst

**Manage a service, depending on the node platform**

.. include:: ../../step_resource/step_resource_service_manage_ssh_based_on_node_platform.rst

**Change a service provider, depending on the node platform**

.. include:: ../../step_resource/step_resource_service_change_service_provider_based_on_node.rst

**Reload a service using a template**

.. include:: ../../step_resource/step_resource_service_subscribes_reload_using_template.rst

**Enable a service after a restart or reload**

.. include:: ../../step_resource/step_resource_service_notifies_enable_after_restart_or_reload.rst

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

**Enable a service on AIX using the mkitab command**

.. include:: ../../step_resource/step_resource_service_aix_mkitab.rst



smartos_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_smartos.rst

**Install a package**

.. include:: ../../step_resource/step_resource_smartos_package_install.rst



solaris_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_solaris.rst

**Install a package**

.. include:: ../../step_resource/step_resource_solaris_package_install.rst



subversion
=====================================================
.. include:: ../../includes_resources/includes_resource_scm_subversion.rst

**Get the latest version of an application**

.. include:: ../../step_resource/step_resource_scm_get_latest_version.rst



template
=====================================================
.. include:: ../../includes_resources/includes_resource_template.rst

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
=====================================================
.. include:: ../../includes_resources/includes_resource_user.rst

**Create a user named "random"**

.. include:: ../../step_resource/step_resource_user_create_random.rst

**Create a system user**

.. include:: ../../step_resource/step_resource_user_create_system.rst

**Create a system user with a variable**

.. include:: ../../step_resource/step_resource_user_create_system_user_with_variable.rst

**Use SALTED-SHA512 passwords**

.. include:: ../../step_resource/step_resource_user_password_shadow_hash_salted_sha512.rst

**Use SALTED-SHA512-PBKDF2 passwords**

.. include:: ../../step_resource/step_resource_user_password_shadow_hash_salted_sha512_pbkdf2.rst



windows_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_windows.rst

**Install a package**

.. include:: ../../step_resource/step_resource_windows_package_install.rst

**Specify a URL for the source attribute**

.. include:: ../../step_resource/step_resource_package_windows_source_url.rst

**Specify path and checksum**

.. include:: ../../step_resource/step_resource_package_windows_source_url_checksum.rst

**Modify remote_file resource attributes**

.. include:: ../../step_resource/step_resource_package_windows_source_remote_file_attributes.rst

**Download a nsis (Nullsoft) package resource**

.. include:: ../../step_resource/step_resource_package_windows_download_nsis_package.rst

**Download a custom package**

.. include:: ../../step_resource/step_resource_package_windows_download_custom_package.rst



windows_service
=====================================================
.. include:: ../../includes_resources/includes_resource_service_windows.rst

**Start a service manually**

.. include:: ../../step_resource/step_resource_service_windows_manual_start.rst



yum_package
=====================================================
.. include:: ../../includes_resources/includes_resource_package_yum.rst

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