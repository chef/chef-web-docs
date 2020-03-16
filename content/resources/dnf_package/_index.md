---
title: dnf_package resource
resource: dnf_package
draft: false
aliases:
- /resource_dnf_package.html
menu:
  infra:
    title: dnf_package
    identifier: chef_infra/cookbook_reference/resources/dnf_package dnf_package
    parent: chef_infra/cookbook_reference/resources
    weight: 440
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **dnf_package** resource to install, upgrade, and remove

    packages with DNF for Fedora and RHEL 8+. The **dnf_package** resource

    is able to resolve `provides` data for packages much like DNF can do

    when it is run from the command line. This allows a variety of options

    for installing packages, like minimum versions, virtual provides, and

    library names.'
- note:
    shortcode: notes_resource_based_on_package.md
resource_new_in: null
handler_types: false
syntax_description: 'A **dnf_package** resource block manages a package on a node,
  typically

  by installing it. The simplest use of the **dnf_package** resource is:


  ``` ruby

  dnf_package ''package_name''

  ```


  which will install the named package using all of the default options

  and the default action (`:install`).'
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "dnf_package 'name' do\n  arch              String, Array\n\
  \  flush_cache       Hash # default value: {\"before\"=>false, \"after\"=>false}\n\
  \  options           String, Array\n  package_name      String, Array\n  source\
  \            String\n  timeout           String, Integer\n  version           String,\
  \ Array\n  action            Symbol # defaults to :install if not specified\nend"
syntax_full_properties_list:
- '`dnf_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`arch`, `flush_cache`, `options`, `package_name`, `source`, `timeout`, and `version`
  are the properties available to this resource.'
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
    markdown: Locks the DNF package to a specific version.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :purge:
    markdown: Purge a package. This action typically removes the configuration files
      as well as the package.
  :remove:
    markdown: Remove a package.
  :unlock:
    markdown: Unlocks the DNF package so that it can be upgraded to a newer version.
  :upgrade:
    markdown: Install a package and/or ensure that a package is the latest version.
      This action will ignore the `version` attribute.
properties_list:
- property: arch
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The architecture of the package to be installed or upgraded. This

      value can also be passed as part of the package name.'
- property: flush_cache
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "Flush the in-memory cache before or after a DNF operation that\ninstalls,\
      \ upgrades, or removes a package. Default value:\n`[ :before, :after ]`. The\
      \ value may also be a Hash:\n`( { :before => true/false, :after => true/false\
      \ } )`.\n\nDNF automatically synchronizes remote metadata to a local cache.\n\
      Chef Infra Client creates a copy of the local cache, and then stores\nit in-memory\
      \ during a Chef Infra Client run. The in-memory cache\nallows packages to be\
      \ installed during a Chef Infra Client run\nwithout the need to continue synchronizing\
      \ the remote metadata to\nthe local cache while a Chef Infra Client run is in-progress.\n\
      \nAs an array:\n\n``` ruby\ndnf_package 'some-package' do\n  #...\n  flush_cache\
      \ [ :before ]\n  #...\nend\n```\n\nand as a Hash:\n\n``` ruby\ndnf_package 'some-package'\
      \ do\n  #...\n  flush_cache( { :after => true } )\n  #...\nend\n```"
  - note:
    - markdown: 'The `flush_cache` property does not flush the local DNF cache! Use

        dnf tools---`dnf clean metadata`, `dnf clean packages`,

        `dnf clean all`---to clean the local DNF cache.'
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
  - markdown: 'The version of a package to be installed or upgraded. This property

      is ignored when using the `:upgrade` action.'
properties_shortcode: null
properties_multiple_packages: true
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
- example_heading: Install an exact version
  text_blocks:
  - code_block: dnf_package 'netpbm = 10.35.58-8.el5'
- example_heading: Install a minimum version
  text_blocks:
  - code_block: dnf_package 'netpbm >= 10.35.58-8.el5'
- example_heading: Install a minimum version using the default action
  text_blocks:
  - code_block: dnf_package 'netpbm'
- example_heading: To install a package
  text_blocks:
  - code_block: "dnf_package 'netpbm' do\n  action :install\nend"
- example_heading: To install a partial minimum version
  text_blocks:
  - code_block: dnf_package 'netpbm >= 10'
- example_heading: To install a specific architecture
  text_blocks:
  - code_block: "dnf_package 'netpbm' do\n  arch 'i386'\nend"
  - markdown: 'or:'
  - code_block: dnf_package 'netpbm.x86_64'
- example_heading: To install a specific version-release
  text_blocks:
  - code_block: "dnf_package 'netpbm' do\n  version '10.35.58-8.el5'\nend"
- example_heading: To install a specific version (even when older than the current)
  text_blocks:
  - code_block: "dnf_package 'tzdata' do\n  version '2011b-1.el5'\nend"
- example_heading: Handle cookbook_file and dnf_package resources in the same recipe
  text_blocks:
  - markdown: 'When a **cookbook_file** resource and a **dnf_package** resource are

      both called from within the same recipe, use the `flush_cache` attribute

      to dump the in-memory DNF cache, and then use the repository immediately

      to ensure that the correct package is installed:'
  - code_block: "cookbook_file '/etc/yum.repos.d/custom.repo' do\n  source 'custom'\n\
      \  mode '0755'\nend\n\ndnf_package 'only-in-custom-repo' do\n  action :install\n\
      \  flush_cache [ :before ]\nend"

---
