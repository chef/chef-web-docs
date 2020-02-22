---
title: chef_sleep resource
resource: chef_sleep
draft: false
aliases:
- /resource_chef_sleep.html
menu:
  docs:
    title: chef_sleep
    identifier: chef_infra/cookbook_reference/resources/chef_sleep chef_sleep
    parent: chef_infra/cookbook_reference/resources
    weight: 190
resource_reference: true
robots: null
resource_description_list:
- markdown: 'The **chef_sleep** resource will pause a Chef Infra Client run for a

    set number of seconds. Only use this resource when a command or service

    exits successfully but is not ready for the next step in a recipe.'
resource_new_in: '15.5'
handler_types: false
syntax_description: "The chef_sleep resource has the following syntax:\n\n``` ruby\n\
  chef_sleep 'name' do\n  seconds      String, Integer # default value: 'name' unless\
  \ specified\n  action       Symbol # defaults to :sleep if not specified\nend\n\
  ```"
syntax_code_block: null
syntax_properties_list:
- '`chef_sleep` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`seconds` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :sleep:
    markdown: Pause the Chef Infra Client run for a specified number of seconds.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: seconds
  ruby_type: String, Integer
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: The number of seconds to sleep.
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
resources_common_properties: true
resources_common_notification: true
resources_common_guards: true
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Sleep for 10 seconds
  text_blocks:
  - code_block: chef_sleep '10'
- example_heading: Sleep for 10 seconds with a descriptive resource name for logging
  text_blocks:
  - code_block: "chef_sleep 'wait for the service to start' do\n  seconds 10\nend"
- example_heading: 'Use a notification from another resource to sleep only when

    necessary'
  text_blocks:
  - code_block: "service 'Service that is slow to start and reports as started' do\n\
      \  service_name 'my_database'\n  action :start\n  notifies :sleep, chef_sleep['wait\
      \ for service start']\nend\n\nchef_sleep 'wait for service start' do\n  seconds\
      \ 30\n  action :nothing\nend"

---
