---
title: remote_file resource
resource: remote_file
draft: false
aliases:
- /resource_remote_file.html
menu:
  infra:
    title: remote_file
    identifier: chef_infra/cookbook_reference/resources/remote_file remote_file
    parent: chef_infra/cookbook_reference/resources
    weight: 970
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **remote_file** resource to transfer a file from a remote

    location using file specificity. This resource is similar to the

    **file** resource.'
- note:
    markdown: 'Fetching files from the `files/` directory in a cookbook should be
      done

      with the **cookbook_file** resource.'
resource_new_in: null
handler_types: false
syntax_description: "A **remote_file** resource block manages files by using files\
  \ that\nexist remotely. For example, to write the home page for an Apache\nwebsite:\n\
  \n``` ruby\nremote_file '/var/www/customers/public_html/index.html' do\n  source\
  \ 'http://somesite.com/index.html'\n  owner 'web_admin'\n  group 'web_admin'\n \
  \ mode '0755'\n  action :create\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`''/var/www/customers/public_html/index.html''` is path to the file to be created'
- '`''http://somesite.com/index.html''` specifies the location of the remote file,
  the file is downloaded from there'
- '`owner`, `group`, and `mode` define the permissions'
syntax_full_code_block: "remote_file 'name' do\n  atomic_update              true,\
  \ false\n  authentication             # default value: remote\n  backup        \
  \             Integer, false # default value: 5\n  checksum                   String\n\
  \  content                    String, nil\n  diff                       String,\
  \ nil\n  force_unlink               true, false # default value: false\n  ftp_active_mode\
  \            true, false # default value: false\n  group                      String,\
  \ Integer\n  headers                    Hash\n  inherits                   true,\
  \ false\n  manage_symlink_source      true, false\n  mode                      \
  \ String, Integer\n  notifies                   # see description\n  owner     \
  \                 String, Integer\n  path                       String # defaults\
  \ to 'name' if not specified\n  rights                     Hash\n  source      \
  \               String, Array\n  subscribes                 # see description\n\
  \  use_conditional_get        true, false\n  verify                     String,\
  \ Block\n  remote_domain              String\n  remote_password            String\n\
  \  remote_user                String\n  show_progress              true, false #\
  \ default value: false\n  use_etag                   true, false # default value:\
  \ true\n  use_last_modified          true, false # default value: true\n  sensitive\
  \                  true, false # default value: false\n  verifications         \
  \     Array\n  action                     Symbol # defaults to :create if not specified\n\
  end"
syntax_full_properties_list:
- '`remote_file` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`atomic_update`, `authentication`, `backup`, `checksum`, `content`, `diff`, `force_unlink`,
  `ftp_active_mode`, `group`, `headers`, `manage_symlink_source`, `mode`, `owner`,
  `path`, `remote_domain`, `remote_password`, `remote_user`, `show_progress`, `use_etag`,
  `use_last_modified`, `sensitive`, and `verifications` are the properties available
  to this resource.'
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
- property: checksum
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Optional, see `use_conditional_get`. The SHA-256 checksum of the

      file. Use to prevent a file from being re-downloaded. When the local

      file matches the checksum, Chef Infra Client does not download it.'
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
- property: ftp_active_mode
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Whether Chef Infra Client uses active or passive FTP. Set to `true`

      to use active FTP.'
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
- property: headers
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A Hash of custom headers. For example:


      ``` ruby

      headers({ "Cookie" => "user=grantmc; pass=p@ssw0rd!" })

      ```


      or:


      ``` ruby

      headers({ "Referer" => "#{header}" })

      ```


      or:


      ``` ruby

      headers( "Authorization"=>"Basic #{ Base64.encode64("#{username}:#{password}").gsub("\n",
      "") }" )

      ```'
- property: ignore_failure
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Continue running a recipe if a resource fails for any reason.
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

      symlink. When this value is set to `true`, the Chef client will

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
  - markdown: 'A quoted 3-5 character string that defines the octal mode. For

      example: `''755''`, `''0755''`, or `00755`. If `mode` is not specified

      and if the file already exists, the existing mode on the file is

      used. If `mode` is not specified, the file does not exist, and the

      `:create` action is specified, Chef Infra Client assumes a mask

      value of `''0777''` and then applies the umask for the system on which

      the file is to be created to the `mask` value. For example, if the

      umask on a system is `''022''`, Chef Infra Client uses the default

      value of `''0755''`.


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
  - markdown: 'The full path to the file, including the file name and its

      extension. Default value: the `name` of the resource block. See

      "Syntax" section above for more information.'
- property: remote_user
  ruby_type: String
  required: false
  default_value: null
  new_in: '13.4'
  description_list:
  - markdown: '**Windows only** The name of a user with access to the remote file

      specified by the `source` property. The user name may optionally be

      specified with a domain, such as: `domain\user` or

      `user@my.dns.domain.com` via Universal Principal Name (UPN) format.

      The domain may also be set using the `remote_domain` property. Note

      that this property is ignored if `source` is not a UNC path. If this

      property is specified, the `remote_password` property is required.'
- property: remote_password
  ruby_type: String
  required: false
  default_value: null
  new_in: '13.4'
  description_list:
  - markdown: '**Windows only** The password of the user specified by the

      `remote_user` property. This property is required if <span

      class="title-ref">remote_user</span> is specified and may only be

      specified if `remote_user` is specified. The `sensitive` property

      for this resource will automatically be set to `true` if

      `remote_password` is specified.'
