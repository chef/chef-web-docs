+++
title = "Resource Code Examples"
draft = false

aliases = "/resource_examples.html"

[menu]
  [menu.docs]
    title = "Examples (by Resource)"
    identifier = "chef_infra/cookbook_reference/resources/resource_examples.md Examples (by Resource)"
    parent = "chef_infra/cookbook_reference/resources"
    weight = 1360
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_examples.rst)

This reference contains code examples for many of the core resources
that are built in to Chef Infra Client, sorted by resource. This topic
is a subset of the topic that contains a [complete description of all
resources](/resource_reference/), including actions, properties, and
providers (in addition to these examples).

Common Examples
===============

The examples in this section show functionality that is common across
all resources.

**Use the :nothing action**

{{% resource_service_use_nothing_action %}}

**Use the ignore_failure common attribute**

{{% resource_package_use_ignore_failure_attribute %}}

**Use the retries common attribute**

{{% resource_service_use_supports_attribute %}}

**Create a file, but not if an attribute has a specific value**

{{% resource_template_add_file_not_if_attribute_has_value %}}

**Create a file with a Ruby block, but not if "/etc/passwd" exists**

{{% resource_template_add_file_not_if_ruby %}}

**Create a file with Ruby block that has curly braces, but not if
"/etc/passwd" exists**

{{% resource_template_add_file_not_if_ruby_with_curly_braces %}}

**Create a file using a string, but not if "/etc/passwd" exists**

{{% resource_template_add_file_not_if_string %}}

**Install a file from a remote location using bash**

{{% resource_remote_file_install_with_bash %}}

**Create a file, but only if an attribute has a specific value**

{{% resource_template_add_file_only_if_attribute_has_value %}}

**Create a file with a Ruby block, but only if "/etc/passwd" does not
exist**

{{% resource_template_add_file_only_if_ruby %}}

**Create a file using a string, but only if "/etc/passwd" exists**

{{% resource_template_add_file_only_if_string %}}

**Delay notifications**

{{% resource_template_notifies_delay %}}

**Notify immediately**

{{% resource_template_notifies_run_immediately %}}

**Enable a service after a restart or reload**

{{% resource_service_notifies_enable_after_restart_or_reload %}}

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

**Prevent restart and reconfigure if configuration is broken**

{{% resource_execute_subscribes_prevent_restart_and_reconfigure %}}

**Reload a service using a template**

{{% resource_service_subscribes_reload_using_template %}}

**Stash a file in a data bag**

{{% resource_ruby_block_stash_file_in_data_bag %}}

**Relative Paths**

{{% resource_template_use_relative_paths %}}

apt_package
============

{{% resource_package_apt %}}

**Install a package using package manager**

{{% resource_apt_package_install_package %}}

**Install a package using local file**

``` ruby
apt_package 'jwhois' do
  action :install
  source '/path/to/jwhois.deb'
end
```

**Install without using recommend packages as a dependency**

{{% resource_apt_package_install_without_recommends_suggests %}}

apt_update
===========

{{% resource_apt_update_summary %}}

**Update the Apt repository at a specified interval**

{{% resource_apt_update_periodic %}}

**Update the Apt repository at the start of a Chef Infra Client run**

{{% resource_apt_update_at_start_of_client_run %}}

bash
====

{{% resource_script_bash %}}

**Use a named provider to run a script**

{{% resource_script_bash_provider_and_interpreter %}}

**Install a file from a remote location using bash**

{{% resource_remote_file_install_with_bash %}}

**Install an application from git using bash**

{{% resource_scm_use_bash_and_ruby_build %}}

**Store certain settings**

{{% resource_remote_file_store_certain_settings %}}

batch
=====

{{% resource_batch_summary %}}

**Unzip a file, and then move it**

{{% resource_batch_unzip_file_and_move %}}

bff_package
============

{{% resource_package_bff %}}

**Install a package**

{{% resource_bff_package_install %}}

breakpoint
==========

{{% resource_breakpoint_summary %}}

**A recipe without a breakpoint**

{{% resource_breakpoint_no %}}

**The same recipe with breakpoints**

{{% resource_breakpoint_yes %}}

chef_gem
=========

{{% resource_package_chef_gem %}}

**Install a gems file for use in recipes**

