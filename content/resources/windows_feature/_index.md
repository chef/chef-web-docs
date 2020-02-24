---
title: windows_feature resource
resource: windows_feature
draft: false
aliases:
- /resource_windows_feature.html
menu:
  docs:
    title: windows_feature
    identifier: chef_infra/cookbook_reference/resources/windows_feature windows_feature
    parent: chef_infra/cookbook_reference/resources
    weight: 1170
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_feature** resource to add, remove or entirely delete

    Windows features and roles. This resource calls the

    [windows_feature_dism](/resources/windows_feature_dism/) or

    [windows_feature_powershell](/resources/windows_feature_powershell/)

    resources depending on the specified installation method, and defaults

    to DISM, which is available on both Workstation and Server editions of

    Windows.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The windows_feature resource has the following syntax:\n\n```\
  \ ruby\nwindows_feature 'name' do\n  all                   true, false # default\
  \ value: false\n  feature_name          Array, String # default value: 'name' unless\
  \ specified\n  install_method        Symbol # default value: :windows_feature_dism\n\
  \  management_tools      true, false # default value: false\n  source          \
  \      String\n  timeout               Integer # default value: 600\n  action  \
  \              Symbol # defaults to :install if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_feature` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`all`, `feature_name`, `install_method`, `management_tools`, `source`, and `timeout`
  are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Install a Windows role / feature using PowerShell.
  :remove:
    markdown: Remove a Windows role / feature using PowerShell.
  :delete:
    markdown: Delete a Windows role / feature from the image using PowerShell.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: all
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Install all sub-features.
- property: feature_name
  ruby_type: Array, String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The name of the feature(s) or role(s) to install if they differ from

      the resource block''s name. The same feature may have different names

      depending on the underlying installation method being used (ie

      DHCPServer vs DHCP; DNS-Server-Full-Role vs DNS).'
- property: install_method
  ruby_type: Symbol
  required: false
  default_value: :windows_feature_dism
  new_in: null
  description_list:
  - markdown: 'The underlying installation method to use for feature installation.

      Specify '':windows_feature_dism'' for DISM or

      '':windows_feature_powershell'' for PowerShell.'
- property: management_tools
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Install all applicable management tools for the roles, role

      services, or features (PowerShell-only).'
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
- example_heading: Install the DHCP Server feature
  text_blocks:
  - code_block: "windows_feature 'DHCPServer' do\n  action :install\nend"
- example_heading: Install the .Net 3.5.1 feature using repository files on DVD
  text_blocks:
  - code_block: "windows_feature \"NetFx3\" do\n  action :install\n  source \"d:\\\
      sources\\sxs\"\nend"
- example_heading: Remove Telnet Server and Client features
  text_blocks:
  - code_block: "windows_feature ['TelnetServer', 'TelnetClient'] do\n  action :remove\n\
      end"
- example_heading: Add the SMTP Server feature using the PowerShell provider
  text_blocks:
  - code_block: "windows_feature \"smtp-server\" do\n  action :install\n  all true\n\
      \  install_method :windows_feature_powershell\nend"
- example_heading: 'Install multiple features using one resource with the PowerShell

    provider'
  text_blocks:
  - code_block: "windows_feature ['Web-Asp-Net45', 'Web-Net-Ext45'] do\n  action :install\n\
      \  install_method :windows_feature_powershell\nend"
- example_heading: 'Install the Network Policy and Access Service feature, including
    the

    management tools. Which, for this example, will automatically install

    RSAT-NPAS as well.'
  text_blocks:
  - code_block: "windows_feature 'NPAS' do\n  action :install\n  management_tools\
      \ true\n  install_method :windows_feature_powershell\nend"

---
