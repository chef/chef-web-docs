---
title: windows_feature_powershell resource
resource: windows_feature_powershell
draft: false
aliases:
- /resource_windows_feature_powershell.html
menu:
  docs:
    title: windows_feature_powershell
    identifier: chef_infra/cookbook_reference/resources/resource_windows_feature_powershell.md
      windows_feature_powershell
    parent: chef_infra/cookbook_reference/resources
    weight: 1190
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_feature_powershell** resource to add, remove, or

    entirely delete Windows features and roles using PowerShell. This

    resource offers significant speed benefits over the

    [windows_feature_dism](/resources/windows_feature_dism/) resource,

    but requires installation of the Remote Server Administration Tools on

    non-server releases of Windows.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The windows_feature_powershell resource has the following syntax:\n\
  \n``` ruby\nwindows_feature_powershell 'name' do\n  all                   true,\
  \ false # default value: false\n  feature_name          Array, String # default\
  \ value: 'name' unless specified\n  management_tools      true, false # default\
  \ value: false\n  source                String\n  timeout               Integer\
  \ # default value: 600\n  action                Symbol # defaults to :install if\
  \ not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_feature_powershell` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`all`, `feature_name`, `management_tools`, `source`, and `timeout` are the properties
  available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :delete:
    markdown: Delete a Windows role / feature from the image using PowerShell.
  :install:
    markdown: Default. Install a Windows role / feature using PowerShell.
  :remove:
    markdown: Remove a Windows role / feature using PowerShell.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: all
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Install all subfeatures. When set to `true`, this is the equivalent

      of specifying the `-InstallAllSubFeatures` switch with

      `Add-WindowsFeature`.'
- property: feature_name
  ruby_type: Array, String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The name of the feature(s) or role(s) to install if they differ from

      the resource block''s name.'
- property: management_tools
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Install all applicable management tools for the roles, role

      services, or features.'
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
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Add the SMTP Server feature
  text_blocks:
  - code_block: "windows_feature_powershell \"smtp-server\" do\n  action :install\n\
      \  all true\nend"
- example_heading: Install multiple features using one resource
  text_blocks:
  - code_block: "windows_feature_powershell ['Web-Asp-Net45', 'Web-Net-Ext45'] do\n\
      \  action :install\nend"
- example_heading: 'Install the Network Policy and Access Service feature, including
    the

    management tools. Which, for this example, will automatically install

    RSAT-NPAS as well.'
  text_blocks:
  - code_block: "windows_feature_powershell 'NPAS' do\n  action :install\n  management_tools\
      \ true\nend"

---
