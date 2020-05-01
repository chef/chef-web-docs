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
title: windows_workgroup resource
resource: windows_workgroup
aliases:
- "/resource_windows_workgroup.html"
menu:
  infra:
    title: windows_workgroup
    identifier: chef_infra/cookbook_reference/resources/windows_workgroup windows_workgroup
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **windows_workgroup** resource to join or change the workgroup
    of a Windows host.
resource_new_in: '14.5'
syntax_full_code_block: |-
  windows_workgroup 'name' do
    password            String
    reboot              Symbol # default value: :immediate
    sensitive           true, false # default value: true
    user                String
    workgroup_name      String # default value: 'name' unless specified
    action              Symbol # defaults to :join if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`windows_workgroup` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`password`, `reboot`, `sensitive`, `user`, and `workgroup_name` are the properties
  available to this resource."
actions_list:
  :join:
    markdown: Update the workgroup.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: password
  ruby_type: String
  required: false
  description_list:
  - markdown: The password for the local administrator user. Required if using the
      `user` property.
- property: reboot
  ruby_type: Symbol
  required: false
  default_value: ":immediate"
  allowed_values: ":never, :reboot_now, :request_reboot"
  description_list:
  - markdown: Controls the system reboot behavior post workgroup joining. Reboot immediately,
      after the Chef Infra Client run completes, or never. Note that a reboot is necessary
      for changes to take effect.
- property: user
  ruby_type: String
  required: false
  description_list:
  - markdown: The local administrator user to use to change the workgroup. Required
      if using the `password` property.
- property: workgroup_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to set the workgroup name if it differs from the
      resource block's name.
examples: |
  **Join a workgroup**:

  ``` ruby
  windows_workgroup 'myworkgroup'
  ```

  **Join a workgroup using a specific user**:

  ``` ruby
  windows_workgroup 'myworkgroup' do
    user 'Administrator'
    password 'passw0rd'
  end
  ```
---