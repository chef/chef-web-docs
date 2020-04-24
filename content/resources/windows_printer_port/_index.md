---
title: windows_printer_port resource
resource: windows_printer_port
draft: false
aliases:
- /resource_windows_printer_port.html
menu:
  infra:
    title: windows_printer_port
    identifier: chef_infra/cookbook_reference/resources/windows_printer_port windows_printer_port
    parent: chef_infra/cookbook_reference/resources
    weight: 1330
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_printer_port** resource to create and delete

    TCP/IPv4 printer ports on Windows.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The windows_printer_port resource has the following syntax:\n\
  \n``` ruby\nwindows_printer_port 'name' do\n  ipv4_address          String # default\
  \ value: 'name' unless specified\n  port_description      String\n  port_name  \
  \           String\n  port_number           Integer # default value: 9100\n  port_protocol\
  \         Integer # default value: 1\n  snmp_enabled          true, false # default\
  \ value: false\n  action                Symbol # defaults to :create if not specified\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_printer_port` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`ipv4_address`, `port_description`, `port_name`, `port_number`, `port_protocol`,
  and `snmp_enabled` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create the printer port, if one doesn't already exist.
  :delete:
    markdown: Delete an existing printer port.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: ipv4_address
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property for the IPv4 address of the printer if it

      differs from the resource block''s name.'
- property: port_description
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The description of the port.
- property: port_name
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The port name.
- property: port_number
  ruby_type: Integer
  required: false
  default_value: '9100'
  new_in: null
  description_list:
  - markdown: The port number.
- property: port_protocol
  ruby_type: Integer
  required: false
  default_value: '1'
  new_in: null
  description_list:
  - markdown: 'The printer port protocol: `1` (RAW) or `2` (LPR).'
- property: snmp_enabled
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Determines if SNMP is enabled on the port.
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
- example_heading: Delete a printer port
  text_blocks:
  - code_block: "windows_printer_port '10.4.64.37' do\n  action :delete\nend"
- example_heading: Delete a port with a custom port_name
  text_blocks:
  - code_block: "windows_printer_port '10.4.64.38' do\n  port_name 'My awesome port'\n\
      \  action :delete\nend"
- example_heading: Create a port with more options
  text_blocks:
  - code_block: "windows_printer_port '10.4.64.39' do\n  port_name 'My awesome port'\n\
      \  snmp_enabled true\n  port_protocol 2\nend"

---