{{% resource_chef_gem_install_for_use_in_recipes %}}

**Install MySQL for Chef**

{{% resource_chef_gem_install_mysql %}}

chef_handler
=============

{{% resource_chef_handler_summary %}}

**Enable the CloudkickHandler handler**

{{% resource_chef_handler_enable_cloudkickhandler %}}

**Enable handlers during the compile phase**

{{% resource_chef_handler_enable_during_compile %}}

**Handle only exceptions**

{{% resource_chef_handler_exceptions_only %}}

**Cookbook Versions (a custom handler)**

{{% handler_custom_example_cookbook_versions %}}

cookbook_versions.rb:

{{% handler_custom_example_cookbook_versions_handler %}}

default.rb:

{{% handler_custom_example_cookbook_versions_recipe %}}

**JsonFile Handler**

{{% handler_custom_example_json_file %}}

**Register the JsonFile handler**

{{% resource_chef_handler_register %}}

**ErrorReport Handler**

{{% handler_custom_example_error_report %}}

chocolatey_package
===================

{{% resource_package_chocolatey %}}

**Install a package**

{{% resource_chocolatey_package_install %}}

cookbook_file
==============

{{% resource_cookbook_file_summary %}}

**Transfer a file**

{{% resource_cookbook_file_transfer_a_file %}}

**Handle cookbook_file and yum_package resources in the same recipe**

{{% resource_package_handle_cookbook_file_and_package %}}

**Install repositories from a file, trigger a command, and force the
internal cache to reload**

{{% resource_package_install_yum_repo_from_file %}}

**Use a case statement**

{{% resource_cookbook_file_use_case_statement %}}

**Manage dotfiles**

{{% resource_directory_manage_dotfiles %}}

cron
====

{{% resource_cron_summary %}}

**Run a program at a specified interval**

{{% resource_cron_run_program_on_fifth_hour %}}

**Run an entry if a folder exists**

{{% resource_cron_run_entry_when_folder_exists %}}

**Run every Saturday, 8:00 AM**

{{% resource_cron_run_every_saturday %}}

**Run only in November**

{{% resource_cron_run_only_in_november %}}

csh
===

{{% resource_script_csh %}}

No examples.

directory
=========

{{% resource_directory_summary %}}

**Create a directory**

{{% resource_directory_create %}}

**Create a directory in Microsoft Windows**

{{% resource_directory_create_in_windows %}}

**Create a directory recursively**

{{% resource_directory_create_recursively %}}

**Delete a directory**

{{% resource_directory_delete %}}

**Set directory permissions using a variable**

{{% resource_directory_set_permissions_with_variable %}}

**Set directory permissions for a specific type of node**

{{% resource_directory_set_permissions_for_specific_node %}}

**Reload the configuration**

{{% resource_ruby_block_reload_configuration %}}

**Manage dotfiles**

{{% resource_directory_manage_dotfiles %}}

dpkg_package
=============

{{% resource_package_dpkg %}}

**Install a package**

{{% resource_dpkg_package_install %}}

dsc_resource
=============

{{% resource_dsc_resource_summary %}}

**Open a Zip file**

{{% resource_dsc_resource_zip_file %}}

**Manage users and groups**

{{% resource_dsc_resource_manage_users %}}

**Create a test message queue**

{{% resource_dsc_resource_manage_msmq %}}

dsc_script
===========

{{% resource_dsc_script_summary %}}

**Specify DSC code directly**

{{% resource_dsc_script_code %}}

**Specify DSC code using a Windows PowerShell data file**

{{% resource_dsc_script_command %}}

**Pass parameters to DSC configurations**

{{% resource_dsc_script_flags %}}

**Use custom configuration data**

{{% resource_dsc_script_custom_config_data %}}

{{% resource_dsc_script_configuration_data %}}

{{% resource_dsc_script_configuration_name %}}

**Using DSC with other Chef resources**

{{% resource_dsc_script_remote_files %}}

env
===

{{% resource_env_summary %}}

**Set an environment variable**

{{% resource_environment_set_variable %}}

execute
=======

{{% resource_execute_summary %}}

**Run a command upon notification**

{{% resource_execute_command_upon_notification %}}

**Run a touch file only once while running a command**

