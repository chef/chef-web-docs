---
title: rhsm_repo resource
resource: rhsm_repo
draft: false
aliases:
- /resource_rhsm_repo.html
menu:
  docs:
    title: rhsm_repo
    identifier: chef_infra/cookbook_reference/resources/rhsm_repo rhsm_repo
    parent: chef_infra/cookbook_reference/resources
    weight: 880
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **rhsm_repo** resource to enable or disable Red Hat

    Subscription Manager repositories that are made available via attached

    subscriptions.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The rhsm_repo resource has the following syntax:\n\n``` ruby\n\
  rhsm_repo 'name' do\n  repo_name      String # default value: 'name' unless specified\n\
  \  action         Symbol # defaults to :enable if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`rhsm_repo` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`repo_name` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :enable:
    markdown: Default. Enable an RHSM repository.
  :disable:
    markdown: Disable an RHSM repository.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: repo_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property for specifying the repository name if it

      differs from the resource block''s name.'
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
- example_heading: Enable an RHSM repository
  text_blocks:
  - code_block: rhsm_repo 'rhel-7-server-extras-rpms'
- example_heading: Disable an RHSM repository
  text_blocks:
  - code_block: "rhsm_repo 'rhel-7-server-extras-rpms' do\n  action :disable\nend"

---
