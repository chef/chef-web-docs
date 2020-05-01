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
title: windows_ad_join resource
resource: windows_ad_join
aliases:
- "/resource_windows_ad_join.html"
menu:
  infra:
    title: windows_ad_join
    identifier: chef_infra/cookbook_reference/resources/windows_ad_join windows_ad_join
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **windows_ad_join** resource to join a Windows Active Directory
    domain.
resource_new_in: '14.0'
syntax_full_code_block: |-
  windows_ad_join 'name' do
    domain_name          String # default value: 'name' unless specified
    domain_password      String
    domain_user          String
    new_hostname         String
    ou_path              String
    reboot               Symbol # default value: :immediate
    sensitive            true, false # default value: true
    workgroup_name       String
    action               Symbol # defaults to :join if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`windows_ad_join` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`domain_name`, `domain_password`, `domain_user`, `new_hostname`, `ou_path`, `reboot`,
  `sensitive`, and `workgroup_name` are the properties available to this resource."
actions_list:
  :join:
    markdown: Default. Join the Active Directory domain.
  :leave:
    markdown: Leave an Active Directory domain and re-join a workgroup.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: domain_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to set the FQDN of the Active Directory domain
      to join if it differs from the resource block's name.
- property: domain_password
  ruby_type: String
  required: true
  description_list:
  - markdown: 'The password for the domain user. Note that this resource is set to
      hide sensitive information by default. '
- property: domain_user
  ruby_type: String
  required: true
  description_list:
  - markdown: The domain user that will be used to join the domain.
- property: new_hostname
  ruby_type: String
  required: false
  new_in: '14.5'
  description_list:
  - markdown: Specifies a new hostname for the computer in the new domain.
- property: ou_path
  ruby_type: String
  required: false
  description_list:
  - markdown: The path to the Organizational Unit where the host will be placed.
- property: reboot
  ruby_type: Symbol
  required: false
  default_value: ":immediate"
  allowed_values: ":delayed, :immediate, :never, :reboot_now, :request_reboot"
  description_list:
  - markdown: Controls the system reboot behavior post domain joining. Reboot immediately,
      after the Chef Infra Client run completes, or never. Note that a reboot is necessary
      for changes to take effect.
- property: sensitive
  ruby_type: true, false
  required: false
  default_value: 'true'
  description_list:
  - markdown: 
- property: workgroup_name
  ruby_type: String
  required: false
  new_in: '15.4'
  description_list:
  - markdown: Specifies the name of a workgroup to which the computer is added to
      when it is removed from the domain. The default value is WORKGROUP. This property
      is only applicable to the :leave action.
examples: "
  Join a domain\n\n  ``` ruby\n  windows_ad_join 'ad.example.org' do\n\
  \    domain_user 'nick'\n    domain_password 'p@ssw0rd1'\n  end\n  ```\n\n  **Join\
  \ a domain, as \\`win-workstation\\`**\n\n  ``` ruby\n  windows_ad_join 'ad.example.org'\
  \ do\n    domain_user 'nick'\n    domain_password 'p@ssw0rd1'\n    new_hostname\
  \ 'win-workstation'\n  end\n  ```\n\n  **Leave the current domain and re-join the\
  \ \\`local\\` workgroup**\n\n  ``` ruby\n  windows_ad_join 'Leave domain' do\n \
  \   action :leave\n    workgroup 'local'\n  end\n  ```\n"

---