{{% resource_execute_command_with_touch_file %}}

**Run a command which requires an environment variable**

{{% resource_execute_command_with_variable %}}

**Delete a repository using yum to scrub the cache**

{{% resource_yum_package_delete_repo_use_yum_to_scrub_cache %}}

**Install repositories from a file, trigger a command, and force the
internal cache to reload**

{{% resource_package_install_yum_repo_from_file %}}

**Prevent restart and reconfigure if configuration is broken**

{{% resource_execute_subscribes_prevent_restart_and_reconfigure %}}

**Notify in a specific order**

{{% resource_execute_notifies_specific_order %}}

**Execute a command using a template**

{{% resource_execute_command_from_template %}}

**Add a rule to an IP table**

{{% resource_execute_add_rule_to_iptable %}}

**Stop a service, do stuff, and then restart it**

{{% resource_service_stop_do_stuff_start %}}

**Use the platform_family? method**

{{% resource_remote_file_use_platform_family %}}

**Control a service using the execute resource**

{{% resource_execute_control_a_service %}}

**Use the search recipe DSL method to find users**

{{% resource_execute_use_search_dsl_method %}}

**Enable remote login for macOS**

{{% resource_execute_enable_remote_login %}}

**Execute code immediately, based on the template resource**

{{% resource_template_notifies_run_immediately %}}

**Sourcing a file**

{{% resource_execute_source_a_file %}}

**Run a Knife command**

{{% resource_execute_knife_user_create %}}

**Run install command into virtual environment**

{{% resource_execute_install_q %}}

**Run a command as a named user**

{{% resource_execute_bundle_install %}}

file
====

{{% resource_file_summary %}}

**Create a file**

{{% resource_file_create %}}

**Create a file in Microsoft Windows**

{{% resource_file_create_in_windows %}}

**Remove a file**

{{% resource_file_remove %}}

**Set file modes**

{{% resource_file_set_file_mode %}}

**Delete a repository using yum to scrub the cache**

{{% resource_yum_package_delete_repo_use_yum_to_scrub_cache %}}

**Add the value of a data bag item to a file**

{{% resource_file_content_data_bag %}}

**Write a YAML file**

{{% resource_file_content_yaml_config %}}

**Write a string to a file**

{{% resource_file_content_add_string %}}

**Create a file from a copy**

{{% resource_file_copy %}}

freebsd_package
================

{{% resource_package_freebsd %}}

**Install a package**

{{% resource_freebsd_package_install %}}

gem_package
============

{{% resource_package_gem %}}

**Install a gems file from the local file system**

{{% resource_package_install_gems_from_local %}}

**Use the ignore_failure common attribute**

{{% resource_package_use_ignore_failure_attribute %}}

git
===

{{% resource_scm_git %}}

**Use the git mirror**

{{% resource_scm_use_git_mirror %}}

**Use different branches**

{{% resource_scm_use_different_branches %}}

**Install an application from git using bash**

{{% resource_scm_use_bash_and_ruby_build %}}

**Upgrade packages from git**

{{% resource_scm_upgrade_packages %}}

**Pass in environment variables**

{{% resource_scm_git_environment_variables %}}

group
=====

{{% resource_group_summary %}}

**Append users to groups**

{{% resource_group_append_user %}}

**Add a user to group on the Windows platform**

{{% resource_group_add_user_on_windows %}}

homebrew_package
=================

{{% resource_package_homebrew %}}

**Install a package**

{{% resource_homebrew_package_install %}}

**Specify the Homebrew user with a UUID**

{{% resource_homebrew_package_homebrew_user_as_uuid %}}

**Specify the Homebrew user with a string**

{{% resource_homebrew_package_homebrew_user_as_string %}}

http_request
=============

{{% resource_http_request_summary %}}

**Send a GET request**

{{% resource_http_request_send_get %}}

Changed in Chef Client 12.0 to deprecate the hard-coded query string
from earlier versions. Cookbooks that rely on this string need to be
updated to manually add it to the URL as it is passed to the resource.

**Send a POST request**

{{% resource_http_request_send_post %}}

**Transfer a file only when the remote source changes**

{{% resource_remote_file_transfer_remote_source_changes %}}

ifconfig
========

{{% resource_ifconfig_summary %}}

