---
title: chocolatey_source resource
resource: chocolatey_source
draft: false
aliases:
- /resource_chocolatey_source.html
menu:
  infra:
    title: chocolatey_source
    identifier: chef_infra/cookbook_reference/resources/chocolatey_source chocolatey_source
    parent: chef_infra/cookbook_reference/resources
    weight: 360
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **chocolatey_source** resource to add, remove, enable, or

    disable Chocolatey sources.'
- note:
    markdown: 'The Chocolatey package manager is not installed on Windows by default.

      Install it prior to using this resource by adding the [Chocolatey

      cookbook](https://supermarket.chef.io/cookbooks/chocolatey/) to your

      node''s run list.'
resource_new_in: '14.3'
handler_types: false
syntax_description: "The chocolatey_source resource has the following syntax:\n\n\
  ``` ruby\nchocolatey_source 'name' do\n  admin_only              true, false # default\
  \ value: false\n  allow_self_service      true, false # default value: false\n \
  \ bypass_proxy            true, false # default value: false\n  priority       \
  \         Integer # default value: 0\n  source                  String\n  source_name\
  \             String # default value: 'name' unless specified\n  action        \
  \          Symbol # defaults to :add if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`chocolatey_source` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`admin_only`, `allow_self_service`, `bypass_proxy`, `priority`, `source`, and `source_name`
  are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :add:
    markdown: Default. Adds a Chocolatey source.
  :disable:
    markdown: "Disables a Chocolatey source.\n **New in Chef Infra Client 15.1.**"
  :enable:
    markdown: "Enables a Chocolatey source.\n **New in Chef Infra Client 15.1.**"
  :remove:
    markdown: Removes a Chocolatey source.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: admin_only
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '15.1'
  description_list:
  - markdown: Whether or not to set the source to be accessible to only admins.
- property: allow_self_service
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '15.1'
  description_list:
  - markdown: Whether or not to set the source to be used for self service.
- property: bypass_proxy
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Whether or not to bypass the system''s proxy settings to access the

      source.'
- property: priority
  ruby_type: Integer
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: The priority level of the source.
- property: source
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The source URL.
- property: source_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the source name if it differs from the

      resource block''s name.'
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
- example_heading: Add a Chocolatey source
  text_blocks:
  - code_block: "chocolatey_source 'MySource' do\n  source 'http://example.com/something'\n\
      \  action :add\nend"
- example_heading: Remove a Chocolatey source
  text_blocks:
  - code_block: "chocolatey_source 'MySource' do\n  action :remove\nend"

---
