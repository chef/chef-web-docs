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
title: windows_security_policy resource
resource: windows_security_policy
aliases:
- "/resource_windows_security_policy.html"
menu:
  infra:
    title: windows_security_policy
    identifier: chef_infra/cookbook_reference/resources/windows_security_policy windows_security_policy
    parent: chef_infra/cookbook_reference/resources

resource_description_list:
- markdown: Use the windows_security_policy resource to set a security policy on the
    Microsoft Windows platform.
resource_new_in: '16.0'
syntax_full_code_block: |-
  windows_security_policy 'name' do
    secoption      String # default value: 'name' unless specified
    secvalue       String
    action         Symbol # defaults to :set if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`windows_security_policy` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "``secoption`` and ``secvalue`` are the properties available to this resource."
properties_list:
- property: secoption
  ruby_type: String
  required: true
  default_value: The resource block's name
  new_in:
  description_list:
  - markdown: The name of the policy to be set on windows platform to maintain its
      security.
- property: secvalue
  ruby_type: String
  required: true
  default_value:
  new_in:
  description_list:
  - markdown: Policy value to be set for policy name.

---