**Configure a network interface**

{{% resource_ifconfig_boot_protocol %}}

**Specify a boot protocol**

{{% resource_ifconfig_configure_network_interface %}}

**Specify a static IP address**

{{% resource_ifconfig_static_ip_address %}}

**Update a static IP address with a boot protocol**

{{% resource_ifconfig_update_static_ip_with_boot_protocol %}}

ips_package
============

{{% resource_package_ips %}}

**Install a package**

{{% resource_ips_package_install %}}

ksh
===

{{% resource_script_ksh %}}

No examples.

link
====

{{% resource_link_summary %}}

**Create symbolic links**

{{% resource_link_create_symbolic %}}

**Create hard links**

{{% resource_link_create_hard %}}

**Delete links**

{{% resource_link_delete %}}

**Create multiple symbolic links**

{{% resource_link_multiple_links_files %}}

**Create platform-specific symbolic links**

{{% resource_link_multiple_links_redhat %}}

log
===

{{% resource_log_summary %}}

**Set default logging level**

{{% resource_log_set_info %}}

**Set debug logging level**

{{% resource_log_set_debug %}}

**Add a message to a log file**

{{% resource_log_add_message %}}

macports_package
=================

{{% resource_package_macports %}}

**Install a package**

{{% resource_macports_package_install %}}

mdadm
=====

Use the **mdadm** resource to manage RAID devices in a Linux environment
using the mdadm utility. The **mdadm** resource will create and assemble
an array, but it will not create the config file that is used to persist
the array upon reboot. If the config file is required, it must be done
by specifying a template with the correct array layout, and then by
using the **mount** resource to create a file systems table (fstab)
entry.

**Create and assemble a RAID 0 array**

{{% resource_mdadm_raid0 %}}

**Create and assemble a RAID 1 array**

{{% resource_mdadm_raid1 %}}

**Create and assemble a RAID 5 array**

{{% resource_mdadm_raid5 %}}

mount
=====

Use the **mount** resource to manage a mounted file system.

**Mount a labeled file system**

{{% resource_mount_labeled_file_system %}}

**Mount a local block drive**

{{% resource_mount_local_block_device %}}

**Mount a non-block file system**

{{% resource_mount_nonblock_file_system %}}

**Mount and add to the file systems table**

{{% resource_mount_remote_file_system_add_to_fstab %}}

**Mount a remote file system**

{{% resource_mount_remote_file_system %}}

**Mount a remote folder in Microsoft Windows**

{{% resource_mount_remote_windows_folder %}}

**Unmount a remote folder in Microsoft Windows**

{{% resource_mount_unmount_remote_windows_drive %}}

**Stop a service, do stuff, and then restart it**

{{% resource_service_stop_do_stuff_start %}}

ohai
====

{{% resource_ohai_summary %}}

**Reload Ohai**

{{% resource_ohai_reload %}}

**Reload Ohai after a new user is created**

{{% resource_ohai_reload_after_create_user %}}

openbsd_package
================

{{% resource_package_openbsd %}}

**Install a package**

{{% resource_openbsd_package_install %}}

osx_profile
============

{{% resource_osx_profile_summary %}}

**One liner to install profile from cookbook file**

{{% resource_osx_profile_install_file_oneline %}}

**Install profile from cookbook file**

{{% resource_osx_profile_install_file %}}

**Install profile from a hash**

{{% resource_osx_profile_install_hash %}}

**Remove profile using identifier in resource name**

{{% resource_osx_profile_remove_by_name %}}

**Remove profile by identifier and user friendly resource name**

{{% resource_osx_profile_remove_by_identifier %}}

package
=======

{{% resource_package_summary %}}

**Install a gems file for use in recipes**

{{% resource_package_install_gems_for_chef_recipe %}}

**Install a gems file from the local file system**

{{% resource_package_install_gems_from_local %}}

**Install a package**

{{% resource_package_install %}}

**Install a package version**

{{% resource_package_install_version %}}

**Install a package with options**

{{% resource_package_install_with_options %}}

**Install a package with a response_file**

{{% resource_package_install_with_response_file %}}

**Install a package using a specific provider**

``` ruby
package 'tar' do
  action :install
  source '/tmp/tar-1.16.1-1.rpm'
  provider Chef::Provider::Package::Rpm
end
```

