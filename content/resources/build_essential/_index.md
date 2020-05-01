---
resource_reference: true
common_resource_functionality_multiple_packages: false
common_resource_functionality_resources_common_windows_security: false
cookbook_file_specificity: false
debug_recipes_chef_shell: false
handler_custom: false
handler_types: false
nameless_apt_update: false
nameless_build_essential: true
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
title: build_essential resource
resource: build_essential
aliases:
- "/resource_build_essential.html"
menu:
  infra:
    title: build_essential
    identifier: chef_infra/cookbook_reference/resources/build_essential build_essential
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **build_essential** resource to install the packages required
    for compiling C software from source.
resource_new_in: '14.0'
syntax_full_code_block: |-
  build_essential 'name' do
    raise_if_unsupported      true, false # default value: false
    action                    Symbol # defaults to :install if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`build_essential` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`raise_if_unsupported` is the property available to this resource."
actions_list:
  :install:
    markdown: Default. Install the build essential packages.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :upgrade:
    markdown: Upgrade the Xcode CLI Tools on macOS hosts. **New in Chef Infra Client 16**
properties_list:
- property: raise_if_unsupported
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '15.5'
  description_list:
  - markdown: Raise a hard error on platforms where this resource is unsupported.
examples: |
  **Install compilation packages**:

  ```ruby
  build_essential
  ```

  **Install compilation packages during the compilation phase**:

  ```ruby
  build_essential 'Install compilation tools' do
    compile_time true
  end
  ```

  **Upgrade compilation packages on macOS systems**:

  ```ruby
  build_essential 'Install compilation tools' do
    action :upgrade
  end
  ```
---