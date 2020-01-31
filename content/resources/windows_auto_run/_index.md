---
title: windows_auto_run resource
resource: windows_auto_run
draft: false
aliases: /resource_windows_auto_run.html
menu:
  docs:
    title: windows_auto_run
    identifier: chef_infra/cookbook_reference/resources/resource_windows_auto_run.md
      windows_auto_run
    parent: chef_infra/cookbook_reference/resources
    weight: 1090
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_auto_run** resource to set applications to run at

    login.'
resource_new_in: '14.0'
handler_types: false
syntax_description: 'The windows_auto_run resource has the following syntax:'
syntax_code_block: "windows_auto_run 'name' do\n  args              String\n  path\
  \              String\n  program_name      String # default value: 'name' unless\
  \ specified\n  root              Symbol # default value: :machine\n  action    \
  \        Symbol # defaults to :create if not specified\nend"
syntax_properties_list:
- '`windows_auto_run` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`args`, `path`, `program_name`, and `root` are the properties available to this
  resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
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
  default_value: null
  new_in: null
  description_list:
  - markdown: Any arguments to be used with the program.
- property: path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The path to the program that will run at login.
- property: program_name
  ruby_type: String
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'The name of the program to run at login if it differs from the

      resource block''s name.'
- property: root
  ruby_type: Symbol
  required: false
  default_value: :machine
  new_in: null
  description_list:
  - markdown: The registry root key to put the entry under.
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Run BGInfo at login
  text_blocks:
  - code_block: "windows_auto_run 'BGINFO' do\n  program 'C:/Sysinternals/bginfo.exe'\n\
      \  args    '\\'C:/Sysinternals/Config.bgi\\' /NOLICPROMPT /TIMER:0'\n  action\
      \  :create\nend"

---
