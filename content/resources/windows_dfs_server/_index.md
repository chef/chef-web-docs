---
title: windows_dfs_server resource
resource: windows_dfs_server
draft: false
aliases:
- /resource_windows_dfs_server.html
menu:
  infra:
    title: windows_dfs_server
    identifier: chef_infra/cookbook_reference/resources/windows_dfs_server windows_dfs_server
    parent: chef_infra/cookbook_reference/resources
    weight: 1260
resource_reference: true
robots: null
resource_description_list:
- markdown: The **windows_dfs_server** resource sets system-wide DFS settings.
resource_new_in: '15.0'
handler_types: false
syntax_description: "The windows_dfs_server resource has the following syntax:\n\n\
  ``` ruby\nwindows_dfs_server 'name' do\n  enable_site_costed_referrals      true,\
  \ false # default value: false\n  ldap_timeout_secs                 Integer # default\
  \ value: 30\n  prefer_login_dc                   true, false # default value: false\n\
  \  sync_interval_secs                Integer # default value: 3600\n  use_fqdn \
  \                         true, false # default value: false\n  action         \
  \                   Symbol # defaults to :configure if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_dfs_server` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`enable_site_costed_referrals`, `ldap_timeout_secs`, `prefer_login_dc`, `sync_interval_secs`,
  and `use_fqdn` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :configure:
    markdown: Configure DFS settings
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: enable_site_costed_referrals
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list: []
- property: ldap_timeout_secs
  ruby_type: Integer
  required: false
  default_value: '30'
  new_in: null
  description_list: []
- property: prefer_login_dc
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list: []
- property: sync_interval_secs
  ruby_type: Integer
  required: false
  default_value: '3600'
  new_in: null
  description_list: []
- property: use_fqdn
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Indicates whether a DFS namespace server uses FQDNs in referrals. If

      this parameter has a value of true, the server uses FQDNs in

      referrals. If this parameter has a value of false, the server uses

      NetBIOS names.'
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
examples_list: null

---
