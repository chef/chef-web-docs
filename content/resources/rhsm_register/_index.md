---
title: rhsm_register resource
resource: rhsm_register
draft: false
aliases:
- /resource_rhsm_register.html
menu:
  infra:
    title: rhsm_register
    identifier: chef_infra/cookbook_reference/resources/rhsm_register rhsm_register
    parent: chef_infra/cookbook_reference/resources
    weight: 1000
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **rhsm_register** resource to register a node with the Red Hat

    Subscription Manager or a local Red Hat Satellite server.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The rhsm_register resource has the following syntax:\n\n``` ruby\n\
  rhsm_register 'name' do\n  activation_key             String, Array\n  auto_attach\
  \                true, false # default value: false\n  environment             \
  \   String\n  force                      true, false # default value: false\n  install_katello_agent\
  \      true, false # default value: true\n  organization               String\n\
  \  password                   String\n  satellite_host             String\n  username\
  \                   String\n  action                     Symbol # defaults to :register\
  \ if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`rhsm_register` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`activation_key`, `auto_attach`, `environment`, `force`, `install_katello_agent`,
  `organization`, `password`, `satellite_host`, and `username` are the properties
  available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :register:
    markdown: Default. Register the node with RHSM.
  :unregister:
    markdown: Unregister the node from RHSM.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: activation_key
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A string or array of activation keys to use when registering; you

      must also specify the ''organization'' property when using this

      property.'
- property: auto_attach
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'If true, RHSM will attempt to automatically attach the host to

      applicable subscriptions. It is generally better to use an

      activation key with the subscriptions pre-defined.'
- property: environment
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The environment to use when registering; required when using the

      `username` and `password` properties.'
- property: force
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'If true, the system will be registered even if it is already

      registered. Normally, any register operations will fail if the

      machine has already been registered.'
- property: install_katello_agent
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: If true, the `katello-agent` RPM will be installed.
- property: organization
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The organization to use when registering; required when using the

      `activation_key` property.'
- property: password
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The password to use when registering. This property is not

      applicable if using an activation key. If specified, `username` and

      `environment` are also required.'
- property: satellite_host
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The FQDN of the Satellite host to register with. If this property is

      not specified, the host will register with Red Hat''s public RHSM

      service.'
- property: username
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The username to use when registering. This property is not

      applicable if using an activation key. If specified, password and

      environment properties are also required.'
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
- example_heading: Register a node with RHSM
  text_blocks:
  - code_block: "rhsm_register 'myhost' do\n  activation_key 'ABCD1234'\n  organization\
      \ 'my_org'\nend"

---
