---
resource_reference: true
common_resource_functionality_multiple_packages: false
common_resource_functionality_resources_common_windows_security: false
cookbook_file_specificity: false
debug_recipes_chef_shell: false
handler_custom: false
handler_types: false
nameless_apt_update: false
nameless_build_essential: false
properties_multiple_packages: false
properties_resources_common_windows_security: false
properties_shortcode: 
ps_credential_helper: false
registry_key: false
remote_directory_recursive_directories: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
resource_directory_recursive_directories: false
resource_package_options: false
resources_common_atomic_update: false
resources_common_guard_interpreter: false
resources_common_guards: true
resources_common_notification: true
resources_common_properties: true
ruby_style_basics_chef_log: false
syntax_shortcode: 
template_requirements: false
unit_file_verification: false
title: bff_package resource
resource: bff_package
aliases:
- "/resource_bff_package.html"
menu:
  infra:
    title: bff_package
    identifier: chef_infra/cookbook_reference/resources/bff_package bff_package
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: 'Use the **bff_package** resource to manage packages for the AIX

    platform using the installp utility. When a package is installed from a

    local file, it must be added to the node using the **remote_file** or

    **cookbook_file** resources.'
- note:
    markdown: 'A Backup File Format (BFF) package may not have a `.bff` file extension.

      Chef Infra Client will still identify the correct provider to use based

      on the platform, regardless of the file extension.'
- note:
    shortcode: notes_resource_based_on_package.md
syntax_description: 'A **bff_package** resource manages a package on a node, typically
  by

  installing it. The simplest use of the **bff_package** resource is:


  ``` ruby

  bff_package ''package_name''

  ```


  which will install the named package using all of the default options

  and the default action (`:install`).'
syntax_full_code_block: |-
  bff_package 'name' do
    options           String, Array
    package_name      String
    source            String
    timeout           String, Integer
    version           String
    action            Symbol # defaults to :install if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`bff_package` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`options`, `package_name`, `source`, `timeout`, and `version` are the properties
  available to this resource."
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
  :remove:
    markdown: Remove a package.
properties_list:
- property: options
  ruby_type: String, Array
  required: false
  description_list:
  - markdown: One (or more) additional command options that are passed to the command.
- property: package_name
  ruby_type: String
  required: false
  description_list:
  - markdown: An optional property to set the package name if it differs from the
      resource block's name.
- property: source
  ruby_type: String
  required: false
  description_list:
  - markdown: 'Required. The path to a package in the local file system. The AIX

      platform requires `source` to be a local file system path because

      `installp` does not retrieve packages using HTTP or FTP.'
- property: timeout
  ruby_type: String, Integer
  required: false
  description_list:
  - markdown: The amount of time (in seconds) to wait before timing out.
- property: version
  ruby_type: String
  required: false
  description_list:
  - markdown: The version of a package to be installed or upgraded.
examples: "
  Install a package\n\n  The **bff_package** resource is the default\
  \ package provider on the AIX\n  platform. The base **package** resource may be\
  \ used, and then when the\n  platform is AIX, Chef Infra Client will identify the\
  \ correct package\n  provider. The following examples show how to install part of\
  \ the IBM XL\n  C/C++ compiler.\n\n  Using the base **package** resource:\n\n  ```\
  \ ruby\n  package 'xlccmp.13.1.0' do\n    source '/var/tmp/IBM_XL_C_13.1.0/usr/sys/inst.images/xlccmp.13.1.0'\n\
  \    action :install\n  end\n  ```\n\n  Using the **bff_package** resource:\n\n\
  \  ``` ruby\n  bff_package 'xlccmp.13.1.0' do\n    source '/var/tmp/IBM_XL_C_13.1.0/usr/sys/inst.images/xlccmp.13.1.0'\n\
  \    action :install\n  end\n  ```\n"

---
