---
title: directory resource
resource: directory
draft: false
aliases:
- /resource_directory.html
menu:
  docs:
    title: directory
    identifier: chef_infra/cookbook_reference/resources/resource_directory.md directory
    parent: chef_infra/cookbook_reference/resources
    weight: 290
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **directory** resource to manage a directory, which is a

    hierarchy of folders that comprises all of the information stored on a

    computer. The root directory is the top-level, under which the rest of

    the directory is organized. The **directory** resource uses the `name`

    property to specify the path to a location in a directory. Typically,

    permission to access that location in the directory is required.'
resource_new_in: null
handler_types: false
syntax_description: "A **directory** resource block declares a directory and the permissions\n\
  needed on that directory. For example:\n\n``` ruby\ndirectory '/etc/apache2' do\n\
  \  owner 'root'\n  group 'root'\n  mode '0755'\n  action :create\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`''/etc/apache2''` specifies the directory'
- '`owner`, `group`, and `mode` define the permissions'
syntax_full_code_block: "directory 'name' do\n  group                      String,\
  \ Integer\n  inherits                   true, false\n  mode                    \
  \   String, Integer\n  owner                      String, Integer\n  path      \
  \                 String # defaults to 'name' if not specified\n  recursive    \
  \              true, false\n  rights                     Hash\n  action        \
  \             Symbol # defaults to :create if not specified\nend"
syntax_full_properties_list:
- '`directory` is the resource.'
- '`name` is the name of the resource block; when the `path` property is not specified,
  `name` is also the path to the directory, from the root'
- '`action` identifies the steps Chef Infra Client will take to bring the node into
  the desired state'
- '`group`, `inherits`, `mode`, `owner`, `path`, `recursive`, and `rights` are properties
  of this resource, with the Ruby type shown. See "Properties" section below for more
  information about all of the properties that may be used with this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create a directory. If a directory already exists (but does
      not match), update that directory to match.
  :delete:
    markdown: Delete a directory.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: group
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A string or ID that identifies the group owner by group name,

      including fully qualified group names such as `domain\group` or

      `group@domain`. If this value is not specified, existing groups

      remain unchanged and new group assignments use the default `POSIX`

      group (if available).'
- property: inherits
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Microsoft Windows only. Whether a file inherits rights from its

      parent directory.'
- property: mode
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A quoted 3-5 character string that defines the octal mode. For

      example: `''755''`, `''0755''`, or `00755`. If `mode` is not specified

      and if the directory already exists, the existing mode on the

      directory is used. If `mode` is not specified, the directory does

      not exist, and the `:create` action is specified, Chef Infra Client

      assumes a mask value of `''0777''`, and then applies the umask for the

      system on which the directory is to be created to the `mask` value.

      For example, if the umask on a system is `''022''`, Chef Infra Client

      uses the default value of `''0755''`.


      The behavior is different depending on the platform.


      UNIX- and Linux-based systems: A quoted 3-5 character string that

      defines the octal mode that is passed to chmod. For example:

      `''755''`, `''0755''`, or `00755`. If the value is specified as a quoted

      string, it works exactly as if the `chmod` command was passed. If

      the value is specified as an integer, prepend a zero (`0`) to the

      value to ensure that it is interpreted as an octal number. For

      example, to assign read, write, and execute rights for all users,

      use `''0777''` or `''777''`; for the same rights, plus the sticky bit,

      use `01777` or `''1777''`.


      Microsoft Windows: A quoted 3-5 character string that defines the

      octal mode that is translated into rights for Microsoft Windows

      security. For example: `''755''`, `''0755''`, or `00755`. Values up to

      `''0777''` are allowed (no sticky bits) and mean the same in Microsoft

      Windows as they do in UNIX, where `4` equals `GENERIC_READ`, `2`

      equals `GENERIC_WRITE`, and `1` equals `GENERIC_EXECUTE`. This

      property cannot be used to set `:full_control`. This property has no

      effect if not specified, but when it and `rights` are both

      specified, the effects are cumulative.'
