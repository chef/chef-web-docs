---
title: windows_shortcut resource
resource: windows_shortcut
draft: false
aliases:
- /resource_windows_shortcut.html
menu:
  docs:
    title: windows_shortcut
    identifier: chef_infra/cookbook_reference/resources/windows_shortcut windows_shortcut
    parent: chef_infra/cookbook_reference/resources
    weight: 1420
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_shortcut** resource to create shortcut files on

    Windows.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The windows_shortcut resource has the following syntax:\n\n```\
  \ ruby\nwindows_shortcut 'name' do\n  arguments          String\n  cwd         \
  \       String\n  description        String\n  iconlocation       String\n  shortcut_name\
  \      String # default value: 'name' unless specified\n  target             String\n\
  \  action             Symbol # defaults to :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_shortcut` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`arguments`, `cwd`, `description`, `iconlocation`, `shortcut_name`, and `target`
  are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create or modify a Windows shortcut.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: arguments
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Arguments to pass to the target when the shortcut is executed.
- property: cwd
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Working directory to use when the target is executed.
- property: description
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The description of the shortcut
- property: iconlocation
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Icon to use for the shortcut. Accepts the format of `''path, index''`,

      where index is the icon file to use. See Microsoft''s

      [documentation](https://msdn.microsoft.com/en-us/library/3s9bx7at.aspx)

      for details.'
- property: shortcut_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the shortcut name if it differs from the

      resource block''s name.'
- property: target
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The destination that the shortcut links to.
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
- example_heading: Create a shortcut with a description
  text_blocks:
  - code_block: "windows_shortcut 'C:\\shortcut_dir.lnk' do\n  target 'C:\\original_dir'\n\
      \  description 'Make a shortcut to C:\\original_dir'\nend"

---
