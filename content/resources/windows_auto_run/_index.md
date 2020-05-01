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
title: windows_auto_run resource
resource: windows_auto_run
aliases:
- "/resource_windows_auto_run.html"
menu:
  infra:
    title: windows_auto_run
    identifier: chef_infra/cookbook_reference/resources/windows_auto_run windows_auto_run
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **windows_auto_run** resource to set applications to run at login.
resource_new_in: '14.0'
syntax_full_code_block: |-
  windows_auto_run 'name' do
    args              String
    path              String
    program_name      String # default value: 'name' unless specified
    root              Symbol # default value: :machine
    action            Symbol # defaults to :create if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`windows_auto_run` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`args`, `path`, `program_name`, and `root` are the properties available to this
  resource."
actions_list:
  :create:
    markdown: Create an item to be run at login.
  :remove:
    markdown: Remover an item that was previously configured to run at login.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: args
  ruby_type: String
  required: false
  description_list:
  - markdown: Any arguments to be used with the program.
- property: path
  ruby_type: String
  required: false
  description_list:
  - markdown: The path to the program that will run at login.
- property: program_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: The name of the program to run at login if it differs from the resource
      block's name.
- property: root
  ruby_type: Symbol
  required: false
  default_value: ":machine"
  allowed_values: ":machine, :user"
  description_list:
  - markdown: The registry root key to put the entry under.
examples: "
  Run BGInfo at login\n\n  ``` ruby\n  windows_auto_run 'BGINFO' do\n\
  \    program 'C:/Sysinternals/bginfo.exe'\n    args    '\\'C:/Sysinternals/Config.bgi\\\
  ' /NOLICPROMPT /TIMER:0'\n    action  :create\n  end\n  ```\n"

---
