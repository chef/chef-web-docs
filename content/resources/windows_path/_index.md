---
title: windows_path resource
resource: windows_path
draft: false
aliases:
- /resource_windows_path.html
menu:
  docs:
    title: windows_path
    identifier: chef_infra/cookbook_reference/resources/resource_windows_path.md windows_path
    parent: chef_infra/cookbook_reference/resources
    weight: 1240
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_path** resource to manage the path environment

    variable on Microsoft Windows.'
resource_new_in: '13.4'
handler_types: false
syntax_description: "The windows_path resource has the following syntax:\n\n``` ruby\n\
  windows_path 'name' do\n  path      String # default value: 'name' unless specified\n\
  \  action    Symbol # defaults to :add if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_path` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`path` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :add:
    markdown: Add an item to the system path
  :remove:
    markdown: Remove an item from the system path
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the path value if it differs from the

      resource block''s name.'
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
- example_heading: Add Sysinternals to the system path
  text_blocks:
  - code_block: "windows_path 'C:\\Sysinternals' do\n  action :add\nend"
- example_heading: Remove 7-Zip from the system path
  text_blocks:
  - code_block: "windows_path 'C:\\7-Zip' do\n  action :remove\nend"

---
