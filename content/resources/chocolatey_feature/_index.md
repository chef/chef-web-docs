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
template_requirements: false
unit_file_verification: false
title: chocolatey_feature resource
resource: chocolatey_feature
aliases:
- "/resource_chocolatey_feature.html"
menu:
  infra:
    title: chocolatey_feature
    identifier: chef_infra/cookbook_reference/resources/chocolatey_feature chocolatey_feature
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **chocolatey_feature** resource to enable and disable Chocolatey
    features.
- note:
    markdown: 'The Chocolatey package manager is not installed on Windows by default.

      Install it prior to using this resource by adding the [Chocolatey

      cookbook](https://supermarket.chef.io/cookbooks/chocolatey/) to your

      node''s run list.'
resource_new_in: '15.1'
syntax_full_code_block: |-
  chocolatey_feature 'name' do
    feature_name      String # default value: 'name' unless specified
    action            Symbol # defaults to :enable if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`chocolatey_feature` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`feature_name` is the property available to this resource."
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
  description_list:
  - markdown: The name of the Chocolatey feature to enable or disable.
examples: |
  **Enable the checksumFiles Chocolatey feature**

  ```ruby
  chocolatey_feature 'checksumFiles' do
    action :enable
  end
  ```

  **Disable the checksumFiles Chocolatey feature**

  ```ruby
  chocolatey_feature 'checksumFiles' do
    action :disable
  end
  ```
---