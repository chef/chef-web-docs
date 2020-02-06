---
title: load_balancer resource
resource: load_balancer
draft: false
aliases: /resource_load_balancer.html
resource_reference: false
robots: noindex, nofollow
resource_description_list:
- warning:
    shortcode: EOL_provisioning.md
- markdown: 'Use the **load_balancer** resource to create or destroy a load

    balancer.'
resource_new_in: null
handler_types: false
syntax_description: 'The syntax for using the **load_balancer** resource in a recipe
  is as follows:'
syntax_code_block: "load_balancer 'name' do\n  attribute 'value' # see properties\
  \ section below\n  ...\n  action :action # see actions section below\nend"
syntax_properties_list:
- '`load_balancer` tells Chef Infra Client to use the `Chef::Provider::LoadBalancer`
  provider during a Chef Infra Client run'
- '`name` is the name of the resource block'
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
  :create:
    markdown: Default.
  :destroy:
    markdown: ''
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: driver
  ruby_type: Chef::Provisioning::Driver
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify the driver to be used for provisioning.
- property: load_balancer_options
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '...'
- property: machines
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '...'
- property: name
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The name of the load balancer.
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list: null

---
