---
title: windows_firewall_rule resource
resource: windows_firewall_rule
draft: false
aliases:
- /resource_windows_firewall_rule.html
menu:
  docs:
    title: windows_firewall_rule
    identifier: chef_infra/cookbook_reference/resources/resource_windows_firewall_rule.md
      windows_firewall_rule
    parent: chef_infra/cookbook_reference/resources
    weight: 1200
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_firewall_rule** resource to create, change or remove

    windows firewall rules.'
resource_new_in: '14.7'
handler_types: false
syntax_description: "The windows_firewall_rule resource has the following syntax:\n\
  \n``` ruby\nwindows_firewall_rule 'name' do\n  description          String # default\
  \ value: \"Firewall rule\"\n  direction            Symbol, String # default value:\
  \ :inbound\n  enabled              true, false # default value: true\n  firewall_action\
  \      Symbol, String # default value: :allow\n  interface_type       Symbol, String\
  \ # default value: :any\n  local_address        String\n  local_port           String,\
  \ Integer, Array\n  profile              Symbol, String, Array # default value:\
  \ :any\n  program              String\n  protocol             String # default value:\
  \ \"TCP\"\n  remote_address       String\n  remote_port          String, Integer,\
  \ Array\n  rule_name            String # default value: 'name' unless specified\n\
  \  service              String\n  action               Symbol # defaults to :create\
  \ if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_firewall_rule` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`description`, `direction`, `enabled`, `firewall_action`, `interface_type`, `local_address`,
  `local_port`, `profile`, `program`, `protocol`, `remote_address`, `remote_port`,
  `rule_name`, and `service` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Create a Windows firewall entry.
  :delete:
    markdown: Delete an existing Windows firewall entry.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: description
  ruby_type: String
  required: false
  default_value: '"Firewall rule"'
  new_in: null
  description_list:
  - markdown: The description to assign to the firewall rule.
- property: direction
  ruby_type: Symbol, String
  required: false
  default_value: :inbound
  new_in: null
  description_list:
  - markdown: 'The direction of the firewall rule. Direction means either inbound

      or outbound traffic.'
- property: enabled
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: Whether or not to enable the firewall rule.
- property: firewall_action
  ruby_type: Symbol, String
  required: false
  default_value: :allow
  new_in: null
  description_list:
  - markdown: The action of the firewall rule.
- property: interface_type
  ruby_type: Symbol, String
  required: false
  default_value: :any
  new_in: null
  description_list:
  - markdown: The interface type the firewall rule applies to.
- property: local_address
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The local address the firewall rule applies to.
- property: local_port
  ruby_type: String, Integer, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The local port the firewall rule applies to.
- property: profile
  ruby_type: Symbol, String, Array
  required: false
  default_value: :any
  new_in: null
  description_list:
  - markdown: The profile the firewall rule applies to.
- property: program
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The program the firewall rule applies to.
- property: protocol
  ruby_type: String
  required: false
  default_value: '"TCP"'
  new_in: null
  description_list:
  - markdown: The protocol the firewall rule applies to.
- property: remote_address
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The remote address the firewall rule applies to.
- property: remote_port
  ruby_type: String, Integer, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The remote port the firewall rule applies to.
- property: rule_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the name of the firewall rule to assign

      if it differs from the resource block''s name.'
- property: service
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The service the firewall rule applies to.
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
- example_heading: Allowing port 80 access
  text_blocks:
  - code_block: "windows_firewall_rule 'IIS' do\n  local_port '80'\n  protocol 'TCP'\n\
      \  firewall_action :allow\nend"
- example_heading: Blocking WinRM over HTTP on a particular IP
  text_blocks:
  - code_block: "windows_firewall_rule 'Disable WinRM over HTTP' do\n  local_port\
      \ '5985'\n  protocol 'TCP'\n  firewall_action :block\n  local_address '192.168.1.1'\n\
      end"
- example_heading: Deleting an existing rule
  text_blocks:
  - code_block: "windows_firewall_rule 'Remove the SSH rule' do\n  rule_name 'ssh'\n\
      \  action :delete\nend"

---
