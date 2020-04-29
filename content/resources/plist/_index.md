---
draft: false
resource_reference: true
robots:
syntax_code_block:
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
title: plist resource
resource: plist
aliases:
- "/resource_plist.html"
menu:
  infra:
    title: plist
    identifier: chef_infra/cookbook_reference/resources/plist plist
    parent: chef_infra/cookbook_reference/resources

resource_description_list:
- markdown: Use the plist resource to set config values in plist files on macOS systems.
resource_new_in: '16.0'
syntax_full_code_block: |-
  plist 'name' do
    encoding      String # default value: "binary"
    entry         String
    group         String # default value: "wheel"
    mode          String, Integer
    owner         String # default value: "root"
    path          String # default value: 'name' unless specified
    value         true, false, String, Integer, Float, Hash
    action        Symbol # defaults to :set if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`plist` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "``encoding``, ``entry``, ``group``, ``mode``, ``owner``, ``path``, and ``value``
  are the properties available to this resource."
properties_list:
- property: encoding
  ruby_type: String
  required: false
  default_value: binary
  new_in:
  description_list:
  - markdown:
- property: entry
  ruby_type: String
  required: false
  default_value:
  new_in:
  description_list:
  - markdown:
- property: group
  ruby_type: String
  required: false
  default_value: wheel
  new_in:
  description_list:
  - markdown:
- property: mode
  ruby_type: String, Integer
  required: false
  default_value:
  new_in:
  description_list:
  - markdown:
- property: owner
  ruby_type: String
  required: false
  default_value: root
  new_in:
  description_list:
  - markdown:
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in:
  description_list:
  - markdown:
- property: value
  ruby_type: true, false, String, Integer, Float, Hash
  required: false
  default_value:
  new_in:
  description_list:
  - markdown:

---