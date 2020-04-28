---
title: chocolatey_config resource
resource: chocolatey_config
draft: false
aliases:
- "/resource_chocolatey_config.html"
menu:
  infra:
    title: chocolatey_config
    identifier: chef_infra/cookbook_reference/resources/chocolatey_config chocolatey_config
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **chocolatey_config** resource to add or remove Chocolatey

    configuration keys.'
- note:
    markdown: 'The Chocolatey package manager is not installed on Windows by default.

      Install it prior to using this resource by adding the [Chocolatey

      cookbook](https://supermarket.chef.io/cookbooks/chocolatey/) to your

      node''s run list.'
resource_new_in: '14.3'
handler_types: false
syntax_description: "The chocolatey_config resource has the following syntax:\n\n\
  ``` ruby\nchocolatey_config 'name' do\n  config_key      String # default value:\
  \ 'name' unless specified\n  value           String\n  action          Symbol #\
  \ defaults to :set if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`chocolatey_config` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`config_key` and `value` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
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
  new_in: null
  description_list:
  - markdown: 'An optional property to set the config key name if it differs from

      the resource block''s name.'
- property: value
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The value to set.
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
- example_heading: Set the Chocolatey cacheLocation config
  text_blocks:
  - code_block: "chocolatey_config 'Set cacheLocation config' do\n  config_key 'cacheLocation'\n\
      \  value 'C:  empoco'\nend"
- example_heading: Unset a Chocolatey config
  text_blocks:
  - code_block: "chocolatey_config 'BogusConfig' do\n  action :unset\nend"

---
