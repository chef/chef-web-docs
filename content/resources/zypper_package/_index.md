---
title: zypper_package resource
resource: zypper_package
draft: false
aliases:
- /resource_zypper_package.html
menu:
  infra:
    title: zypper_package
    identifier: chef_infra/cookbook_reference/resources/zypper_package zypper_package
    parent: chef_infra/cookbook_reference/resources
    weight: 1480
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **zypper_package** resource to install, upgrade, and remove

    packages with Zypper for the SUSE Enterprise and OpenSUSE platforms.'
- note:
    shortcode: notes_resource_based_on_package.md
resource_new_in: null
handler_types: false
syntax_description: "A **zypper_package** resource block manages a package on a node,\n\
  typically by installing it. The simplest use of the **zypper_package**\nresource\
  \ is:\n\n``` ruby\nzypper_package 'package_name'\n```\n\nwhich will install the\
  \ named package using all of the default options\nand the default action (`:install`).\n\
  \nThe zypper_package resource has the following syntax:\n\n``` ruby\nzypper_package\
  \ 'name' do\n  allow_downgrade      true, false # default value: true\n  global_options\
  \       String, Array\n  gpg_check            true, false # default value: \"true\"\
  \n  options              String, Array\n  package_name         String, Array\n \
  \ source               String\n  timeout              String, Integer\n  version\
  \              String, Array\n  action               Symbol # defaults to :install\
  \ if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`zypper_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`allow_downgrade`, `global_options`, `gpg_check`, `options`, `package_name`, `source`,
  `timeout`, and `version` are the properties available to this resource.'
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
    markdown: Locks the zypper package to a specific version.
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
    markdown: Unlocks the zypper package so that it can be upgraded to a newer version.
  :upgrade:
    markdown: Install a package and/or ensure that a package is the latest version.
properties_list:
- property: allow_downgrade
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: '13.6'
  description_list:
  - markdown: 'Allow downgrading a package to satisfy requested version

      requirements.'
- property: global_options
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: '14.6'
  description_list:
  - markdown: 'One (or more) additional command options that are passed to the

      command. For example, common zypper directives, such as

      `--no-recommends`. See the [zypper man

      page](https://en.opensuse.org/SDB:Zypper_manual_(plain)) for the

      full list.'
- property: gpg_check
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Verify the package''s GPG signature. Can also be controlled site-wide

      using the `zypper_check_gpg` config option.'
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
- example_heading: Install a package using package manager
  text_blocks:
  - code_block: "zypper_package 'name of package' do\n  action :install\nend"
- example_heading: Install a package using local file
  text_blocks:
  - code_block: "zypper_package 'jwhois' do\n  action :install\n  source '/path/to/jwhois.rpm'\n\
      end"
- example_heading: Install without using recommend packages as a dependency
  text_blocks:
  - code_block: "package 'apache2' do\n  options '--no-recommends'\nend"

---
