---
title: route resource
resource: route
draft: false
aliases:
- /resource_route.html
menu:
  docs:
    title: route
    identifier: chef_infra/cookbook_reference/resources/resource_route.md route
    parent: chef_infra/cookbook_reference/resources
    weight: 900
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **route** resource to manage the system routing table in a Linux

    environment.'
resource_new_in: null
handler_types: false
syntax_description: "A **route** resource block manages the system routing table in\
  \ a Linux\nenvironment:\n\n``` ruby\nroute '10.0.1.10/32' do\n  gateway '10.0.0.20'\n\
  \  device 'eth1'\nend\n```"
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "route 'name' do\n  comment         String\n  device     \
  \     String\n  gateway         String\n  metric          Integer\n  netmask   \
  \      String\n  route_type      Symbol, String # default value: :host\n  target\
  \          String # default value: 'name' unless specified\n  action          Symbol\
  \ # defaults to :add if not specified\nend"
syntax_full_properties_list:
- '`route` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`comment`, `device`, `gateway`, `metric`, `netmask`, `route_type`, and `target`
  are the properties available to this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :add:
    markdown: Default. Add a route.
  :delete:
    markdown: Delete a route.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: comment
  ruby_type: String
  required: false
  default_value: null
  new_in: '14.0'
  description_list:
  - markdown: Add a comment for the route.
- property: device
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The network interface to which the route applies.
- property: gateway
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The gateway for the route.
- property: metric
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The route metric value.
- property: netmask
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The decimal representation of the network mask. For example:

      `255.255.255.0`.'
- property: route_type
  ruby_type: Symbol, String
  required: false
  default_value: :host
  new_in: null
  description_list: []
- property: target
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: The IP address of the target route.
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
- example_heading: Add a host route
  text_blocks:
  - code_block: "route '10.0.1.10/32' do\n  gateway '10.0.0.20'\n  device 'eth1'\n\
      end"
- example_heading: Add a default route
  text_blocks:
  - code_block: "route 'default' do\n  gateway '10.0.0.20'\nend"
- example_heading: Delete a network route
  text_blocks:
  - code_block: "route '10.1.1.0/24' do\n  gateway '10.0.0.20'\n  action :delete\n\
      end"

---
