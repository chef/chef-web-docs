---
draft: false
resource_reference: true
robots:
syntax_code_block:
common_resource_functionality_multiple_packages: false
common_resource_functionality_resources_common_windows_security: false
cookbook_file_specificity: false
debug_recipes_chef_shell: false
handler_custom: false
handler_types: false
nameless_apt_update: false
nameless_build_essential: false
properties_multiple_packages: false
properties_resources_common_windows_security: false
properties_shortcode:
ps_credential_helper: false
registry_key: false
remote_directory_recursive_directories: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
resource_directory_recursive_directories: false
resource_package_options: false
resources_common_atomic_update: false
resources_common_guard_interpreter: false
resources_common_guards: true
resources_common_notification: true
resources_common_properties: true
ruby_style_basics_chef_log: false
syntax_shortcode:
template_requirements: false
unit_file_verification: false
title: chef_client_scheduled_task resource
resource: chef_client_scheduled_task
aliases:
- "/resource_chef_client_scheduled_task.html"
menu:
  infra:
    title: chef_client_scheduled_task
    identifier: chef_infra/cookbook_reference/resources/chef_client_scheduled_task
      chef_client_scheduled_task
    parent: chef_infra/cookbook_reference/resources

resource_description_list:
- markdown: Use the chef_client_cron resource to setup the Chef Infra Client to run
    as a Windows scheduled task. This resource will also create the specified log
    directory if it doesn't already exist.
resource_new_in: '16.0'
syntax_full_code_block: |-
  chef_client_scheduled_task 'name' do
    accept_chef_license      true, false # default value: false
    chef_binary_path         String # default value: "C:/opscode/chef/bin/chef-client"
    config_directory         String # default value: "/etc/chef"
    daemon_options           Array
    frequency                String # default value: "minute"
    frequency_modifier       Integer, String # default value: 30
    log_directory            String # default value: "CONFIG_DIRECTORY/log"
    log_file_name            String # default value: "client.log"
    password                 String
    run_on_battery           true, false # default value: true
    splay                    Integer, String # default value: 300
    start_date               String
    start_time               String
    task_name                String # default value: "chef-client"
    user                     String # default value: "System"
    action                   Symbol # defaults to :add if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`chef_client_scheduled_task` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "``accept_chef_license``, ``chef_binary_path``, ``config_directory``, ``daemon_options``,
  ``frequency``, ``frequency_modifier``, ``log_directory``, ``log_file_name``, ``password``,
  ``run_on_battery``, ``splay``, ``start_date``, ``start_time``, ``task_name``, and
  ``user`` are the properties available to this resource."
properties_list:
- property: accept_chef_license
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in:
  description_list:
  - markdown: Accept the Chef Online Master License and Services Agreement. See <https://www.chef.io/online-master-agreement/>
- property: chef_binary_path
  ruby_type: String
  required: false
  default_value: C:/opscode/chef/bin/chef-client
  new_in:
  description_list:
  - markdown: The path to the chef-client binary.
- property: config_directory
  ruby_type: String
  required: false
  default_value: "/etc/chef"
  new_in:
  description_list:
  - markdown: The path of the config directory.
- property: daemon_options
  ruby_type: Array
  required: false
  default_value: lazy default
  new_in:
  description_list:
  - markdown: An array of options to pass to the chef-client command.
- property: frequency
  ruby_type: String
  required: false
  default_value: minute
  new_in:
  description_list:
  - markdown: Frequency with which to run the task.
- property: frequency_modifier
  ruby_type: Integer, String
  required: false
  default_value: '30'
  new_in:
  description_list:
  - markdown: Numeric value to go with the scheduled task frequency
- property: log_directory
  ruby_type: String
  required: false
  default_value: CONFIG_DIRECTORY/log
  new_in:
  description_list:
  - markdown: The path of the directory to create the log file in.
- property: log_file_name
  ruby_type: String
  required: false
  default_value: client.log
  new_in:
  description_list:
  - markdown: The name of the log file to use.
- property: password
  ruby_type: String
  required: false
  default_value:
  new_in:
  description_list:
  - markdown: The password for the user that Chef Infra Client runs as.
- property: run_on_battery
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in:
  description_list:
  - markdown: Run the Chef Infra Client task when the system is on batteries.
- property: splay
  ruby_type: Integer, String
  required: false
  default_value: '300'
  new_in:
  description_list:
  - markdown: A random number of seconds between 0 and X to add to interval so that
      all chef-client commands don't execute at the same time.
- property: start_date
  ruby_type: String
  required: false
  default_value:
  new_in:
  description_list:
  - markdown: 'The start date for the task in m:d:Y format (ex: 12/17/2020).'
- property: start_time
  ruby_type: String
  required: false
  default_value:
  new_in:
  description_list:
  - markdown: 'The start time for the task in HH:mm format (ex: 14:00). If the frequency
      is minute default start time will be Time.now plus the frequency_modifier number
      of minutes.'
- property: task_name
  ruby_type: String
  required: false
  default_value: chef-client
  new_in:
  description_list:
  - markdown: The name of the scheduled task to create.
- property: user
  ruby_type: String
  required: false
  default_value: System
  new_in:
  description_list:
  - markdown: The name of the user that Chef Infra Client runs as.

---