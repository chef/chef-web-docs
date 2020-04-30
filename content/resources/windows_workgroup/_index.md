---
title: windows_workgroup resource
resource: windows_workgroup
aliases:
- "/resource_windows_workgroup.html"
menu:
  infra:
    title: windows_workgroup
    identifier: chef_infra/cookbook_reference/resources/windows_workgroup windows_workgroup
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_workgroup** resource to join or change the workgroup

    of a Windows host.'
resource_new_in: '14.5'
handler_types: false
syntax_description: "The windows_workgroup resource has the following syntax:\n\n\
  ``` ruby\nwindows_workgroup 'name' do\n  password            String\n  reboot  \
  \            Symbol # default value: :immediate\n  sensitive           true, false\
  \ # default value: true\n  user                String\n  workgroup_name      String\
  \ # default value: 'name' unless specified\n  action              Symbol # defaults\
  \ to :join if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_workgroup` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`password`, `reboot`, `sensitive`, `user`, and `workgroup_name` are the properties
  available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :join:
    markdown: Update the workgroup.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: password
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The password for the local administrator user. Required if using the
      `user` property.
- property: reboot
  ruby_type: Symbol
  required: false
  default_value: ":immediate"
  new_in: 
  description_list:
  - markdown: Controls the system reboot behavior post workgroup joining. Reboot immediately,
      after the Chef Infra Client run completes, or never. Note that a reboot is necessary
      for changes to take effect.
- property: user
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The local administrator user to use to change the workgroup. Required
      if using the `password` property.
- property: workgroup_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: 
  description_list:
  - markdown: An optional property to set the workgroup name if it differs from the
      resource block's name.
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
examples: "
  Join a workgroup\n\n  ``` ruby\n  windows_workgroup 'myworkgroup'\n\
  \  ```\n\n  Join a workgroup using a specific user\n\n  ``` ruby\n  windows_workgroup\
  \ 'myworkgroup' do\n    user 'Administrator'\n    password 'passw0rd'\n  end\n \
  \ ```\n"

---
