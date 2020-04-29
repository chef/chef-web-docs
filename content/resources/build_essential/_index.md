---
title: build_essential resource
resource: build_essential
draft: false
aliases:
- "/resource_build_essential.html"
menu:
  infra:
    title: build_essential
    identifier: chef_infra/cookbook_reference/resources/build_essential build_essential
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **build_essential** resource to install the packages required

    for compiling C software from source.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The build_essential resource has the following syntax:\n\n```\
  \ ruby\nbuild_essential 'name' do\n  compile_time      true, false # default value:\
  \ false\n  action            Symbol # defaults to :install if not specified\nend\n\
  ```"
syntax_code_block: null
syntax_properties_list:
- '`build_essential` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`compile_time` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: true
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Install the build essential packages.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: compile_time
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Install the build essential packages at compile time.
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
- example_heading: Install compilation packages
  text_blocks:
  - code_block: build_essential
- example_heading: Install compilation packages during the compilation phase
  text_blocks:
  - code_block: "build_essential 'Install compilation tools' do\n  compile_time true\n\
      end"

---