**Install a specified architecture using a named provider**

{{% resource_package_install_with_yum %}}

**Purge a package**

{{% resource_package_purge %}}

**Remove a package**

{{% resource_package_remove %}}

**Upgrade a package**

{{% resource_package_upgrade %}}

**Use the ignore_failure common attribute**

{{% resource_package_use_ignore_failure_attribute %}}

**Use the provider common attribute**

``` ruby
package 'some_package' do
  provider Chef::Provider::Package::Rubygems
end
```

**Avoid unnecessary string interpolation**

{{% resource_package_avoid_unnecessary_string_interpolation %}}

**Install a package in a platform**

{{% resource_package_install_package_on_platform %}}

**Install sudo, then configure /etc/sudoers/ file**

{{% resource_package_install_sudo_configure_etc_sudoers %}}

**Use a case statement to specify the platform**

{{% resource_package_use_case_statement %}}

**Use symbols to reference attributes**

{{% resource_package_use_symbols_to_reference_attributes %}}

**Use a whitespace array to simplify a recipe**

{{% resource_package_use_whitespace_array %}}

**Specify the Homebrew user with a UUID**

{{% resource_homebrew_package_homebrew_user_as_uuid %}}

**Specify the Homebrew user with a string**

{{% resource_homebrew_package_homebrew_user_as_string %}}

pacman_package
===============

{{% resource_package_pacman %}}

**Install a package**

{{% resource_pacman_package_install %}}

paludis_package
================

{{% resource_package_paludis %}}

**Install a package**

{{% resource_paludis_package_install %}}

perl
====

{{% resource_script_perl %}}

No examples.

portage_package
================

{{% resource_package_portage %}}

**Install a package**

{{% resource_portage_package_install %}}

powershell_script
==================

{{% resource_powershell_script_summary %}}

**Write to an interpolated path**

{{% resource_powershell_write_to_interpolated_path %}}

**Change the working directory**

{{% resource_powershell_cwd %}}

**Change the working directory in Microsoft Windows**

{{% resource_powershell_cwd_microsoft_env %}}

**Pass an environment variable to a script**

{{% resource_powershell_pass_env_to_script %}}

**Evaluate for true and/or false**

{{% resource_powershell_convert_boolean_return %}}

**Use the flags attribute**

{{% resource_powershell_script_use_flag %}}

**Rename computer, join domain, reboot**

{{% resource_powershell_rename_join_reboot %}}

python
======

{{% resource_script_python %}}

No examples.

reboot
======

{{% resource_service_reboot %}}

**Reboot a node immediately**

{{% resource_service_reboot_immediately %}}

**Reboot a node at the end of a Chef Infra Client run**

{{% resource_service_reboot_request %}}

**Cancel a reboot**

{{% resource_service_reboot_cancel %}}

**Rename computer, join domain, reboot**

{{% resource_powershell_rename_join_reboot %}}

registry_key
=============

{{% resource_registry_key_summary %}}

**Create a registry key**

{{% resource_registry_key_create %}}

**Delete a registry key value**

{{% resource_registry_key_delete_value %}}

**Delete a registry key and its subkeys, recursively**

{{% resource_registry_key_delete_recursively %}}

{{< info >}}

{{% notes_registry_key_resource_recursive %}}

{{< /info >}}

**Use re-directed keys**

{{% resource_registry_key_redirect %}}

**Set proxy settings to be the same as those used by Chef Infra Client**

{{% resource_registry_key_set_proxy_settings_to_same_as_chef_client %}}

**Set the name of a registry key to "(Default)"**

{{% resource_registry_key_set_default %}}

remote_directory
=================

{{% resource_remote_directory_summary %}}

**Recursively transfer a directory from a remote location**

{{% resource_remote_directory_recursive_transfer %}}

**Use with the chef_handler resource**

{{% resource_remote_directory_report_handler %}}

remote_file
============

{{% resource_remote_file_summary %}}

**Transfer a file from a URL**

{{% resource_remote_file_transfer_from_url %}}

**Install a file from a remote location using bash**

{{% resource_remote_file_install_with_bash %}}

**Store certain settings**

{{% resource_remote_file_store_certain_settings %}}

