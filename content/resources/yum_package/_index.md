---
title: yum_package resource
resource: yum_package
draft: false
aliases:
- /resource_yum_package.html
- /resource_yum.html
menu:
  infra:
    title: yum_package
    identifier: chef_infra/cookbook_reference/resources/yum_package yum_package
    parent: chef_infra/cookbook_reference/resources
    weight: 1460
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **yum_package** resource to install, upgrade, and remove

    packages with Yum for the Red Hat and CentOS platforms. The

    **yum_package** resource is able to resolve `provides` data for

    packages much like Yum can do when it is run from the command line. This

    allows a variety of options for installing packages, like minimum

    versions, virtual provides, and library names.'
- note:
    markdown: 'Support for using file names to install packages (as in

      `yum_package "/bin/sh"`) is not available because the volume of data

      required to parse for this is excessive.'
- note:
    shortcode: notes_resource_based_on_package.md
resource_new_in: null
handler_types: false
syntax_description: "A **yum_package** resource block manages a package on a node,\
  \ typically\nby installing it. The simplest use of the **yum_package** resource\
  \ is:\n\n``` ruby\nyum_package 'package_name'\n```\n\nwhich will install the named\
  \ package using all of the default options\nand the default action (`:install`).\n\
  \nThe yum_package resource has the following syntax:\n\n``` ruby\nyum_package 'name'\
  \ do\n  allow_downgrade      true, false # default value: true\n  arch         \
  \        String, Array\n  flush_cache          Hash # default value: {\"before\"\
  =>false, \"after\"=>false}\n  options              String, Array\n  package_name\
  \         String, Array\n  source               String\n  timeout              String,\
  \ Integer\n  version              String, Array\n  yum_binary           String\n\
  \  action               Symbol # defaults to :install if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`yum_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`allow_downgrade`, `arch`, `flush_cache`, `options`, `package_name`, `source`,
  `timeout`, `version`, and `yum_binary` are the properties available to this resource.'
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
    markdown: Locks the yum package to a specific version.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :purge:
    markdown: Purge a package. This action typically removes the configuration files
      as well as the package.
  :remove:
    markdown: Remove a package.
  :unlock:
    markdown: Unlocks the yum package so that it can be upgraded to a newer version.
  :upgrade:
    markdown: Install a package and/or ensure that a package is the latest version.
      This action will ignore the `version` attribute.
properties_list:
- property: allow_downgrade
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: Downgrade a package to satisfy requested version requirements.
- property: arch
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The architecture of the package to be installed or upgraded. This

      value can also be passed as part of the package name.'
- property: flush_cache
  ruby_type: Hash
  required: false
  default_value: '{"before"=>false, "after"=>false}'
  new_in: null
  description_list:
  - markdown: 'Flush the in-memory cache before or after a Yum operation that

      installs, upgrades, or removes a package. Accepts a Hash in the

      form: { :before =\> true/false, :after =\> true/false } or an Array

      in the form \[ :before, :after \].'
  - shortcode: resources_common_package_yum_cache.md
  - markdown: "As an array:\n\n``` ruby\nyum_package 'some-package' do\n  #...\n \
      \ flush_cache [ :before ]\n  #...\nend\n```\n\nand as a Hash:\n\n``` ruby\n\
      yum_package 'some-package' do\n  #...\n  flush_cache( { :after => true } )\n\
      \  #...\nend\n```"
  - note:
    - markdown: 'The `flush_cache` property does not flush the local Yum cache! Use

        Yum tools---`yum clean headers`, `yum clean packages`,

        `yum clean all`---to clean the local Yum cache.'
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
  - markdown: 'One of the following: the name of a package, the name of a package

      and its architecture, the name of a dependency. Default value: the

      `name` of the resource block. See "Syntax" section above for more

      information.'
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
  - markdown: 'The version of a package to be installed or upgraded. This property

      is ignored when using the `:upgrade` action.'
- property: yum_binary
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list: []
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
- example_heading: Install an exact version
  text_blocks:
  - code_block: yum_package 'netpbm = 10.35.58-8.el5'
- example_heading: Install a minimum version
  text_blocks:
  - code_block: yum_package 'netpbm >= 10.35.58-8.el5'
- example_heading: Install a minimum version using the default action
  text_blocks:
  - code_block: yum_package 'netpbm'
- example_heading: To install a package
  text_blocks:
  - code_block: "yum_package 'netpbm' do\n  action :install\nend"
- example_heading: To install a partial minimum version
  text_blocks:
  - code_block: yum_package 'netpbm >= 10'
- example_heading: To install a specific architecture
  text_blocks:
  - code_block: "yum_package 'netpbm' do\n  arch 'i386'\nend"
  - markdown: 'or:'
  - code_block: yum_package 'netpbm.x86_64'
- example_heading: To install a specific version-release
  text_blocks:
  - code_block: "yum_package 'netpbm' do\n  version '10.35.58-8.el5'\nend"
- example_heading: Handle cookbook_file and yum_package resources in the same recipe
  text_blocks:
  - markdown: 'When a **cookbook_file** resource and a **yum_package** resource are

      both called from within the same recipe, use the `flush_cache` attribute

      to dump the in-memory Yum cache, and then use the repository immediately

      to ensure that the correct package is installed:'
  - code_block: "cookbook_file '/etc/yum.repos.d/custom.repo' do\n  source 'custom'\n\
      \  mode '0755'\nend\n\nyum_package 'only-in-custom-repo' do\n  action :install\n\
      \  flush_cache [ :before ]\nend"

---
