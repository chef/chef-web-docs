---
title: windows_dfs_namespace resource
resource: windows_dfs_namespace
draft: false
aliases:
- /resource_windows_dfs_namespace.html
menu:
  infra:
    title: windows_dfs_namespace
    identifier: chef_infra/cookbooks/resources/windows_dfs_namespace windows_dfs_namespace
    parent: chef_infra/cookbooks/resources
    weight: 1250
resource_reference: true
robots: null
resource_description_list:
- markdown: Creates a share and DFS namespace on the local server.
resource_new_in: '15.0'
handler_types: false
syntax_description: "The windows_dfs_namespace resource has the following syntax:\n\
  \n``` ruby\nwindows_dfs_namespace 'name' do\n  change_users        Array # default\
  \ value: []\n  description         String\n  full_users          Array # default\
  \ value: [\"BUILTIN\\\\administrators\"]\n  namespace_name      String # default\
  \ value: 'name' unless specified\n  read_users          Array # default value: []\n\
  \  root                String # default value: \"C:\\\\DFSRoots\"\n  action    \
  \          Symbol # defaults to :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_dfs_namespace` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`change_users`, `description`, `full_users`, `namespace_name`, `read_users`, and
  `root` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :delete:
    markdown: Deletes a DFS Namespace including the directory on disk.
  :create:
    markdown: Creates the dfs namespace on the server. Default.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: change_users
  ruby_type: Array
  required: false
  default_value: '[]'
  new_in: null
  description_list:
  - markdown: Determines which users should have change access to the share.
- property: description
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: Description of the share.
- property: full_users
  ruby_type: Array
  required: false
  default_value: '["BUILTIN\\administrators"]'
  new_in: null
  description_list:
  - markdown: Determines which users should have full access to the share.
- property: namespace_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the dfs namespace if it differs from the

      resource block''s name.'
- property: read_users
  ruby_type: Array
  required: false
  default_value: '[]'
  new_in: null
  description_list:
  - markdown: Determines which users should have read access to the share.
- property: root
  ruby_type: String
  required: false
  default_value: '"C:\\DFSRoots"'
  new_in: null
  description_list:
  - markdown: The root from which to create the DFS tree. Defaults to C:DFSRoots.
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
