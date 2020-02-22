---
title: hostname resource
resource: hostname
draft: false
aliases:
- /resource_hostname.html
menu:
  docs:
    title: hostname
    identifier: chef_infra/cookbook_reference/resources/hostname hostname
    parent: chef_infra/cookbook_reference/resources
    weight: 440
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **hostname** resource to set the system''s hostname, configure

    hostname and hosts config file, and re-run the Ohai **hostname** plugin

    so the hostname will be available in subsequent cookbooks.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The hostname resource has the following syntax:\n\n``` ruby\n\
  hostname 'name' do\n  aliases             Array\n  compile_time        true, false\
  \ # default value: true\n  hostname            String # default value: 'name' unless\
  \ specified\n  ipaddress           String # default value: The node's IP address\
  \ as determined by Ohai.\n  windows_reboot      true, false # default value: true\n\
  \  action              Symbol # defaults to :set if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`hostname` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`aliases`, `compile_time`, `hostname`, `ipaddress`, and `windows_reboot` are the
  properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :set:
    markdown: Default action. Set the node's hostname.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: aliases
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: An array of hostname aliases to use when configuring the hosts file.
- property: compile_time
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Determines whether or not the resource should be run at compile

      time.'
- property: hostname
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the hostname if it differs from the

      resource block''s name.'
- property: ipaddress
  ruby_type: String
  required: false
  default_value: The node's IP address as determined by Ohai.
  new_in: null
  description_list:
  - markdown: The IP address to use when configuring the hosts file.
- property: windows_reboot
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Determines whether or not Windows should be reboot after changing

      the hostname, as this is required for the change to take effect.'
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
- example_heading: Set the hostname
  text_blocks:
  - code_block: hostname 'example'
  - markdown: 'The example above sets the hostname to `example` for the IP address,
      as

      detected by Ohai.'
- example_heading: Manually specify the hostname and IP address
  text_blocks:
  - code_block: "hostname 'statically_configured_host' do\n  hostname 'example'\n\
      \  ipaddress '198.51.100.2'\nend"

---