**Use the platform_family? method**

{{% resource_remote_file_use_platform_family %}}

**Specify local Windows file path as a valid URI**

{{% resource_remote_file_local_windows_path %}}

route
=====

{{% resource_route_summary %}}

**Add a host route**

{{% resource_route_add_host %}}

**Delete a network route**

{{% resource_route_delete_network %}}

rpm_package
============

{{% resource_package_rpm %}}

**Install a package**

{{% resource_rpm_package_install %}}

ruby
====

{{% resource_script_ruby %}}

No examples.

ruby_block
===========

{{% resource_ruby_block_summary %}}

**Re-read configuration data**

{{% resource_ruby_block_reread_chef_client %}}

**Install repositories from a file, trigger a command, and force the
internal cache to reload**

{{% resource_package_install_yum_repo_from_file %}}

**Use an if statement with the platform recipe DSL method**

{{% resource_ruby_block_if_statement_use_with_platform %}}

**Stash a file in a data bag**

{{% resource_ruby_block_stash_file_in_data_bag %}}

**Update the /etc/hosts file**

{{% resource_ruby_block_update_etc_host %}}

**Set environment variables**

{{% resource_ruby_block_use_variables_to_set_env_variables %}}

**Set JAVA_HOME**

{{% resource_ruby_block_use_variables_to_set_java_home %}}

**Reload the configuration**

{{% resource_ruby_block_reload_configuration %}}

script
======

{{% resource_script_summary %}}

**Use a named provider to run a script**

{{% resource_script_bash_provider_and_interpreter %}}

**Run a script**

{{% resource_script_bash_script %}}

**Install a file from a remote location using bash**

{{% resource_remote_file_install_with_bash %}}

**Install an application from git using bash**

{{% resource_scm_use_bash_and_ruby_build %}}

**Store certain settings**

{{% resource_remote_file_store_certain_settings %}}

service
=======

Use the **service** resource to manage a service.

**Start a service**

{{% resource_service_start_service %}}

**Start a service, enable it**

{{% resource_service_start_service_and_enable_at_boot %}}

**Use a pattern**

{{% resource_service_process_table_has_different_value %}}

**Use the :nothing common action**

{{% resource_service_use_nothing_action %}}

**Use the retries common attribute**

{{% resource_service_use_supports_attribute %}}

**Use the retries and provider common attributes**

``` ruby
service 'some_service' do
  provider Chef::Provider::Service::Upstart
  action [ :enable, :start ]
  retries 3
end
```

**Manage a service, depending on the node platform**

{{% resource_service_manage_ssh_based_on_node_platform %}}

**Change a service provider, depending on the node platform**

{{% resource_service_change_service_provider_based_on_node %}}

**Reload a service using a template**

{{% resource_service_subscribes_reload_using_template %}}

**Enable a service after a restart or reload**

{{% resource_service_notifies_enable_after_restart_or_reload %}}

**Set an IP address using variables and a template**

{{% resource_template_set_ip_address_with_variables_and_template %}}

**Use a cron timer to manage a service**

{{% resource_service_use_variable %}}

**Restart a service, and then notify a different service**

{{% resource_service_restart_and_notify %}}

**Stop a service, do stuff, and then restart it**

{{% resource_service_stop_do_stuff_start %}}

**Control a service using the execute resource**

{{% resource_execute_control_a_service %}}

**Enable a service on AIX using the mkitab command**

{{% resource_service_aix_mkitab %}}

smartos_package
================

{{% resource_package_smartos %}}

**Install a package**

{{% resource_smartos_package_install %}}

solaris_package
================

The **solaris_package** resource is used to manage packages for the
Solaris platform.

**Install a package**

{{% resource_solaris_package_install %}}

subversion
==========

Use the **subversion** resource to manage source control resources that
exist in a Subversion repository.

**Get the latest version of an application**

{{% resource_scm_get_latest_version %}}

template
========

{{% resource_template_summary %}}

**Configure a file from a template**

{{% resource_template_configure_file %}}

**Configure a file from a local template**

{{% resource_template_configure_file_from_local %}}

**Configure a file using a variable map**

{{% resource_template_configure_file_with_variable_map %}}

**Use the not_if condition**

{{% resource_template_add_file_not_if_attribute_has_value %}}