- property: owner
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A string or ID that identifies the group owner by user name,

      including fully qualified user names such as `domain\user` or

      `user@domain`. If this value is not specified, existing owners

      remain unchanged and new owner assignments use the current user

      (when necessary).'
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The path to the directory. Using a fully qualified path is

      recommended, but is not always required. Default value: the `name`

      of the resource block. See "Syntax" section above for more

      information.'
- property: recursive
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Create parent directories recursively and delete directories,

      subdirectories, and files recursively. The `owner`, `group`, and

      `mode` properties apply only to the leaf directory.'
- property: rights
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Microsoft Windows only. The permissions for users and groups in a

      Microsoft Windows environment. For example:

      `rights <permissions>, <principal>, <options>` where `<permissions>`

      specifies the rights granted to the principal, `<principal>` is the

      group or user name, and `<options>` is a Hash with one (or more)

      advanced rights options.'
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: true
resources_common_atomic_update: false
properties_resources_common_windows_security: true
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
- example_heading: Create a directory
  text_blocks:
  - code_block: "directory '/tmp/something' do\n  owner 'root'\n  group 'root'\n \
      \ mode '0755'\n  action :create\nend"
- example_heading: Create a directory in Microsoft Windows
  text_blocks:
  - code_block: "directory \"C:\\\\tmp\\\\something\" do\n  rights :full_control,\
      \ \"DOMAIN\\\\User\"\n  inherits false\n  action :create\nend"
  - markdown: 'or:'
  - code_block: "directory 'C:\\tmp\\something' do\n  rights :full_control, 'DOMAIN\\\
      User'\n  inherits false\n  action :create\nend"
  - note: 'The difference between the two previous examples is the single- versus

      double-quoted strings, where if the double quotes are used, the

      backslash character (`\`) must be escaped using the Ruby escape

      character (which is a backslash).'
- example_heading: Create a directory recursively
  text_blocks:
  - code_block: "%w{dir1 dir2 dir3}.each do |dir|\n  directory \"/tmp/mydirs/#{dir}\"\
      \ do\n    mode '0755'\n    owner 'root'\n    group 'root'\n    action :create\n\
      \    recursive true\n  end\nend"
- example_heading: Delete a directory
  text_blocks:
  - code_block: "directory '/tmp/something' do\n  recursive true\n  action :delete\n\
      end"
- example_heading: Set directory permissions using a variable
  text_blocks:
  - markdown: 'The following example shows how read/write/execute permissions can
      be

      set using a variable named `user_home`, and then for owners and groups

      on any matching node:'
  - code_block: "user_home = \"/#{node[:matching_node][:user]}\"\n\ndirectory user_home\
      \ do\n  owner 'node[:matching_node][:user]'\n  group 'node[:matching_node][:group]'\n\
      \  mode '0755'\n  action :create\nend"
  - markdown: 'where `matching_node` represents a type of node. For example, if the

      `user_home` variable specified `{node[:nginx]...}`, a recipe might look

      similar to:'
  - code_block: "user_home = \"/#{node[:nginx][:user]}\"\n\ndirectory user_home do\n\
      \  owner 'node[:nginx][:user]'\n  group 'node[:nginx][:group]'\n  mode '0755'\n\
      \  action :create\nend"
- example_heading: Set directory permissions for a specific type of node
  text_blocks:
  - markdown: 'The following example shows how permissions can be set for the

      `/certificates` directory on any node that is running Nginx. In this

      example, permissions are being set for the `owner` and `group`

      properties as `root`, and then read/write permissions are granted to the

      root.'
  - code_block: "directory \"#{node[:nginx][:dir]}/shared/certificates\" do\n  owner\
      \ 'root'\n  group 'root'\n  mode '0755'\n  recursive true\nend"
- example_heading: Reload the configuration
  text_blocks:
  - shortcode: resource_ruby_block_reload_configuration.md
- example_heading: Manage dotfiles
  text_blocks:
  - shortcode: resource_directory_manage_dotfiles.md

---
