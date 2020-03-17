---
title: chocolatey_package resource
resource: chocolatey_package
draft: false
aliases:
- /resource_chocolatey_package.html
menu:
  infra:
    title: chocolatey_package
    identifier: chef_infra/cookbook_reference/resources/chocolatey_package chocolatey_package
    parent: chef_infra/cookbook_reference/resources
    weight: 350
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **chocolatey_package** resource to manage packages using

    Chocolatey on the Microsoft Windows platform.'
- warning:
    markdown: 'The **chocolatey_package** resource must be specified as

      `chocolatey_package` and cannot be shortened to `package` in a recipe.'
- note:
    markdown: 'The Chocolatey package manager is not installed on Windows by default.

      Install it prior to using this resource by adding the [Chocolatey

      cookbook](https://supermarket.chef.io/cookbooks/chocolatey/) to your

      node''s run list.'
resource_new_in: '12.7'
handler_types: false
syntax_description: 'A **chocolatey_package** resource manages packages using Chocolatey
  on

  the Microsoft Windows platform. The simplest use of the

  **chocolatey_package** resource is:


  ``` ruby

  chocolatey_package ''package_name''

  ```


  which will install the named package using all of the default options

  and the default action (`:install`).'
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "chocolatey_package 'name' do\n  list_options      String\n\
  \  options           String, Array\n  package_name      String, Array\n  password\
  \          String\n  returns           Integer, Array # default value: [0, 2]\n\
  \  source            String\n  timeout           String, Integer\n  user       \
  \       String\n  version           String, Array\n  action            Symbol #\
  \ defaults to :install if not specified\nend"
syntax_full_properties_list:
- '`chocolatey_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`list_options`, `options`, `package_name`, `password`, `returns`, `source`, `timeout`,
  `user`, and `version` are the properties available to this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Install a package. If a version is specified, install the specified
      version of the package.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :purge:
    markdown: Purge a package. This action typically removes the configuration files
      as well as the package.
  :reconfig:
    markdown: Reconfigure a package. This action requires a response file.
  :remove:
    markdown: Remove a package.
  :uninstall:
    markdown: "Uninstall a package.\n Deprecated as of Chef 13.7"
  :upgrade:
    markdown: Install a package and/or ensure that a package is the latest version.
properties_list:
- property: list_options
  ruby_type: String
  required: false
  default_value: null
  new_in: '15.3'
  description_list:
  - markdown: 'One (or more) additional list options that are passed to the

      command.'
- property: options
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: One (or more) additional options that are passed to the command.
- property: package_name
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The name of the package. Default value: the name of the resource

      block.'
- property: password
  ruby_type: String
  required: false
  default_value: null
  new_in: '15.3'
  description_list:
  - markdown: The password to authenticate to the source.
- property: returns
  ruby_type: Integer, Array
  required: false
  default_value: '[0, 2]'
  new_in: null
  description_list:
  - markdown: 'The exit code(s) returned a chocolatey package that indicate

      success.


      0: operation was successful, no issues detected


      2: no results (enhanced)


      NOTE: Starting in v0.10.12, if you have the feature

      ''useEnhancedExitCodes'' turned on, then choco will provide enhanced

      exit codes that allow better integration and scripting.


      The syntax for `returns` is:


      ``` ruby

      returns [0, 2, 1605, 1614, 1641]

      ```


      *Updated in Chef Infra Client 15.3.*'
- property: source
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Optional. The path to a package in the local file system or a

      reachable UNC path. Ensure that the path specified is to the

      **folder** containing the chocolatey package(s), not to the package

      itself.'
- property: timeout
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The amount of time (in seconds) to wait before timing out.
- property: user
  ruby_type: String
  required: false
  default_value: null
  new_in: '15.3'
  description_list:
  - markdown: The username to authenticate feeds.
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
examples_list:
- example_heading: Install a Chocolatey package
  text_blocks:
  - code_block: "chocolatey_package 'name of package' do\n  action :install\nend"
  - markdown: '**Install a package with Chocolatey''s \`\`--checksum\`\` option**'
  - code_block: "chocolatey_package 'name of package' do\n  options '--checksum 1234567890'\n\
      \  action :install\nend"

---
