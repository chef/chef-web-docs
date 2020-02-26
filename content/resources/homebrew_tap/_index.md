---
title: homebrew_tap resource
resource: homebrew_tap
draft: false
aliases:
- /resource_homebrew_tap.html
menu:
  docs:
    title: homebrew_tap
    identifier: chef_infra/cookbook_reference/resources/homebrew_tap homebrew_tap
    parent: chef_infra/cookbook_reference/resources
    weight: 560
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **homebrew_tap** resource to add additional formula

    repositories to the Homebrew package manager.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The homebrew_tap resource has the following syntax:\n\n``` ruby\n\
  homebrew_tap 'name' do\n  full               true, false # default value: false\n\
  \  homebrew_path      String # default value: \"/usr/local/bin/brew\"\n  owner \
  \             String\n  tap_name           String # default value: 'name' unless\
  \ specified\n  url                String\n  action             Symbol # defaults\
  \ to :tap if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`homebrew_tap` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`full`, `homebrew_path`, `owner`, `tap_name`, and `url` are the properties available
  to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :tap:
    markdown: Default. Add a Homebrew tap.
  :untap:
    markdown: Remove a Homebrew tap.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: full
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Perform a full clone on the tap, as opposed to a shallow clone.
- property: homebrew_path
  ruby_type: String
  required: false
  default_value: '"/usr/local/bin/brew"'
  new_in: null
  description_list:
  - markdown: The path to the Homebrew binary.
- property: owner
  ruby_type: String
  required: false
  default_value: Calculated default username
  new_in: null
  description_list:
  - markdown: The owner of the Homebrew installation.
- property: tap_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the tap name if it differs from the

      resource block''s name.'
- property: url
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The URL of the tap.
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
