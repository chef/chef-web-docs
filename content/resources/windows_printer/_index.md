---
title: windows_printer resource
resource: windows_printer
draft: false
aliases:
- /resource_windows_printer.html
menu:
  infra:
    title: windows_printer
    identifier: chef_infra/cookbooks/resources/windows_printer windows_printer
    parent: chef_infra/cookbooks/resources
    weight: 1380
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_printer** resource to setup Windows printers. Note

    that this doesn''t currently install a printer driver. You must already

    have the driver installed on the system.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The windows_printer resource has the following syntax:\n\n```\
  \ ruby\nwindows_printer 'name' do\n  comment           String\n  default       \
  \    true, false # default value: false\n  device_id         String # default value:\
  \ 'name' unless specified\n  driver_name       String\n  ipv4_address      String\n\
  \  location          String\n  share_name        String\n  shared            true,\
  \ false # default value: false\n  action            Symbol # defaults to :create\
  \ if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_printer` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`comment`, `default`, `device_id`, `driver_name`, `ipv4_address`, `location`, `share_name`,
  and `shared` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create a new printer and printer port, if one doesn't already
      exist.
  :delete:
    markdown: Delete an existing printer. Note that this resource does not delete
      the associated printer port.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: comment
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Optional descriptor for the printer queue.
- property: default
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Determines whether or not this should be the system''s default

      printer.'
- property: device_id
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the printer queue name if it differs

      from the resource block''s name. Example: ''HP LJ 5200 in fifth floor

      copy room''.'
- property: driver_name
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The exact name of printer driver installed on the system.
- property: ipv4_address
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The IPv4 address of the printer, such as '10.4.64.23'.
- property: location
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Printer location, such as `'Fifth floor copy room'`.
- property: share_name
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The name used to identify the shared printer.
- property: shared
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Determines whether or not the printer is shared.
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
- example_heading: Create a printer
  text_blocks:
  - code_block: "windows_printer 'HP LaserJet 5th Floor' do\n  driver_name 'HP LaserJet\
      \ 4100 Series PCL6'\n  ipv4_address '10.4.64.38'\nend"
- example_heading: Delete a printer
  text_blocks:
  - markdown: 'Note: this doesn''t delete the associated printer port. See

      windows_printer_port above for how to delete the port.'
  - code_block: "windows_printer 'HP LaserJet 5th Floor' do\n  action :delete\nend"

---