{{% resource_template_add_file_not_if_ruby %}}

{{% resource_template_add_file_not_if_ruby_with_curly_braces %}}

{{% resource_template_add_file_not_if_string %}}

**Use the only_if condition**

{{% resource_template_add_file_only_if_attribute_has_value %}}

{{% resource_template_add_file_only_if_ruby %}}

{{% resource_template_add_file_only_if_string %}}

**Use a whitespace array (%w)**

{{% resource_template_use_whitespace_array %}}

**Use a relative path**

{{% resource_template_use_relative_paths %}}

**Delay notifications**

{{% resource_template_notifies_delay %}}

**Notify immediately**

{{% resource_template_notifies_run_immediately %}}

**Notify multiple resources**

{{% resource_template_notifies_multiple_resources %}}

**Reload a service**

{{% resource_template_notifies_reload_service %}}

**Restart a service when a template is modified**

{{% resource_template_notifies_restart_service_when_template_modified %}}

**Send notifications to multiple resources**

{{% resource_template_notifies_send_notifications_to_multiple_resources %}}

**Execute a command using a template**

{{% resource_execute_command_from_template %}}

**Set an IP address using variables and a template**

{{% resource_template_set_ip_address_with_variables_and_template %}}

**Add a rule to an IP table**

{{% resource_execute_add_rule_to_iptable %}}

**Apply proxy settings consistently across a Chef organization**

{{% resource_template_consistent_proxy_settings %}}

**Get template settings from a local file**

{{% resource_template_get_settings_from_local_file %}}

**Pass values from recipe to template**

{{% resource_template_pass_values_to_template_from_recipe %}}

user
====

{{% resource_user_summary %}}

**Create a user named "random"**

{{% resource_user_create_random %}}

**Create a system user**

{{% resource_user_create_system %}}

**Create a system user with a variable**

{{% resource_user_create_system_user_with_variable %}}

**Use SALTED-SHA512 passwords**

macOS 10.7 calculates the password shadow hash using SALTED-SHA512. The
length of the shadow hash value is 68 bytes, the salt value is the first
4 bytes, with the remaining 64 being the shadow hash itself. The
following code will calculate password shadow hashes for macOS 10.7:

``` ruby
password = 'my_awesome_password'
salt = OpenSSL::Random.random_bytes(4)
encoded_password = OpenSSL::Digest::SHA512.hexdigest(salt + password)
shadow_hash = salt.unpack('H*').first + encoded_password
```

Use the calculated password shadow hash with the **user** resource:

``` ruby
user 'my_awesome_user' do
  password 'c9b3bd....d843'  # Length: 136
end
```

**Use SALTED-SHA512-PBKDF2 passwords**

{{% resource_user_password_shadow_hash_salted_sha512_pbkdf2 %}}

windows_package
================

{{% resource_package_windows %}}

**Install a package**

{{% resource_windows_package_install %}}

**Specify a URL for the source attribute**

{{% resource_package_windows_source_url %}}

**Specify path and checksum**

{{% resource_package_windows_source_url_checksum %}}

**Modify remote_file resource attributes**

{{% resource_package_windows_source_remote_file_properties %}}

**Download a nsis (Nullsoft) package resource**

{{% resource_package_windows_download_nsis_package %}}

**Download a custom package**

{{% resource_package_windows_download_custom_package %}}

windows_service
================

{{% resource_service_windows %}}

**Start a service manually**

{{% resource_service_windows_manual_start %}}

yum_package
============

{{% resource_package_yum %}}

**Install an exact version**

{{% resource_yum_package_install_exact_version %}}

**Install a minimum version**

{{% resource_yum_package_install_minimum_version %}}

**Install a minimum version using the default action**

{{% resource_yum_package_install_package_using_default_action %}}

**To install a package**

{{% resource_yum_package_install_package %}}

**To install a partial minimum version**

{{% resource_yum_package_install_partial_minimum_version %}}

**To install a specific architecture**

{{% resource_yum_package_install_specific_architecture %}}

**To install a specific version-release**

{{% resource_yum_package_install_specific_version_release %}}

**Handle cookbook_file and yum_package resources in the same recipe**

{{% resource_package_handle_cookbook_file_and_package %}}
