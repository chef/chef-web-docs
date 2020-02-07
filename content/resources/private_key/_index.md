---
title: private_key resource
resource: private_key
draft: false
aliases: /resource_private_key.html
resource_reference: false
robots: noindex, nofollow
resource_description_list:
- warning:
    shortcode: EOL_provisioning.md
- markdown: 'Use the **private_key** resource to create, delete, and regenerate

    private keys, including RSA, DSA, and .pem file keys.'
resource_new_in: null
handler_types: false
syntax_description: 'The syntax for using the **private_key** resource in a recipe
  is as follows:'
syntax_code_block: "private_key 'name' do\n  attribute 'value' # see properties section\
  \ below\n  ...\n  action :action # see actions section below\nend"
syntax_properties_list:
- '`private_key` tells Chef Infra Client to use the `Chef::Provider::PrivateKey` provider
  during a Chef Infra Client run'
- '`name` is the name of the resource block; when the `path` property is not specified
  as part of a recipe, `name` is also the name of the private key'
- '`attribute` is zero (or more) of the properties that are available for this resource'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Use to create an RSA private key.
  :delete:
    markdown: Use to delete an RSA private key.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :regenerate:
    markdown: Use to regenerate an RSA private key.
properties_list:
- property: cipher
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the cipher for a .pem file. Default value:

      `DES-EDE3-CBC`.'
- property: exponent
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the exponent for an RSA private key. This is always

      an odd integer value, often a prime Fermat number, and typically

      `5`, `17`, `257`, or `65537`.'
- property: format
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the format of a private key. Possible values: `pem`

      and `der`. Default value: `pem`.'
- property: ignore_failure
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Continue running a recipe if a resource fails for any reason.
- property: notifies
  ruby_type: Symbol, Chef::Resource\[String\]
  required: false
  default_value: null
  new_in: null
  description_list:
  - shortcode: resources_common_notification_notifies.md
  - markdown: ''
  - shortcode: resources_common_notification_timers.md
  - markdown: ''
  - shortcode: resources_common_notification_notifies_syntax.md
- property: pass_phrase
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify the pass phrase for a .pem file.
- property: path
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the path to a private key. Set to `none` to create a

      private key in-memory and not on-disk. Default value: the `name` of

      the resource block. See "Syntax" section above for more information.'
- property: public_key_format
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the format of a public key. Possible values: `der`,

      `openssh`, and `pem`. Default value: `openssh`.'
- property: public_key_path
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The path to a public key.
- property: regenerate_if_different
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to regenerate a private key if it does not have the desired

      size, type, and so on. Default value: `false`.'
- property: retries
  ruby_type: Integer
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: The number of attempts to catch exceptions and retry the resource.
- property: retry_delay
  ruby_type: Integer
  required: false
  default_value: '2'
  new_in: null
  description_list:
  - markdown: The retry delay (in seconds).
- property: size
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the size of an RSA or DSA private key. Default value:

      `2048`.'
- property: source_key
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to copy a private key, but apply a different `format` and

      `password`. Use in conjunction with `source_key_pass_phrase` and

      `source_key_path`.'
- property: source_key_pass_phrase
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The pass phrase for the private key. Use in conjunction with

      `source_key` and `source_key_path`.'
- property: source_key_path
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The path to the private key. Use in conjunction with `source_key`

      and `source_key_pass_phrase`.'
- property: subscribes
  ruby_type: Symbol, Chef::Resource\[String\]
  required: false
  default_value: null
  new_in: null
  description_list:
  - shortcode: resources_common_notification_subscribes.md
  - markdown: ''
  - shortcode: resources_common_notification_timers.md
  - markdown: ''
  - shortcode: resources_common_notification_subscribes_syntax.md
- property: type
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the type of private key. Possible values: `dsa` and

      `rsa`. Default value: `rsa`.'
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
resources_common_properties: false
resources_common_notification: false
resources_common_guards: false
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
