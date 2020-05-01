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
title: windows_path resource
resource: windows_path
aliases:
- "/resource_windows_path.html"
menu:
  infra:
    title: windows_path
    identifier: chef_infra/cookbook_reference/resources/windows_path windows_path
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **windows_path** resource to manage the path environment variable
    on Microsoft Windows.
resource_new_in: '13.4'
syntax_full_code_block: |-
  windows_path 'name' do
    path      String # default value: 'name' unless specified
    action    Symbol # defaults to :add if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`windows_path` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`path` is the property available to this resource."
actions_list:
  :add:
    markdown: Add an item to the system path
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :remove:
    markdown: Remove an item from the system path
properties_list:
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to set the path value if it differs from the resource
      block's name.
examples: |
  **Add Sysinternals to the system path**:

  ```ruby
  windows_path 'C:\Sysinternals' do
    action :add
  end
  ```

  **Remove 7-Zip from the system path**:

  ```ruby
  windows_path 'C:\7-Zip' do
    action :remove
  end
  ```
---