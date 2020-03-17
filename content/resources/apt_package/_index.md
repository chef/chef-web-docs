---
title: apt_package resource
resource: apt_package
draft: false
aliases:
- /resource_apt_package.html
menu:
  infra:
    title: apt_package
    identifier: chef_infra/cookbook_reference/resources/apt_package apt_package
    parent: chef_infra/cookbook_reference/resources
    weight: 70
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **apt_package** resource to manage packages on Debian and

    Ubuntu platforms.'
- note:
    shortcode: notes_resource_based_on_package.md
resource_new_in: null
handler_types: false
syntax_description: 'A **apt_package** resource block manages a package on a node,
  typically

  by installing it. The simplest use of the **apt_package** resource is:


  ``` ruby

  apt_package ''package_name''

  ```


  which will install the named package using all of the default options

  and the default action (`:install`).'
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "apt_package 'name' do\n  default_release              String\n\
  \  options                      String, Array\n  overwrite_config_files       true,\
  \ false # default value: false\n  package_name                 String, Array\n \
  \ response_file                String\n  response_file_variables      Hash\n  timeout\
  \                      String, Integer\n  version                      String, Array\n\
  \  action                       Symbol # defaults to :install if not specified\n\
  end"
syntax_full_properties_list:
- '`apt_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`default_release`, `options`, `overwrite_config_files`, `package_name`, `response_file`,
  `response_file_variables`, `source`, `timeout`, and `version` are the properties
  available to this resource.'
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
  :nothing:
    shortcode: resources_common_actions_nothing.md
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
properties_list:
- property: default_release
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The default release. For example: `stable`.'
- property: options
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'One (or more) additional options that are passed to the command. For

      example, common apt-get directives, such as

      `--no-install-recommends`. See the [apt-get man

      page](http://manpages.ubuntu.com/manpages/zesty/man8/apt-get.8.html)

      for the full list.'
- property: overwrite_config_files
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '14.0'
  description_list:
  - markdown: 'Overwrite existing configuration files with those supplied by the

      package, if prompted by APT.'
- property: package_name
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An optional property to set the package name if it differs from the

      resource block''s name.'
- property: response_file
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The direct path to the file used to pre-seed a package.
- property: response_file_variables
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A Hash of response file variables in the form of {''VARIABLE'' =\>

      ''VALUE''}.'
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
common_resource_functionality_multiple_packages: true
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Install a package using package manager
  text_blocks:
  - code_block: "apt_package 'name of package' do\n  action :install\nend"
- example_heading: Install without using recommend packages as a dependency
  text_blocks:
  - code_block: "package 'apache2' do\n  options '--no-install-recommends'\nend"

---
