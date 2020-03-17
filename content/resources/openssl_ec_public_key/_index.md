---
title: openssl_ec_public_key resource
resource: openssl_ec_public_key
draft: false
aliases:
- /resource_openssl_ec_public_key.html
menu:
  infra:
    title: openssl_ec_public_key
    identifier: chef_infra/cookbook_reference/resources/openssl_ec_public_key openssl_ec_public_key
    parent: chef_infra/cookbook_reference/resources
    weight: 770
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **openssl_ec_public_key** resource to generate elliptic curve

    (EC) public key files from a given EC private key.'
resource_new_in: '14.4'
handler_types: false
syntax_description: "The openssl_ec_public_key resource has the following syntax:\n\
  \n``` ruby\nopenssl_ec_public_key 'name' do\n  group                    String,\
  \ Integer\n  mode                     Integer, String # default value: \"0640\"\n\
  \  owner                    String, Integer\n  path                     String #\
  \ default value: 'name' unless specified\n  private_key_content      String\n  private_key_pass\
  \         String\n  private_key_path         String\n  action                  \
  \ Symbol # defaults to :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`openssl_ec_public_key` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`group`, `mode`, `owner`, `path`, `private_key_content`, `private_key_pass`, and
  `private_key_path` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Generate the EC public key from a private key.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: group
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The group ownership applied to all files created by the resource.
- property: mode
  ruby_type: Integer, String
  required: false
  default_value: '"0640"'
  new_in: null
  description_list:
  - markdown: The permission mode applied to all files created by the resource.
- property: owner
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The owner applied to all files created by the resource.
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property for specifying the path to write the file to if

      it differs from the resource block''s name.'
- property: private_key_content
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The content of the private key, including new lines. This property

      is used in place of `private_key_path` in instances where you want

      to avoid having to first write the private key to disk.'
- property: private_key_pass
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The passphrase of the provided private key.
- property: private_key_path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The path to the private key file.
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
- example_heading: Create a public key from a private key file
  text_blocks:
  - code_block: "openssl_ec_public_key '/etc/example/key.pub' do\n  private_key_path\
      \ '/etc/example/key.pem'\nend"
- example_heading: 'Create a public key from a private key, without writing the private

    key to disk'
  text_blocks:
  - markdown: 'You can provide the private key content as a string to the

      openssl_ec_public_key resource. In this example we just pass a

      string, but this content could be loaded from an encrypted data bag or

      other secure storage.'
  - code_block: "openssl_ec_public_key '/etc/example/key.pub' do\n  private_key_content\
      \ 'KEY_CONTENT_HERE_AS_A_STRING'\nend"

---
