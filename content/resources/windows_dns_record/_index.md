---
title: windows_dns_record resource
resource: windows_dns_record
draft: false
aliases: /resource_windows_dns_record.html
menu:
  docs:
    title: windows_dns_record
    identifier: chef_infra/cookbook_reference/resources/resource_windows_dns_record.md
      windows_dns_record
    parent: chef_infra/cookbook_reference/resources
    weight: 1140
resource_reference: true
robots: null
resource_description_list:
- markdown: 'The **windows_dns_record** resource creates a DNS record for the given

    domain.'
resource_new_in: '15.0'
handler_types: false
syntax_description: 'The windows_dns_record resource has the following syntax:'
syntax_code_block: "windows_dns_record 'name' do\n  record_name      String # default\
  \ value: 'name' unless specified\n  record_type      String # default value: \"\
  ARecord\"\n  target           String\n  zone             String\n  action      \
  \     Symbol # defaults to :create if not specified\nend"
syntax_properties_list:
- '`windows_dns_record` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`record_name`, `record_type`, `target`, and `zone` are the properties available
  to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Creates and updates the DNS entry.
  :delete:
    markdown: Deletes a DNS entry.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: record_name
  ruby_type: String
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the dns record name if it differs from

      the resource block''s name.'
- property: record_type
  ruby_type: String
  required: false
  default_value: '"ARecord"'
  new_in: null
  description_list:
  - markdown: The type of record to create, can be either ARecord, CNAME or PTR.
- property: target
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The target for the record.
- property: zone
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The zone to create the record in.
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list: null

---
