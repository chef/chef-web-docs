---
title: cron_access resource
resource: cron_access
draft: false
aliases:
- /resource_cron_access.html
menu:
  infra:
    title: cron_access
    identifier: chef_infra/cookbook_reference/resources/cron_access cron_access
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **cron_access** resource to manage the /etc/cron.allow and

    /etc/cron.deny files. Note: This resource previously shipped in the

    `cron` cookbook as `cron_manage`, which it can still be used as for

    backwards compatibility with existing Chef Infra Client releases.'
resource_new_in: '14.4'
handler_types: false
syntax_description: "The cron_access resource has the following syntax:\n\n``` ruby\n\
  cron_access 'name' do\n  user      String # default value: 'name' unless specified\n\
  \  action    Symbol # defaults to :allow if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`cron_access` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`user` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
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
  new_in: null
  description_list:
  - markdown: 'An optional property to set the user name if it differs from the

      resource block''s name.'
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
- example_heading: Add the mike user to cron.allow
  text_blocks:
  - code_block: cron_access 'mike'
- example_heading: Add the mike user to cron.deny
  text_blocks:
  - code_block: "cron_access 'mike' do\n  action :deny\nend"
- example_heading: Specify the username with the user property
  text_blocks:
  - code_block: "cron_access 'Deny the tomcat access to cron for security purposes'\
      \ do\n  user 'jenkins'\n  action :deny\nend"

---
