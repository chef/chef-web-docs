---
title: chocolatey_feature resource
resource: chocolatey_feature
draft: false
aliases:
- /resource_chocolatey_feature.html
menu:
  infra:
    title: chocolatey_feature
    identifier: chef_infra/cookbook_reference/resources/chocolatey_feature chocolatey_feature
    parent: chef_infra/cookbook_reference/resources
    weight: 340
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **chocolatey_feature** resource to enable and disable

    Chocolatey features.'
- note:
    markdown: 'The Chocolatey package manager is not installed on Windows by default.

      Install it prior to using this resource by adding the [Chocolatey

      cookbook](https://supermarket.chef.io/cookbooks/chocolatey/) to your

      node''s run list.'
resource_new_in: '15.1'
handler_types: false
syntax_description: "The chocolatey_feature resource has the following syntax:\n\n\
  ``` ruby\nchocolatey_feature 'name' do\n  feature_name      String # default value:\
  \ 'name' unless specified\n  action            Symbol # defaults to :enable if not\
  \ specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`chocolatey_feature` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`feature_name` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :disable:
    markdown: Disable a Chocolatey Feature.
  :enable:
    markdown: Enable a Chocolatey Feature.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: feature_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: The name of the Chocolatey feature to enable or disable.
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
- example_heading: Enable the checksumFiles Chocolatey feature
  text_blocks:
  - code_block: "chocolatey_feature 'checksumFiles' do\n  action :enable\nend"
- example_heading: Disable the checksumFiles Chocolatey feature
  text_blocks:
  - code_block: "chocolatey_feature 'checksumFiles' do\n  action :disable\nend"

---
