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
title: windows_dfs_server resource
resource: windows_dfs_server
aliases:
- "/resource_windows_dfs_server.html"
menu:
  infra:
    title: windows_dfs_server
    identifier: chef_infra/cookbook_reference/resources/windows_dfs_server windows_dfs_server
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **windows_dfs_server** resource to set system-wide DFS settings.
resource_new_in: '15.0'
syntax_full_code_block: |-
  windows_dfs_server 'name' do
    enable_site_costed_referrals      true, false # default value: false
    ldap_timeout_secs                 Integer # default value: 30
    prefer_login_dc                   true, false # default value: false
    sync_interval_secs                Integer # default value: 3600
    use_fqdn                          true, false # default value: false
    action                            Symbol # defaults to :configure if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`windows_dfs_server` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`enable_site_costed_referrals`, `ldap_timeout_secs`, `prefer_login_dc`, `sync_interval_secs`,
  and `use_fqdn` are the properties available to this resource."
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
  description_list: []
- property: ldap_timeout_secs
  ruby_type: Integer
  required: false
  default_value: '30'
  description_list: []
- property: prefer_login_dc
  ruby_type: true, false
  required: false
  default_value: 'false'
  description_list: []
- property: sync_interval_secs
  ruby_type: Integer
  required: false
  default_value: '3600'
  description_list: []
- property: use_fqdn
  ruby_type: true, false
  required: false
  default_value: 'false'
  description_list:
  - markdown: 'Indicates whether a DFS namespace server uses FQDNs in referrals. If

      this parameter has a value of true, the server uses FQDNs in

      referrals. If this parameter has a value of false, the server uses

      NetBIOS names.'

---
