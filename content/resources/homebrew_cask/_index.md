---
title: homebrew_cask resource
resource: homebrew_cask
draft: false
aliases:
- /resource_homebrew_cask.html
menu:
  docs:
    title: homebrew_cask
    identifier: chef_infra/cookbook_reference/resources/resource_homebrew_cask.md
      homebrew_cask
    parent: chef_infra/cookbook_reference/resources
    weight: 410
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **homebrew_cask** resource to install binaries distributed via

    the Homebrew package manager.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The homebrew_cask resource has the following syntax:\n\n``` ruby\n\
  homebrew_cask 'name' do\n  cask_name          String # default value: 'name' unless\
  \ specified\n  homebrew_path      String # default value: \"/usr/local/bin/brew\"\
  \n  install_cask       true, false # default value: true\n  options            String\n\
  \  owner              String, Integer\n  action             Symbol # defaults to\
  \ :install if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`homebrew_cask` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`cask_name`, `homebrew_path`, `install_cask`, `options`, and `owner` are the properties
  available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Install an application that is packaged as a Homebrew cask.
  :remove:
    markdown: Remove an application that is packaged as a Homebrew cask.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: cask_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the cask name if it differs from the

      resource block''s name.'
- property: homebrew_path
  ruby_type: String
  required: false
  default_value: '"/usr/local/bin/brew"'
  new_in: null
  description_list:
  - markdown: The path to the homebrew binary.
- property: install_cask
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: Automatically install the Homebrew cask tap, if necessary.
- property: options
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Options to pass to the `brew` command during installation.
- property: owner
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The owner of the Homebrew installation.
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
