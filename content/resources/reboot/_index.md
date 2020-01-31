---
title: reboot resource
resource: reboot
draft: false
aliases: /resource_reboot.html
menu:
  docs:
    title: reboot
    identifier: chef_infra/cookbook_reference/resources/resource_reboot.md reboot
    parent: chef_infra/cookbook_reference/resources
    weight: 800
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **reboot** resource to reboot a node, a necessary step with some

    installations on certain platforms. This resource is supported for use

    on the Microsoft Windows, macOS, and Linux platforms.'
resource_new_in: null
handler_types: false
syntax_description: 'The reboot resource has the following syntax:'
syntax_code_block: "reboot 'name' do\n  delay_mins      Integer # default value: 0\n\
  \  reason          String # default value: \"Reboot by Chef Infra Client\"\n  action\
  \          Symbol # defaults to :nothing if not specified\nend"
syntax_properties_list:
- '`reboot` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`delay_mins` and `reason` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :cancel:
    markdown: Cancel a reboot request.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :reboot_now:
    markdown: Reboot a node so that Chef Infra Client may continue the installation
      process.
  :request_reboot:
    markdown: Reboot a node at the end of a Chef Infra Client run.
properties_list:
- property: delay_mins
  ruby_type: Integer
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: The amount of time (in minutes) to delay a reboot request.
- property: reason
  ruby_type: String
  required: false
  default_value: '"Reboot by Chef Infra Client"'
  new_in: null
  description_list:
  - markdown: A string that describes the reboot action.
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Reboot a node immediately
  text_blocks:
  - code_block: "reboot 'now' do\n  action :nothing\n  reason 'Cannot continue Chef\
      \ run without a reboot.'\n  delay_mins 2\nend\n\nexecute 'foo' do\n  command\
      \ '...'\n  notifies :reboot_now, 'reboot[now]', :immediately\nend"
- example_heading: Reboot a node at the end of a Chef Infra Client run
  text_blocks:
  - code_block: "reboot 'app_requires_reboot' do\n  action :request_reboot\n  reason\
      \ 'Need to reboot when the run completes successfully.'\n  delay_mins 5\nend"
- example_heading: Cancel a reboot
  text_blocks:
  - code_block: "reboot 'cancel_reboot_request' do\n  action :cancel\n  reason 'Cancel\
      \ a previous end-of-run reboot request.'\nend"
- example_heading: Rename computer, join domain, reboot
  text_blocks:
  - shortcode: resource_powershell_rename_join_reboot.md

---
