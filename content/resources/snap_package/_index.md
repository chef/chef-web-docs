---
title: snap_package resource
resource: snap_package
draft: false
aliases:
- /resource_snap_package.html
menu:
  infra:
    title: snap_package
    identifier: chef_infra/cookbooks/resources/snap_package snap_package
    parent: chef_infra/cookbooks/resources
    weight: 1100
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **snap_package** resource to manage snap packages on Debian and

    Ubuntu platforms.'
resource_new_in: '15.0'
handler_types: false
syntax_description: "The snap_package resource has the following syntax:\n\n``` ruby\n\
  snap_package 'name' do\n  channel           String # default value: \"stable\"\n\
  \  options           String, Array\n  package_name      String, Array\n  source\
  \            String\n  timeout           String, Integer\n  version           String,\
  \ Array\n  action            Symbol # defaults to :install if not specified\nend\n\
  ```"
syntax_code_block: null
syntax_properties_list:
- '`snap_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`channel`, `options`, `package_name`, `source`, `timeout`, and `version` are the
  properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Install a package. If a version is specified, install the specified
      version of the package.
  :lock:
    markdown: Locks the apt package to a specific version.
  :purge:
    markdown: Purge a package. This action typically removes the configuration files
      as well as the package.
  :reconfig:
    markdown: Reconfigure a package. This action requires a response file.
  :remove:
    markdown: Remove a package.
  :unlock:
    markdown: Unlocks the apt package so that it can be upgraded to a newer version.
  :upgrade:
    markdown: Install a package and/or ensure that a package is the latest version.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: channel
  ruby_type: String
  required: false
  default_value: '"stable"'
  new_in: null
  description_list:
  - markdown: 'The default channel. For example: stable.'
- property: options
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'One (or more) additional command options that are passed to the

      command.'
- property: package_name
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An optional property to set the package name if it differs from the

      resource block''s name.'
- property: source
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The optional path to a package on the local file system.
- property: timeout
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The amount of time (in seconds) to wait before timing out.
- property: version
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The version of a package to be installed or upgraded.
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
