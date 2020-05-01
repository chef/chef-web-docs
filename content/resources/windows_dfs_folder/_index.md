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
title: windows_dfs_folder resource
resource: windows_dfs_folder
aliases:
- "/resource_windows_dfs_folder.html"
menu:
  infra:
    title: windows_dfs_folder
    identifier: chef_infra/cookbook_reference/resources/windows_dfs_folder windows_dfs_folder
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **windows_dfs_folder** resource to creates a folder within DFS
    as many levels deep as required.
resource_new_in: '15.0'
syntax_full_code_block: |-
  windows_dfs_folder 'name' do
    description         String
    folder_path         String # default value: 'name' unless specified
    namespace_name      String
    target_path         String
    action              Symbol # defaults to :create if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`windows_dfs_folder` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`description`, `folder_path`, `namespace_name`, and `target_path` are the properties
  available to this resource."
actions_list:
  :delete:
    markdown: Deletes the folder in the dfs namespace.
  :create:
    markdown: Creates the folder in dfs namespace. Default.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: description
  ruby_type: String
  required: false
  description_list:
  - markdown: Description for the share.
- property: folder_path
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to set the path of the dfs folder if it differs
      from the resource block's name.
- property: namespace_name
  ruby_type: String
  required: true
  description_list:
  - markdown: The namespace this should be created within.
- property: target_path
  ruby_type: String
  required: false
  description_list:
  - markdown: The target that this path will connect you to.
examples: 
---