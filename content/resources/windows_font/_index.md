---
title: windows_font resource
resource: windows_font
draft: false
aliases:
- /resource_windows_font.html
menu:
  docs:
    title: windows_font
    identifier: chef_infra/cookbook_reference/resources/windows_font windows_font
    parent: chef_infra/cookbook_reference/resources
    weight: 1340
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_font** resource to install font files on Windows. By

    default, the font is sourced from the cookbook using the resource, but a

    URI source can be specified as well.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The windows_font resource has the following syntax:\n\n``` ruby\n\
  windows_font 'name' do\n  font_name      String # default value: 'name' unless specified\n\
  \  source         String\n  action         Symbol # defaults to :install if not\
  \ specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_font` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`font_name` and `source` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Install the font to the system fonts directory.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: font_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the name of the font to install if it

      differs from the resource block''s name.'
- property: source
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: A local filesystem path or URI that is used to source the font file.
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
- example_heading: Install a font from a https source
  text_blocks:
  - code_block: "windows_font 'Custom.otf' do\n  source \"https://example.com/Custom.otf\"\
      \nend"

---
