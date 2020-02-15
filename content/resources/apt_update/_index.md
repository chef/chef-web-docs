---
title: apt_update resource
resource: apt_update
draft: false
aliases:
- /resource_apt_update.html
menu:
  docs:
    title: apt_update
    identifier: chef_infra/cookbook_reference/resources/resource_apt_update.md apt_update
    parent: chef_infra/cookbook_reference/resources
    weight: 90
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **apt_update** resource to manage APT repository updates on

    Debian and Ubuntu platforms.'
resource_new_in: null
handler_types: false
syntax_description: "The apt_update resource has the following syntax:\n\n``` ruby\n\
  apt_update 'name' do\n  frequency      Integer # default value: 86400\n  action\
  \         Symbol # defaults to :periodic if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`apt_update` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`frequency` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: true
nameless_build_essential: false
resource_package_options: false
actions_list:
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :periodic:
    markdown: Update the Apt repository at the interval specified by the `frequency`
      property.
  :update:
    markdown: Update the Apt repository at the start of a Chef Infra Client run.
properties_list:
- property: frequency
  ruby_type: Integer
  required: false
  default_value: '86400'
  new_in: null
  description_list:
  - markdown: 'Determines how frequently (in seconds) APT repository updates are

      made. Use this property when the `:periodic` action is specified.'
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
- example_heading: Update the Apt repository at a specified interval
  text_blocks:
  - code_block: "apt_update 'all platforms' do\n  frequency 86400\n  action :periodic\n\
      end"
- example_heading: Update the Apt repository at the start of a Chef Infra Client run
  text_blocks:
  - code_block: apt_update 'update'

---
