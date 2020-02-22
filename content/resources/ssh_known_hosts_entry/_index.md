---
title: ssh_known_hosts_entry resource
resource: ssh_known_hosts_entry
draft: false
aliases:
- /resource_ssh_known_hosts_entry.html
menu:
  docs:
    title: ssh_known_hosts_entry
    identifier: chef_infra/cookbook_reference/resources/ssh_known_hosts_entry ssh_known_hosts_entry
    parent: chef_infra/cookbook_reference/resources
    weight: 990
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **ssh_known_hosts_entry** resource to add an entry for the

    specified host in /etc/ssh/ssh_known_hosts or a user''s known hosts

    file if specified.'
resource_new_in: '14.3'
handler_types: false
syntax_description: "The ssh_known_hosts_entry resource has the following syntax:\n\
  \n``` ruby\nssh_known_hosts_entry 'name' do\n  file_location      String # default\
  \ value: \"/etc/ssh/ssh_known_hosts\"\n  group              String, Integer\n  hash_entries\
  \       true, false # default value: false\n  host               String # default\
  \ value: 'name' unless specified\n  key                String\n  key_type      \
  \     String # default value: \"rsa\"\n  mode               String # default value:\
  \ \"0644\"\n  owner              String, Integer # default value: \"root\"\n  port\
  \               Integer # default value: 22\n  timeout            Integer # default\
  \ value: 30\n  action             Symbol # defaults to :create if not specified\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`ssh_known_hosts_entry` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`file_location`, `group`, `hash_entries`, `host`, `key`, `key_type`, `mode`, `owner`,
  `port`, and `timeout` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create an entry in the ssh_known_hosts file.
  :flush:
    markdown: Immediately flush the entries to the config file. Without this the actual
      writing of the file is delayed in the Chef run so all entries can be accumulated
      before writing the file out.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: file_location
  ruby_type: String
  required: false
  default_value: '"/etc/ssh/ssh_known_hosts"'
  new_in: null
  description_list:
  - markdown: 'The location of the ssh known hosts file. Change this to set a known

      host file for a particular user.'
- property: group
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The file group for the ssh_known_hosts file.
- property: hash_entries
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Hash the hostname and addresses in the ssh_known_hosts file for

      privacy.'
- property: host
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: The host to add to the known hosts file.
- property: key
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An optional key for the host. If not provided this will be

      automatically determined.'
- property: key_type
  ruby_type: String
  required: false
  default_value: '"rsa"'
  new_in: null
  description_list:
  - markdown: The type of key to store.
- property: mode
  ruby_type: String
  required: false
  default_value: '"0644"'
  new_in: null
  description_list:
  - markdown: The file mode for the ssh_known_hosts file.
- property: owner
  ruby_type: String, Integer
  required: false
  default_value: '"root"'
  new_in: null
  description_list:
  - markdown: The file owner for the ssh_known_hosts file.
- property: port
  ruby_type: Integer
  required: false
  default_value: '22'
  new_in: null
  description_list:
  - markdown: 'The server port that the ssh-keyscan command will use to gather the

      public key.'
- property: timeout
  ruby_type: Integer
  required: false
  default_value: '30'
  new_in: null
  description_list:
  - markdown: The timeout in seconds for ssh-keyscan.
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
- example_heading: Add a single entry for github.com with the key auto detected
  text_blocks:
  - code_block: ssh_known_hosts_entry 'github.com'
- example_heading: Add a single entry with your own provided key
  text_blocks:
  - code_block: "ssh_known_hosts_entry 'github.com' do\n  key 'node.example.com ssh-rsa\
      \ ...'\nend"

---
