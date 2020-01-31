---
title: windows_feature_dism resource
resource: windows_feature_dism
draft: false
aliases: /resource_windows_feature_dism.html
menu:
  docs:
    title: windows_feature_dism
    identifier: chef_infra/cookbook_reference/resources/resource_windows_feature_dism.md
      windows_feature_dism
    parent: chef_infra/cookbook_reference/resources
    weight: 1180
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_feature_dism** resource to add, remove, or entirely

    delete Windows features and roles using DISM.'
resource_new_in: '14.0'
handler_types: false
syntax_description: 'The windows_feature_dism resource has the following syntax:'
syntax_code_block: "windows_feature_dism 'name' do\n  all               true, false\
  \ # default value: false\n  feature_name      Array, String # default value: 'name'\
  \ unless specified\n  source            String\n  timeout           Integer # default\
  \ value: 600\n  action            Symbol # defaults to :install if not specified\n\
  end"
syntax_properties_list:
- '`windows_feature_dism` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`all`, `feature_name`, `source`, and `timeout` are the properties available to
  this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :delete:
    markdown: Delete a Windows role / feature from the image using DISM.
  :install:
    markdown: Default. Install a Windows role / feature using DISM.
  :remove:
    markdown: Remove a Windows role / feature using DISM.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: all
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Install all sub-features. When set to `true`, this is the equivalent

      of specifying the `/All` switch to `dism.exe`.'
- property: feature_name
  ruby_type: Array, String
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'The name of the feature(s) or role(s) to install if they differ from

      the resource name.'
- property: source
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Specify a local repository for the feature install.
- property: timeout
  ruby_type: Integer
  required: false
  default_value: '600'
  new_in: null
  description_list:
  - markdown: Specifies a timeout (in seconds) for the feature installation.
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Installing the TelnetClient service
  text_blocks:
  - code_block: windows_feature_dism "TelnetClient"
- example_heading: Installing two features by using an array
  text_blocks:
  - code_block: windows_feature_dism %w(TelnetClient TFTP)

---
