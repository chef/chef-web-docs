---
title: rhsm_errata_level resource
resource: rhsm_errata_level
draft: false
aliases:
- /resource_rhsm_errata_level.html
menu:
  infra:
    title: rhsm_errata_level
    identifier: chef_infra/cookbook_reference/resources/rhsm_errata_level rhsm_errata_level
    parent: chef_infra/cookbook_reference/resources
    weight: 980
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **rhsm_errata_level** resource to install all packages of a

    specified errata level from the Red Hat Subscription Manager. For

    example, you can ensure that all packages associated with errata marked

    at a ''Critical'' security level are installed.


    The available errata levels are: `critical`, `moderate`, `important`,

    and `low`.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The rhsm_errata_level resource has the following syntax:\n\n\
  ``` ruby\nrhsm_errata_level 'name' do\n  errata_level      String # default value:\
  \ 'name' unless specified\n  action            Symbol # defaults to :install if\
  \ not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`rhsm_errata_level` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`errata_level` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Install all packages of the specified errata level.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: errata_level
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property for specifying the errata level of packages to

      install if it differs from the resource block''s name.'
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
- example_heading: Specify an errata level that differs from the resource name
  text_blocks:
  - code_block: "rhsm_errata_level 'example_install_moderate' do\n  errata_level 'moderate'\n\
      end"

---
