---
title: msu_package resource
resource: msu_package
draft: false
aliases:
- /resource_msu_package.html
menu:
  infra:
    title: msu_package
    identifier: chef_infra/cookbook_reference/resources/msu_package msu_package
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **msu_package** resource to install Microsoft Update(MSU)

    packages on Microsoft Windows machines.'
resource_new_in: '12.17'
handler_types: false
syntax_description: "The msu_package resource has the following syntax:\n\n``` ruby\n\
  msu_package 'name' do\n  package_name               String\n  source           \
  \          String\n  action                     Symbol\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`msu_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`source` is the local path or URL for the MSU package.'
syntax_full_code_block: "msu_package 'name' do\n   source                    String\n\
  \   checksum                  String\n   action                    Symbol\nend"
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: checksum
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'SHA-256 digest used to verify the checksum of the downloaded MSU

      package.'
- property: package_name
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An optional property to set the package name if it differs from the

      resource block''s name.'
- property: source
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The local file path or URL for the MSU package.
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
- example_heading: Using local path in source
  text_blocks:
  - code_block: "msu_package 'Install Windows 2012R2 Update KB2959977' do\n  source\
      \ 'C:\\Users\\xyz\\AppData\\Local\\Temp\\Windows8.1-KB2959977-x64.msu'\n  action\
      \ :install\nend"
  - code_block: "msu_package 'Remove Windows 2012R2 Update KB2959977' do\n  source\
      \ 'C:\\Users\\xyz\\AppData\\Local\\Temp\\Windows8.1-KB2959977-x64.msu'\n  action\
      \ :remove\nend"
- example_heading: Using URL in source
  text_blocks:
  - code_block: "msu_package 'Install Windows 2012R2 Update KB2959977' do\n  source\
      \ 'https://s3.amazonaws.com/my_bucket/Windows8.1-KB2959977-x64.msu'\n  action\
      \ :install\nend"
  - code_block: "msu_package 'Remove Windows 2012R2 Update KB2959977' do\n  source\
      \ 'https://s3.amazonaws.com/my_bucket/Windows8.1-KB2959977-x64.msu'\n  action\
      \ :remove\nend"

---
