---
resource_reference: true
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
title: chocolatey_config resource
resource: chocolatey_config
aliases:
- "/resource_chocolatey_config.html"
menu:
  infra:
    title: chocolatey_config
    identifier: chef_infra/cookbook_reference/resources/chocolatey_config chocolatey_config
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **chocolatey_config** resource to add or remove Chocolatey configuration
    keys.
resource_new_in: '14.3'
syntax_full_code_block: |-
  chocolatey_config 'name' do
    config_key      String # default value: 'name' unless specified
    value           String
    action          Symbol # defaults to :set if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`chocolatey_config` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`config_key` and `value` are the properties available to this resource."
actions_list:
  :set:
    markdown: Default. Sets a Chocolatey config value.
  :unset:
    markdown: Unsets a Chocolatey config value.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: config_key
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to set the config key name if it differs from the
      resource block's name.
- property: value
  ruby_type: String
  required: false
  description_list:
  - markdown: The value to set.
examples: "**Set the Chocolatey cacheLocation config**:\n\n```ruby\nchocolatey_config
  'Set cacheLocation config' do\n  config_key 'cacheLocation'\n  value 'C:\temp\boco'\nend\n```\n\n**Unset
  a Chocolatey config**:\n\n```ruby\nchocolatey_config 'BogusConfig' do\n  action
  :unset\nend\n```\n"
---