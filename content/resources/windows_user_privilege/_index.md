---
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
title: windows_user_privilege resource
resource: windows_user_privilege
aliases:
- "/resource_windows_user_privilege.html"
menu:
  infra:
    title: windows_user_privilege
    identifier: chef_infra/cookbook_reference/resources/windows_user_privilege windows_user_privilege
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: "The windows_user_privilege resource allows to add and set principal (User/Group)
    to the specified privilege. \n Ref: https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/user-rights-assignment"
resource_new_in: '16.0'
syntax_full_code_block: |-
  windows_user_privilege 'name' do
    principal      String # default value: 'name' unless specified
    privilege      Array, String
    users          Array
    action         Symbol # defaults to :add if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`windows_user_privilege` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "``principal``, ``privilege``, and ``users`` are the properties available to this
  resource."
properties_list:
- property: principal
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in:
  description_list:
  - markdown: An optional property to add the user to the given privilege. Use only
      with add and remove action.
- property: privilege
  ruby_type: Array, String
  required: true
  default_value:
  new_in:
  description_list:
  - markdown: Privilege to set for users.
- property: users
  ruby_type: Array
  required: false
  default_value:
  new_in:
  description_list:
  - markdown: An optional property to set the privilege for given users. Use only
      with set action.

---