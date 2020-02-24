---
title: macos_userdefaults resource
resource: macos_userdefaults
draft: false
aliases:
- /resource_macos_userdefaults.html
menu:
  docs:
    title: macos_userdefaults
    identifier: chef_infra/cookbook_reference/resources/macos_userdefaults macos_userdefaults
    parent: chef_infra/cookbook_reference/resources
    weight: 540
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **macos_userdefaults** resource to manage the macOS [user

    defaults](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/UserDefaults/AboutPreferenceDomains/AboutPreferenceDomains.html#//apple_ref/doc/uid/10000059i-CH2-SW6)

    system. The properties of the resource are passed to the `defaults`

    command, and the parameters follow the conventions of that command. See

    the `defaults` man page for additional information.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The macos_userdefaults resource has the following syntax:\n\n\
  ``` ruby\nmacos_userdefaults 'name' do\n  domain      String\n  global      true,\
  \ false # default value: false\n  key         String\n  sudo        true, false\
  \ # default value: false\n  type        String\n  user        String\n  value  \
  \     Integer, Float, String, true, false, Hash, Array\n  action      Symbol # defaults\
  \ to :write if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`macos_userdefaults` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`domain`, `global`, `key`, `sudo`, `type`, `user`, and `value` are the properties
  available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :write:
    markdown: Default. Writes the setting to the specified domain.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: domain
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The domain that the user defaults belong to.
- property: global
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Determines whether or not the domain is

      [global](https://developer.apple.com/documentation/foundation/nsglobaldomain).'
- property: key
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The preference key.
- property: sudo
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Set to `true` if the setting you wish to modify requires privileged

      access.'
- property: type
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The value type of the preference key.
- property: user
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The system user that the default will be applied to.
- property: value
  ruby_type: Integer, Float, String, true, false, Hash, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The value of the key.
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
- example_heading: Specify a global domain
  text_blocks:
  - code_block: "macos_userdefaults 'full keyboard access to all controls' do\n  domain\
      \ 'AppleKeyboardUIMode'\n  global true\n  value '2'\nend"
- example_heading: Use an integer value
  text_blocks:
  - code_block: "macos_userdefaults 'enable macOS firewall' do\n  domain '/Library/Preferences/com.apple.alf'\n\
      \  key 'globalstate'\n  value '1'\n  type 'int'\nend"
- example_heading: Use a boolean value
  text_blocks:
  - code_block: "macos_userdefaults 'finder expanded save dialogs' do\n  domain 'NSNavPanelExpandedStateForSaveMode'\n\
      \  global true\n  value 'TRUE'\n  type 'bool'\nend"

---
