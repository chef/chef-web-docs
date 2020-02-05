---
title: cookbook_file resource
resource: cookbook_file
draft: false
aliases: /resource_cookbook_file.html
menu:
  docs:
    title: cookbook_file
    identifier: chef_infra/cookbook_reference/resources/resource_cookbook_file.md
      cookbook_file
    parent: chef_infra/cookbook_reference/resources
    weight: 240
resource_reference: true
robots: null
resource_description_list:
- shortcode: resource_cookbook_file_summary.md
- markdown: 'During a Chef Infra Client run, the checksum for each local file is

    calculated and then compared against the checksum for the same file as

    it currently exists in the cookbook on the Chef Infra Server. A file is

    not transferred when the checksums match. Only files that require an

    update are transferred from the Chef Infra Server to a node.'
resource_new_in: null
handler_types: false
syntax_description: 'A **cookbook_file** resource block manages files by using files
  that exist within a cookbook''s `/files` directory. For example, to write the home
  page for an Apache website:'
syntax_code_block: "cookbook_file '/var/www/customers/public_html/index.php' do\n\
  \  source 'index.php'\n  owner 'web_admin'\n  group 'web_admin'\n  mode '0755'\n\
  \  action :create\nend"
syntax_properties_list:
- '`''/var/www/customers/public_html/index.php''` is path to the file to be created'
- '`''index.php''` is a file in the `/files` directory in a cookbook that is used
  to create that file (the contents of the file in the cookbook will become the contents
  of the file on the node)'
- '`owner`, `group`, and `mode` define the permissions'
syntax_full_code_block: "cookbook_file 'name' do\n  atomic_update              true,\
  \ false\n  backup                     Integer, false # default value: 5\n  cookbook\
  \                   String\n  force_unlink               true, false # default value:\
  \ false\n  group                      String, Integer\n  inherits              \
  \     true, false\n  manage_symlink_source      true, false\n  mode            \
  \           String, Integer\n  owner                      String, Integer\n  path\
  \                       String # default value: 'name' unless specified\n  rights\
  \                     Hash\n  source                     String, Array\n  verify\
  \                     String, Block\n  action                     Symbol # defaults\
  \ to :create if not specified\nend"
syntax_full_properties_list:
- '`cookbook_file` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`atomic_update`, `backup`, `cookbook`, `force_unlink`, `group`, `inherits`, `manage_symlink_source`,
  `mode`, `owner`, `path`, `rights`, `source`, and `verify` are properties of this
  resource, with the Ruby type shown. See "Properties" section below for more information
  about all of the properties that may be used with this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create a file. If a file already exists (but does not match),
      update that file to match.
  :create_if_missing:
    markdown: Create a file only if the file does not exist. When the file exists,
      nothing happens.
  :delete:
    markdown: Delete a file.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :touch:
    markdown: Touch a file. This updates the access (atime) and file modification
      (mtime) times for a file. (This action may be used with this resource, but is
      typically only used with the **file** resource.)
properties_list:
- property: atomic_update
  ruby_type: true, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Perform atomic file updates on a per-resource basis. Set to `true`

      for atomic file updates. Set to `false` for non-atomic file updates.

      This setting overrides `file_atomic_update`, which is a global

      setting found in the client.rb file.'
- property: backup
  ruby_type: Integer, false
  required: false
  default_value: '5'
  new_in: null
  description_list:
  - markdown: 'The number of backups to be kept in `/var/chef/backup` (for UNIX-

      and Linux-based platforms) or `C:/chef/backup` (for the Microsoft

      Windows platform). Set to `false` to prevent backups from being

      kept.'
- property: cookbook
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The cookbook in which a file is located (if it is not located in the

      current cookbook). The default value is the current cookbook.'
- property: force_unlink
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'How Chef Infra Client handles certain situations when the target

      file turns out not to be a file. For example, when a target file is

      actually a symlink. Set to `true` for Chef Infra Client delete the

      non-file target and replace it with the specified file. Set to

      `false` for Chef Infra Client to raise an error.'
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
- property: manage_symlink_source
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: '(with

      warning)


      Change the behavior of the file resource if it is pointed at a

      symlink. When this value is set to `true`, Chef Infra Client will

      manage the symlink''s permissions or will replace the symlink with a

      normal file if the resource has content. When this value is set to

      `false`, Chef will follow the symlink and will manage the

      permissions and content of the symlink''s target file.


      The default behavior is `true` but emits a warning that the default

      value will be changed to `false` in a future version; setting this

      explicitly to `true` or `false` suppresses this warning.'
