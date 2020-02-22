---
title: swap_file resource
resource: swap_file
draft: false
aliases:
- /resource_swap_file.html
menu:
  docs:
    title: swap_file
    identifier: chef_infra/cookbook_reference/resources/swap_file swap_file
    parent: chef_infra/cookbook_reference/resources
    weight: 1020
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **swap_file** resource to create or delete swap files on Linux

    systems, and optionally to manage the swappiness configuration for a

    host.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The swap_file resource has the following syntax:\n\n``` ruby\n\
  swap_file 'name' do\n  path            String # default value: 'name' unless specified\n\
  \  persist         true, false # default value: false\n  size            Integer\n\
  \  swappiness      Integer\n  timeout         Integer # default value: 600\n  action\
  \          Symbol # defaults to :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`swap_file` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`path`, `persist`, `size`, `swappiness`, and `timeout` are the properties available
  to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create a swap file.
  :remove:
    markdown: Remove a swap file and disable swap.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The path where the swap file will be created on the system if it

      differs from the resource block''s name.'
- property: persist
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Persist the swapon.
- property: size
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The size (in MBs) of the swap file.
- property: swappiness
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The swappiness value to set on the system.
- property: timeout
  ruby_type: Integer
  required: false
  default_value: '600'
  new_in: null
  description_list:
  - markdown: Timeout for `dd` / `fallocate` commands.
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
- example_heading: Create a swap file
  text_blocks:
  - code_block: "swap_file '/dev/sda1' do\n  size 1024\nend"
- example_heading: Remove a swap file
  text_blocks:
  - code_block: "swap_file '/dev/sda1' do\n  action :remove\nend"

---