- property: remote_domain
  ruby_type: String
  required: false
  default_value: null
  new_in: '13.4'
  description_list:
  - markdown: '**Windows only** The domain of the user specified by the

      `remote_user` property. By default the resource will authenticate

      against the domain of the remote system, or as a local account if

      the remote system is not joined to a domain. If the remote system is

      not part of a domain, it is necessary to authenticate as a local

      user on the remote system by setting the domain to `.`, for example:

      `remote_domain "."`. The domain may also be specified as part of the

      `remote_user` property.'
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
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Required. The location of the source file. The location of the

      source file may be HTTP (`http://`), FTP (`ftp://`), SFTP

      (`sftp://`), local (`file:///`), or UNC

      (`\\host\share\file.tar.gz`).


      There are many ways to define the location of a source file. By

      using a path:


      ``` ruby

      source ''http://couchdb.apache.org/img/sketch.png''

      ```


      By using FTP:


      ``` ruby

      source ''ftp://remote_host/path/to/img/sketch.png''

      ```


      By using SFTP:


      ``` ruby

      source ''sftp://username:password@remote_host:22/path/to/img/sketch.png''

      ```


      By using a local path:


      ``` ruby

      source ''file:///path/to/img/sketch.png''

      ```


      By using a Microsoft Windows UNC:


      ``` ruby

      source ''\\\\path\\to\\img\\sketch.png''

      ```


      By using a node attribute:


      ``` ruby

      source node[''nginx''][''foo123''][''url'']

      ```


      By using attributes to define paths:


      ``` ruby

      source "#{node[''python''][''url'']}/#{version}/Python-#{version}.tar.bz2"

      ```


      By defining multiple paths for multiple locations:


      ``` ruby

      source ''http://seapower/spring.png'', ''http://seapower/has_sprung.png''

      ```


      By defining those same multiple paths as an array:


      ``` ruby

      source [''http://seapower/spring.png'', ''http://seapower/has_sprung.png'']

      ```


      When multiple paths are specified, Chef Infra Client will attempt to

      download the files in the order listed, stopping after the first

      successful download.'
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
- property: use_conditional_get
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Enable conditional HTTP requests by using a conditional `GET` (with

      the If-Modified-Since header) or an opaque identifier (ETag). To use

      If-Modified-Since headers, `use_last_modified` must also be set to

      `true`. To use ETag headers, `use_etag` must also be set to `true`.'
- property: use_etag
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Enable ETag headers. Set to `false` to disable ETag headers. To use

      this setting, `use_conditional_get` must also be set to `true`.'
- property: use_last_modified
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Enable If-Modified-Since headers. Set to `false` to disable

      If-Modified-Since headers. To use this setting,

      `use_conditional_get` must also be set to `true`.'
- property: show_progess
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Displays the progress of the file download. Set to `true` to enable

      this feature.'
- property: sensitive
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Ensure that sensitive resource data is not logged by Chef Infra

      Client.'
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
      \nFor example, this should return `true`:\n\n``` ruby\nremote_file '/tmp/baz'\
      \ do\n  verify { 1 == 1 }\nend\n```\n\nThis should return `true`:\n\n``` ruby\n\
      remote_file '/etc/nginx.conf' do\n  verify 'nginx -t -c %{path}'\nend\n```"
  - warning:
    - markdown: "For releases of Chef Infra Client prior to 12.5 (chef-client 12.4\n\
        and earlier) the correct syntax is:\n\n``` ruby\nremote_file '/etc/nginx.conf'\
        \ do\n  verify 'nginx -t -c %{file}'\nend\n```\n\nSee GitHub issues <https://github.com/chef/chef/issues/3232>\
        \ and\n<https://github.com/chef/chef/pull/3693> for more information about\n\
        these differences."
  - markdown: "This should return `true`:\n\n``` ruby\nremote_file '/tmp/bar' do\n\
      \  verify { 1 == 1}\nend\n```\n\nAnd this should return `true`:\n\n``` ruby\n\
      remote_file '/tmp/foo' do\n  verify do |path|\n    true\n  end\nend\n```\n\n\
      Whereas, this should return `false`:\n\n``` ruby\nremote_file '/tmp/turtle'\
      \ do\n  verify '/usr/bin/false'\nend\n```\n\nIf a string or a block return `false`,\
      \ the Chef Infra Client run\nwill stop and an error is returned."
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: true
properties_resources_common_windows_security: true
remote_file_prevent_re_downloads: true
remote_file_unc_path: true
ps_credential_helper: false
ruby_style_basics_chef_log: false
debug_recipes_chef_shell: false
template_requirements: false
resources_common_properties: false
resources_common_notification: false
resources_common_guards: false
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Transfer a file from a URL
  text_blocks:
  - code_block: "remote_file '/tmp/testfile' do\n  source 'http://www.example.com/tempfiles/testfile'\n\
      \  mode '0755'\n  checksum '3a7dac00b1' # A SHA256 (or portion thereof) of the\
      \ file.\nend"
- example_heading: Transfer a file only when the source has changed
  text_blocks:
  - shortcode: resource_remote_file_transfer_remote_source_changes.md
- example_heading: Install a file from a remote location using bash
  text_blocks:
  - shortcode: resource_remote_file_install_with_bash.md
- example_heading: Store certain settings
  text_blocks:
  - shortcode: resource_remote_file_store_certain_settings.md
  - markdown: '**Use the platform_family? method**'
  - shortcode: resource_remote_file_use_platform_family.md
- example_heading: Specify local Windows file path as a valid URI
  text_blocks:
  - markdown: 'When specifying a local Microsoft Windows file path as a valid file
      URI,

      an additional forward slash (`/`) is required. For example:'
  - code_block: "remote_file 'file:///c:/path/to/file' do\n  ...       # other attributes\n\
      end"

---