- property: mode
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'If `mode` is not specified and if the file already exists, the

      existing mode on the file is used. If `mode` is not specified, the

      file does not exist, and the `:create` action is specified, Chef

      Infra Client assumes a mask value of `''0777''` and then applies the

      umask for the system on which the file is to be created to the

      `mask` value. For example, if the umask on a system is `''022''`, Chef

      Infra Client uses the default value of `''0755''`.


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
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The path to the destination at which a file is to be created.

      Default value: the `name` of the resource block For example:

      `file.txt`.


      Microsoft Windows: A path that begins with a forward slash (`/`)

      will point to the root of the current working directory of Chef

      Infra Client process. This path can vary from system to system.

      Therefore, using a path that begins with a forward slash (`/`) is

      not recommended.'
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
- property: source
  ruby_type: String, Array
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'The name of the file in `COOKBOOK_NAME/files/default` or the path to

      a file located in `COOKBOOK_NAME/files`. The path must include the

      file name and its extension. This can be used to distribute specific

      files depending upon the platform used - see [File

      Specificity](#file-specificity) for more information.'
- property: verify
  ruby_type: String, Block
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "A block or a string that returns `true` or `false`. A string, when\n\
      `true` is executed as a system command.\n\nA block is arbitrary Ruby defined\
      \ within the resource block by using\nthe `verify` property. When a block is\
      \ `true`, Chef Infra Client\nwill continue to update the file as appropriate.\n\
      \nFor example, this should return `true`:\n\n``` ruby\ncookbook_file '/tmp/baz'\
      \ do\n  verify { 1 == 1 }\nend\n```\n\nThis should return `true`:\n\n``` ruby\n\
      cookbook_file '/etc/nginx.conf' do\n  verify 'nginx -t -c %{path}'\nend\n```"
  - warning:
    - markdown: "\n\nFor releases of Chef Infra Client prior to 12.5 (chef-client\
        \ 12.4\nand earlier) the correct syntax is:\n\n``` ruby\ncookbook_file '/etc/nginx.conf'\
        \ do\n  verify 'nginx -t -c %{file}'\nend\n```\n\nSee GitHub issues <https://github.com/chef/chef/issues/3232>\
        \ and\n<https://github.com/chef/chef/pull/3693> for more information about\n\
        these differences.\n\n"
  - markdown: "This should return `true`:\n\n``` ruby\ncookbook_file '/tmp/bar' do\n\
      \  verify { 1 == 1}\nend\n```\n\nAnd this should return `true`:\n\n``` ruby\n\
      cookbook_file '/tmp/foo' do\n  verify do |path|\n    true\n  end\nend\n```\n\
      \nWhereas, this should return `false`:\n\n``` ruby\ncookbook_file '/tmp/turtle'\
      \ do\n  verify '/usr/bin/false'\nend\n```\n\nIf a string or a block return `false`,\
      \ the Chef Infra Client run\nwill stop and an error is returned."
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: true
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: true
unit_file_verification: false
examples_list:
- example_heading: Transfer a file
  text_blocks:
  - code_block: "cookbook_file 'file.txt' do\n  mode '0755'\nend"
- example_heading: Handle cookbook_file and package resources in the same recipe
  text_blocks:
  - markdown: 'When a **cookbook_file** resource and a **package** resource are both

      called from within the same recipe, use the `flush_cache` attribute to

      dump the in-memory Yum cache, and then use the repository immediately to

      ensure that the correct package is installed:'
  - code_block: "cookbook_file '/etc/yum.repos.d/custom.repo' do\n  source 'custom'\n\
      \  mode '0755'\nend\n\npackage 'only-in-custom-repo' do\n  action :install\n\
      \  flush_cache [ :before ]\nend"
- example_heading: 'Install repositories from a file, trigger a command, and force
    the

    internal cache to reload'
  text_blocks:
  - shortcode: resource_package_install_yum_repo_from_file.md
- example_heading: Use a case statement
  text_blocks:
  - markdown: 'The following example shows how a case statement can be used to handle
      a

      situation where an application needs to be installed on multiple

      platforms, but where the install directories are different paths,

      depending on the platform:'
  - code_block: "cookbook_file 'application.pm' do\n  path case node['platform']\n\
      \    when 'centos','redhat'\n      '/usr/lib/version/1.2.3/dir/application.pm'\n\
      \    when 'arch'\n      '/usr/share/version/core_version/dir/application.pm'\n\
      \    else\n      '/etc/version/dir/application.pm'\n    end\n  source \"application-#{node['languages']['perl']['version']}.pm\"\
      \n  owner 'root'\n  group 'root'\n  mode '0755'\nend"
- example_heading: Manage dotfiles
  text_blocks:
  - shortcode: resource_directory_manage_dotfiles.md

---
