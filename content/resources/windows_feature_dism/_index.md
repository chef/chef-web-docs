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
title: windows_feature_dism resource
resource: windows_feature_dism
aliases:
- "/resource_windows_feature_dism.html"
menu:
  infra:
    title: windows_feature_dism
    identifier: chef_infra/cookbook_reference/resources/windows_feature_dism windows_feature_dism
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **windows_feature_dism** resource to add, remove, or entirely
    delete Windows features and roles using DISM.
resource_new_in: '14.0'
syntax_full_code_block: |-
  windows_feature_dism 'name' do
    all               true, false # default value: false
    feature_name      Array, String # default value: 'name' unless specified
    source            String
    timeout           Integer # default value: 600
    action            Symbol # defaults to :install if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`windows_feature_dism` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`all`, `feature_name`, `source`, and `timeout` are the properties available to
  this resource."
actions_list:
  :delete:
    markdown: Delete a Windows role / feature from the image using DISM.
  :install:
    markdown: Default. Install a Windows role / feature using DISM.
  :remove:
    markdown: Remove a Windows role / feature using DISM.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: all
  ruby_type: true, false
  required: false
  default_value: 'false'
  description_list:
  - markdown: Install all sub-features. When set to `true`, this is the equivalent
      of specifying the `/All` switch to `dism.exe`
- property: feature_name
  ruby_type: Array, String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: The name of the feature(s) or role(s) to install if they differ from
      the resource name.
- property: source
  ruby_type: String
  required: false
  description_list:
  - markdown: Specify a local repository for the feature install.
- property: timeout
  ruby_type: Integer
  required: false
  default_value: '600'
  description_list:
  - markdown: Specifies a timeout (in seconds) for the feature installation.
examples: |
  **Installing the TelnetClient service**:

  ```ruby
  windows_feature_dism "TelnetClient"
  ```

  **Installing two features by using an array**:

  ```ruby
  windows_feature_dism %w(TelnetClient TFTP)
  ```
---