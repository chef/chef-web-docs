---
title: sysctl resource
resource: sysctl
draft: false
aliases: /resource_sysctl.html
menu:
  docs:
    title: sysctl
    identifier: chef_infra/cookbook_reference/resources/resource_sysctl.md sysctl
    parent: chef_infra/cookbook_reference/resources
    weight: 1030
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **sysctl** resource to set or remove kernel parameters using
    the

    `sysctl` command line tool and configuration files in the system''s

    `sysctl.d` directory. Configuration files managed by this resource are

    named `99-chef-KEYNAME.conf`. If an existing value was already set, it

    will be backed up to the node and restored if the `:remove` action is

    used later.'
resource_new_in: '14.0'
handler_types: false
syntax_description: 'The sysctl resource has the following syntax:'
syntax_code_block: "sysctl 'name' do\n  conf_dir          String # default value:\
  \ \"/etc/sysctl.d\"\n  ignore_error      true, false # default value: false\n  key\
  \               String # default value: 'name' unless specified\n  value       \
  \      Array, String, Integer, Float\n  action            Symbol # defaults to :apply\
  \ if not specified\nend"
syntax_properties_list:
- '`sysctl` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`conf_dir`, `ignore_error`, `key`, and `value` are the properties available to
  this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :apply:
    markdown: Default. Set the kernel parameter and update the `sysctl` settings.
  :remove:
    markdown: Remove the kernel parameter and update the `sysctl` settings.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: conf_dir
  ruby_type: String
  required: false
  default_value: '"/etc/sysctl.d"'
  new_in: null
  description_list:
  - markdown: The configuration directory to write the config to.
- property: ignore_error
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Ignore any errors when setting the value on the command line.
- property: key
  ruby_type: String
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'The kernel parameter key in dotted format if it differs from the

      resource block''s name.'
- property: value
  ruby_type: Array, String, Integer, Float
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The value to set.
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
- example_heading: Set vm.swappiness
  text_blocks:
  - code_block: "sysctl 'vm.swappiness' do\n  value 19\nend"
- example_heading: Remove kernel.msgmax
  text_blocks:
  - markdown: 'Note: This only removes the sysctl.d config for kernel.msgmax. The
      value

      will be set back to the kernel default value.'
  - code_block: "sysctl 'kernel.msgmax' do\n  action :remove\nend"
- example_heading: Converting sysctl settings from shell scripts
  text_blocks:
  - markdown: 'Example of existing settings:


      `fs.aio-max-nr = 1048576` `net.ipv4.ip_local_port_range = 9000 65500`

      `kernel.sem = 250 32000 100 128`


      Converted to sysctl resources:'
  - code_block: "sysctl 'fs.aio-max-nr' do\n  value '1048576'\nend\n\nsysctl 'net.ipv4.ip_local_port_range'\
      \ do\n  value '9000 65500'\nend\n\nsysctl 'kernel.sem' do\n  value '250 32000\
      \ 100 128'\nend"

---
