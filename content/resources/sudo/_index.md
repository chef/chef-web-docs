---
title: sudo resource
resource: sudo
draft: false
aliases:
- /resource_sudo.html
menu:
  docs:
    title: sudo
    identifier: chef_infra/cookbook_reference/resources/sudo sudo
    parent: chef_infra/cookbook_reference/resources
    weight: 1140
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **sudo** resource to add or remove individual sudo entries using

    `sudoers.d` files. Sudo version 1.7.2 or newer is required to use the

    sudo resource, as it relies on the `#includedir` directive introduced in

    version 1.7.2. This resource does not enforce installation of the

    required sudo version. Chef-supported releases of Ubuntu, SuSE, Debian,

    and RHEL (6+) all support this feature.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The sudo resource has the following syntax:\n\n``` ruby\nsudo\
  \ 'name' do\n  command_aliases        Array\n  commands               Array # default\
  \ value: [\"ALL\"]\n  config_prefix          String # default value: Prefix values\
  \ based on the node's platform\n  defaults               Array\n  env_keep_add \
  \          Array\n  env_keep_subtract      Array\n  filename               String\
  \ # default value: 'name' unless specified\n  groups                 String, Array\n\
  \  host                   String # default value: \"ALL\"\n  noexec            \
  \     true, false # default value: false\n  nopasswd               true, false #\
  \ default value: false\n  runas                  String # default value: \"ALL\"\
  \n  setenv                 true, false # default value: false\n  template      \
  \         String\n  users                  String, Array\n  variables          \
  \    Hash\n  visudo_binary          String # default value: \"/usr/sbin/visudo\"\
  \n  visudo_path            String\n  action                 Symbol # defaults to\
  \ :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`sudo` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`command_aliases`, `commands`, `config_prefix`, `defaults`, `env_keep_add`, `env_keep_subtract`,
  `filename`, `groups`, `host`, `noexec`, `nopasswd`, `runas`, `setenv`, `template`,
  `users`, `variables`, `visudo_binary`, and `visudo_path` are the properties available
  to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create a single sudoers configuration file in the `sudoers.d`
      directory.
  :delete:
    markdown: Removed a sudoers configuration file from the `sudoers.d` directory.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: command_aliases
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Command aliases that can be used as allowed commands later in the

      configuration.'
- property: commands
  ruby_type: Array
  required: false
  default_value: '["ALL"]'
  new_in: null
  description_list:
  - markdown: An array of commands this sudoer can execute.
- property: config_prefix
  ruby_type: String
  required: false
  default_value: Prefix values based on the node's platform
  new_in: null
  description_list:
  - markdown: The directory that contains the sudoers configuration file.
- property: defaults
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: An array of defaults for the user/group.
- property: env_keep_add
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: An array of strings to add to `env_keep`.
- property: env_keep_subtract
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: An array of strings to remove from `env_keep`.
- property: filename
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The name of the sudoers.d file if it differs from the name of the

      resource block'
- property: groups
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Group(s) to provide sudo privileges to. This property accepts either

      an array or a comma-separated list. Leading % on group names is

      optional.'
- property: host
  ruby_type: String
  required: false
  default_value: '"ALL"'
  new_in: null
  description_list:
  - markdown: The host to set in the sudo configuration.
- property: noexec
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Prevent commands from shelling out.
- property: nopasswd
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Allow sudo to be run without specifying a password.
- property: runas
  ruby_type: String
  required: false
  default_value: '"ALL"'
  new_in: null
  description_list:
  - markdown: User that the command(s) can be run as.
- property: setenv
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Determines whether or not to permit preservation of the environment

      with `sudo -E`.'
- property: template
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The name of the `.erb` template in your cookbook, if you wish to

      supply your own template.'
- property: users
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'User(s) to provide sudo privileges to. This property accepts either

      an array or a comma-separated list.'
- property: variables
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The variables to pass to the custom template. This property is

      ignored if not using a custom template.'
- property: visudo_binary
  ruby_type: String
  required: false
  default_value: /usr/sbin/visudo
  new_in: null
  description_list:
  - markdown: The path to `visudo` for configuration verification.
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
- example_heading: Grant a user sudo privileges for any command
  text_blocks:
  - code_block: "sudo 'admin' do\n  user 'admin'\nend"
- example_heading: Grant a user and groups sudo privileges for any command
  text_blocks:
  - code_block: "sudo 'admins' do\n  users 'bob'\n  groups 'sysadmins, superusers'\n\
      end"
- example_heading: Grant passwordless sudo privileges for specific commands
  text_blocks:
  - code_block: "sudo 'passwordless-access' do\n  commands ['systemctl restart httpd',\
      \ 'systemctl restart mysql']\n  nopasswd true\nend"

---
