---
title: machine_execute resource
resource: machine_execute
draft: false
aliases:
- /resource_machine_execute.html
resource_reference: false
robots: noindex, nofollow
resource_description_list:
- markdown: 'Use the **machine_execute** resource to run a command on a remote

    machine in much the same way the **execute** resource is used to run a

    command on a local machine.'
- warning:
    shortcode: EOL_provisioning.md
resource_new_in: null
handler_types: false
syntax_description: "The syntax for using the **machine_execute** resource in a recipe\
  \ is as\nfollows:\n\n``` ruby\nmachine_execute 'name' do\n  attribute 'value' #\
  \ see properties section below\n  ...\n  action :action # see actions section below\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`machine_execute` tells Chef Infra Client to use the `Chef::Provider::MachineExecute`
  provider during a Chef Infra Client run'
- '`name` is the name of the resource block; when the `command` property is not specified
  as part of a recipe, `name` is also the command to be run'
- '`attribute` is zero (or more) of the properties that are available for this resource'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :run:
    markdown: Default. Use to run a machine.
properties_list:
- property: chef_server
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The URL for the Chef Infra Server.
- property: command
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The name of the command to be executed. Default value: the `name` of

      the resource block. See "Syntax" section above for more information.'
- property: driver
  ruby_type: Chef::Provisioning::Driver
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify the driver to be used for provisioning.
- property: live_stream
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list: []
- property: machine
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify the machine type.
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: false
properties_resources_common_windows_security: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
ps_credential_helper: false
ruby_style_basics_chef_log: false
debug_recipes_chef_shell: false
template_requirements: false
resources_common_properties: false
resources_common_notification: false
resources_common_guards: false
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list: null

---
