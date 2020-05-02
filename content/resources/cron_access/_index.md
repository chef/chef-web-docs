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
template_requirements: false
unit_file_verification: false
title: cron_access resource
resource: cron_access
aliases:
- "/resource_cron_access.html"
menu:
  infra:
    title: cron_access
    identifier: chef_infra/cookbook_reference/resources/cron_access cron_access
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: 'Use the **cron_access** resource to manage the /etc/cron.allow and

    /etc/cron.deny files. Note: This resource previously shipped in the

    `cron` cookbook as `cron_manage`, which it can still be used as for

    backwards compatibility with existing Chef Infra Client releases.'
resource_new_in: '14.4'
syntax_full_code_block: |-
  cron_access 'name' do
    user      String # default value: 'name' unless specified
    action    Symbol # defaults to :allow if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`cron_access` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`user` is the property available to this resource."
actions_list:
  :allow:
    markdown: Default. Add the user to the cron.allow file.
  :deny:
    markdown: Add the user to the cron.deny file.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: user
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to set the user name if it differs from the resource
      block's name.
examples: |
  **Add the mike user to cron.allow**

  ```ruby
  cron_access 'mike'
  ```

  **Add the mike user to cron.deny**

  ```ruby
  cron_access 'mike' do
    action :deny
  end
  ```

  **Specify the username with the user property**

  ```ruby
  cron_access 'Deny the jenkins user access to cron for security purposes' do
    user 'jenkins'
    action :deny
  end
  ```
---

