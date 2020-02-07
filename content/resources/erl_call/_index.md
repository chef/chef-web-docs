---
title: erl_call resource
resource: erl_call
draft: false
aliases: /resource_erlang_call.html
resource_reference: false
robots: noindex, nofollow
resource_description_list:
- markdown: 'Use the **erl_call** resource to connect to a node located within a

    distributed Erlang system. Commands that are executed with this resource

    are (by their nature) not idempotent, as they are typically unique to

    the environment in which they are run. Use `not_if` and `only_if` to

    guard this resource for idempotence.'
- note:
    markdown: 'The `erl_call` command needs to be on the path for this resource to
      work

      properly.'
- markdown: '**Removed from Chef Client 14.0**'
resource_new_in: null
handler_types: false
syntax_description: 'A **erl_call** resource block connects to a node located within
  a distributed Erlang system:'
syntax_code_block: "erl_call 'list names' do\n  code 'net_adm:names().'\n  distributed\
  \ true\n  node_name 'chef@latte'\nend"
syntax_properties_list: null
syntax_full_code_block: "erl_call 'name' do\n  code                       String\n\
  \  cookie                     String\n  distributed                true, false\n\
  \  name_type                  String\n  node_name                  String\n  notifies\
  \                   # see description\n  subscribes                 # see description\n\
  \  action                     Symbol # defaults to :run if not specified\nend"
syntax_full_properties_list:
- '`erl_call` is the resource'
- '`name` is the name of the resource block'
- '`action` identifies the steps Chef Infra Client will take to bring the node into
  the desired state'
- '`code`, `cookie`, `distributed`, `name_type`, and `node_name` are properties of
  this resource, with the Ruby type shown. See "Properties" section below for more
  information about all of the properties that may be used with this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :nothing:
    markdown: Prevent the Erlang call from running.
  :run:
    markdown: Default. Run the Erlang call.
properties_list:
- property: code
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The code to be executed on a node located within a distributed

      Erlang system. Default value: `q()`.'
- property: cookie
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The magic cookie for the node to which a connection is made.
- property: distributed
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: The node is a distributed Erlang node.
- property: ignore_failure
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Continue running a recipe if a resource fails for any reason.
- property: name_type
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The `node_name` property as a short node name (`sname`) or a long

      node name (`name`). A node with a long node name cannot communicate

      with a node with a short node name. Default value: `sname`.'
- property: node_name
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The hostname to which the node is to connect. Default value:

      `chef@localhost`.'
- property: notifies
  ruby_type: Symbol, Chef::Resource\[String\]
  required: false
  default_value: null
  new_in: null
  description_list:
  - shortcode: resources_common_notification_notifies.md
  - markdown: ''
  - shortcode: resources_common_notification_timers.md
  - markdown: ''
  - shortcode: resources_common_notification_notifies_syntax.md
- property: retries
  ruby_type: Integer
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: The number of attempts to catch exceptions and retry the resource.
- property: retry_delay
  ruby_type: Integer
  required: false
  default_value: '2'
  new_in: null
  description_list:
  - markdown: The retry delay (in seconds).
- property: subscribes
  ruby_type: Symbol, Chef::Resource\[String\]
  required: false
  default_value: null
  new_in: null
  description_list:
  - shortcode: resources_common_notification_subscribes.md
  - markdown: ''
  - shortcode: resources_common_notification_timers.md
  - markdown: ''
  - shortcode: resources_common_notification_subscribes_syntax.md
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
resources_common_properties: false
resources_common_notification: false
resources_common_guards: true
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Run a command
  text_blocks:
  - code_block: "erl_call 'list names' do\n  code 'net_adm:names().'\n  distributed\
      \ true\n  node_name 'chef@latte'\nend"

---
