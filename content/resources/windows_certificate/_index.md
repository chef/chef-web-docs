---
title: windows_certificate resource
resource: windows_certificate
draft: false
aliases:
- /resource_windows_certificate.html
menu:
  infra:
    title: windows_certificate
    identifier: chef_infra/cookbooks/resources/windows_certificate windows_certificate
    parent: chef_infra/cookbooks/resources
    weight: 1230
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_certificate** resource to install a certificate into

    the Windows certificate store from a file. The resource grants read-only

    access to the private key for designated accounts. Due to current

    limitations in WinRM, installing certificates remotely may not work if

    the operation requires a user profile. Operations on the local machine

    store should still work.'
resource_new_in: '14.7'
handler_types: false
syntax_description: "The windows_certificate resource has the following syntax:\n\n\
  ``` ruby\nwindows_certificate 'name' do\n  cert_path            String\n  pfx_password\
  \         String\n  private_key_acl      Array\n  source               String #\
  \ default value: 'name' unless specified\n  store_name           String # default\
  \ value: \"MY\"\n  user_store           true, false # default value: false\n  action\
  \               Symbol # defaults to :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_certificate` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`cert_path`, `pfx_password`, `private_key_acl`, `source`, `store_name`, and `user_store`
  are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :acl_add:
    markdown: Adds read-only entries to a certificate's private key ACL.
  :create:
    markdown: Creates or updates a certificate.
  :delete:
    markdown: Deletes a certificate.
  :fetch:
    markdown: Fetches a certificate.
  :verify:
    markdown: Verifies a certificate.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: cert_path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list: []
- property: pfx_password
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The password to access the source if it is a pfx file.
- property: private_key_acl
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An array of ''domainaccount'' entries to be granted read-only access

      to the certificate''s private key. Not idempotent.'
- property: source
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The source file (for create and acl_add), thumbprint (for delete

      and acl_add) or subject (for delete) if it differs from the

      resource block''s name.'
- property: store_name
  ruby_type: String
  required: false
  default_value: '"MY"'
  new_in: null
  description_list:
  - markdown: The certificate store to manipulate.
- property: user_store
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Use the user store of the local machine store if set to false.
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
- example_heading: 'Add PFX cert to local machine personal store and grant accounts

    read-only access to private key'
  text_blocks:
  - code_block: "windows_certificate 'c:/test/mycert.pfx' do\n  pfx_password 'password'\n\
      \  private_key_acl [\"acme\\fred\", \"pc\\jane\"]\nend"
- example_heading: Add cert to trusted intermediate store
  text_blocks:
  - code_block: "windows_certificate 'c:/test/mycert.cer' do\n  store_name 'CA'\n\
      end"
- example_heading: Remove all certificates matching the subject
  text_blocks:
  - code_block: "windows_certificate 'me.acme.com' do\n  action :delete\nend"

---
