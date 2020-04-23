---
title: windows_share resource
resource: windows_share
draft: false
aliases:
- /resource_windows_share.html
menu:
  infra:
    title: windows_share
    identifier: chef_infra/cookbooks/resources/windows_share windows_share
    parent: chef_infra/cookbooks/resources
    weight: 1410
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_share** resource to create, modify and remove Windows

    shares.'
resource_new_in: '14.7'
handler_types: false
syntax_description: "The windows_share resource has the following syntax:\n\n``` ruby\n\
  windows_share 'name' do\n  ca_timeout                  Integer # default value:\
  \ 0\n  change_users                Array\n  concurrent_user_limit       Integer\
  \ # default value: 0\n  continuously_available      true, false # default value:\
  \ false\n  description                 String\n  encrypt_data                true,\
  \ false # default value: false\n  full_users                  Array\n  path    \
  \                    String\n  read_users                  Array\n  scope_name \
  \                 String # default value: \"*\"\n  share_name                  String\
  \ # default value: 'name' unless specified\n  temporary                   true,\
  \ false # default value: false\n  action                      Symbol # defaults\
  \ to :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_share` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`ca_timeout`, `change_users`, `concurrent_user_limit`, `continuously_available`,
  `description`, `encrypt_data`, `full_users`, `path`, `read_users`, `scope_name`,
  `share_name`, and `temporary` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Create and modify Windows shares.
  :delete:
    markdown: Delete an existing Windows share.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: ca_timeout
  ruby_type: Integer
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: The continuous availability time-out for the share.
- property: change_users
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The users that should have ''modify'' permission on the share in

      domainusername format.'
- property: concurrent_user_limit
  ruby_type: Integer
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: 'The maximum number of concurrently connected users the share can

      accommodate.'
- property: continuously_available
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Indicates that the share is continuously available.
- property: description
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The description to be applied to the share.
- property: encrypt_data
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Indicates that the share is encrypted.
- property: full_users
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The users that should have ''Full control'' permissions on the share

      in domainusername format.'
- property: path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The path of the folder to share. Required when creating. If the

      share already exists on a different path then it is deleted and

      re-created.'
- property: read_users
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The users that should have ''read'' permission on the share in

      domainusername format.'
- property: scope_name
  ruby_type: String
  required: false
  default_value: '"*"'
  new_in: null
  description_list:
  - markdown: The scope name of the share.
- property: share_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the share name if it differs from the

      resource block''s name.'
- property: temporary
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'The lifetime of the new SMB share. A temporary share does not

      persist beyond the next restart of the computer.'
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
- example_heading: Create a share
  text_blocks:
  - code_block: "windows_share 'foo' do\n  action :create\n  path 'C:\\\\foo'\n  full_users\
      \ ['DOMAIN_A\\\\some_user', 'DOMAIN_B\\\\some_other_user']\n  read_users ['DOMAIN_C\\\
      \\Domain users']\nend"
- example_heading: Delete a share
  text_blocks:
  - code_block: "windows_share 'foo' do\n  action :delete\nend"

---
