---
title: gem_package resource
resource: gem_package
draft: false
aliases:
- /resource_gem_package.html
menu:
  docs:
    title: gem_package
    identifier: chef_infra/cookbook_reference/resources/gem_package gem_package
    parent: chef_infra/cookbook_reference/resources
    weight: 510
resource_reference: true
robots: null
resource_description_list:
- warning:
    shortcode: notes_chef_gem_vs_gem_package.md
- markdown: 'Use the **gem_package** resource to manage gem packages that are only

    included in recipes. When a package is installed from a local file, it

    must be added to the node using the **remote_file** or

    **cookbook_file** resources.'
- note:
    markdown: 'The **gem_package** resource must be specified as `gem_package` and

      cannot be shortened to `package` in a recipe.'
resource_new_in: null
handler_types: false
syntax_description: 'A **gem_package** resource block manages a package on a node,
  typically

  by installing it. The simplest use of the **gem_package** resource is:


  ``` ruby

  gem_package ''package_name''

  ```


  which will install the named package using all of the default options

  and the default action (`:install`).'
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "gem_package 'name' do\n  clear_sources              true,\
  \ false\n  gem_binary                 String\n  include_default_source     true,\
  \ false\n  options                    String\n  package_name               String,\
  \ Array\n  source                     String, Array\n  timeout                 \
  \   String, Integer\n  version                    String, Array\n  action      \
  \               Symbol # defaults to :install if not specified\nend"
syntax_full_properties_list:
- '`gem_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`clear_sources`, `gem_binary`, `include_default_source`, `options`, `package_name`,
  `source`, `timeout`, and `version` are the properties available to this resource.'
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
  :upgrade:
    markdown: Install a package and/or ensure that a package is the latest version.
properties_list:
- property: clear_sources
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Set to `true` to download a gem from the path specified by the

      `source` property (and not from RubyGems).'
- property: gem_binary
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A property for the `gem_package` provider that is used to specify a

      gems binary. By default, the same version of Ruby that is used by

      Chef Infra Client will be installed.'
- property: include_default_source
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: '13.0'
  description_list:
  - markdown: 'Set to `false` to not include `Chef::Config[:rubygems_url]` in the

      sources.'
- property: options
  ruby_type: String
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
  - markdown: 'The name of the package. Default value: the `name` of the resource

      block. See "Syntax" section above for more information.'
- property: source
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Optional. The URL, or list of URLs, at which the gem package is

      located. This list is added to the source configured in

      `Chef::Config[:rubygems_url]` (see also `include_default_source`) to

      construct the complete list of rubygems sources. Users in an

      "airgapped" environment should set `Chef::Config[:rubygems_url]` to

      their local RubyGems mirror.'
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
examples_list:
- example_heading: Install a gems file from the local file system
  text_blocks:
  - shortcode: resource_package_install_gems_from_local.md
- example_heading: Use the ignore_failure common attribute
  text_blocks:
  - shortcode: resource_package_use_ignore_failure_attribute.md

---
