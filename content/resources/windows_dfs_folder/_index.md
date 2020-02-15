---
title: windows_dfs_folder resource
resource: windows_dfs_folder
draft: false
aliases:
- /resource_windows_dfs_folder.html
menu:
  docs:
    title: windows_dfs_folder
    identifier: chef_infra/cookbook_reference/resources/resource_windows_dfs_folder.md
      windows_dfs_folder
    parent: chef_infra/cookbook_reference/resources
    weight: 1110
resource_reference: true
robots: null
resource_description_list:
- markdown: 'The **windows_dfs_folder** resources creates a folder within dfs as

    many levels deep as required.'
resource_new_in: '15.0'
handler_types: false
syntax_description: "The windows_dfs_folder resource has the following syntax:\n\n\
  ``` ruby\nwindows_dfs_folder 'name' do\n  description         String\n  folder_path\
  \         String # default value: 'name' unless specified\n  namespace_name    \
  \  String\n  target_path         String\n  action              Symbol # defaults\
  \ to :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_dfs_folder` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`description`, `folder_path`, `namespace_name`, and `target_path` are the properties
  available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
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
  default_value: null
  new_in: null
  description_list:
  - markdown: Description for the share.
- property: folder_path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the path of the dfs folder if it differs

      from the resource block''s name.'
- property: namespace_name
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The namespace this should be created within.
- property: target_path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The target that this path will connect you to.
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
examples_list: null

---
