---
title: cab_package resource
resource: cab_package
aliases:
- "/resource_cab_package.html"
menu:
  infra:
    title: cab_package
    identifier: chef_infra/cookbook_reference/resources/cab_package cab_package
    parent: chef_infra/cookbook_reference/resources
    weight: 180
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **cab_package** resource to install or remove Microsoft Windows

    cabinet (.cab) packages.'
resource_new_in: null
syntax_full_code_block: |-
  cab_package 'name' do
    options           String, Array
    package_name      String
    source            String # default value: The package name.
    timeout           String, Integer
    version           String
    action            Symbol # defaults to :install if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`cab_package` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "``options``, ``package_name``, ``source``, ``timeout``, and ``version`` are the
  properties available to this resource."
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Installs the cabinet package.
  :remove:
    markdown: Removes the cabinet package.
properties_list:
- property: package_name
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: An optional property to set the package name if it differs from the
      resource block's name.
- property: source
  ruby_type: String
  required: false
  default_value: The package name.
  new_in: 
  description_list:
  - markdown: The local file path or URL for the CAB package.
- property: timeout
  ruby_type: String, Integer
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The amount of time (in seconds) to wait before timing out.
- property: version
  ruby_type: String
  required: false
  default_value: 
  new_in: 
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
- example_heading: Using local path in source
  text_blocks:
  - code_block: "cab_package 'Install .NET 3.5 sp1 via KB958488' do\n  source 'C:\\\
      Users\\xyz\\AppData\\Local\\Temp\\Windows6.1-KB958488-x64.cab'\n  action :install\n\
      end"
  - code_block: "cab_package 'Remove .NET 3.5 sp1 via KB958488' do\n  source 'C:\\\
      Users\\xyz\\AppData\\Local\\Temp\\Windows6.1-KB958488-x64.cab'\n  action :remove\n\
      end"
- example_heading: Using URL in source
  text_blocks:
  - code_block: "cab_package 'Install .NET 3.5 sp1 via KB958488' do\n  source 'https://s3.amazonaws.com/my_bucket/Windows6.1-KB958488-x64.cab'\n\
      \  action :install\nend"
  - code_block: "cab_package 'Remove .NET 3.5 sp1 via KB958488' do\n  source 'https://s3.amazonaws.com/my_bucket/Temp\\\
      Windows6.1-KB958488-x64.cab'\n  action :remove\nend"

---
