---
title: rhsm_subscription resource
resource: rhsm_subscription
draft: false
aliases:
- /resource_rhsm_subscription.html
menu:
  infra:
    title: rhsm_subscription
    identifier: chef_infra/cookbooks/resources/rhsm_subscription rhsm_subscription
    parent: chef_infra/cookbooks/resources
    weight: 1020
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **rhsm_subscription** resource to add or remove Red Hat

    Subscription Manager subscriptions from your host. This can be used when

    a host''s activation_key does not attach all necessary subscriptions to

    your host.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The rhsm_subscription resource has the following syntax:\n\n\
  ``` ruby\nrhsm_subscription 'name' do\n  pool_id      String # default value: 'name'\
  \ unless specified\n  action       Symbol # defaults to :attach if not specified\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`rhsm_subscription` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`pool_id` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :attach:
    markdown: Default. Attach the node to a subscription pool.
  :remove:
    markdown: Remove the node from a subscription pool.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: pool_id
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property for specifying the Pool ID if it differs from

      the resource block''s name.'
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
