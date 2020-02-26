---
title: mount resource
resource: mount
draft: false
aliases:
- /resource_mount.html
menu:
  docs:
    title: mount
    identifier: chef_infra/cookbook_reference/resources/mount mount
    parent: chef_infra/cookbook_reference/resources
    weight: 700
resource_reference: true
robots: null
resource_description_list:
- markdown: Use the **mount** resource to manage a mounted file system.
resource_new_in: null
handler_types: false
syntax_description: "The mount resource has the following syntax:\n\n``` ruby\nmount\
  \ 'name' do\n  device           String\n  device_type      String, Symbol # default\
  \ value: :device\n  domain           String\n  dump             Integer, false #\
  \ default value: 0\n  enabled          true, false # default value: false\n  fsck_device\
  \      String # default value: \"-\"\n  fstype           String # default value:\
  \ \"auto\"\n  mount_point      String # default value: 'name' unless specified\n\
  \  options          Array, String # default value: [\"defaults\"]\n  pass      \
  \       Integer, false # default value: 2\n  password         String\n  supports\
  \         Array, Hash\n  username         String\n  action           Symbol # defaults\
  \ to :mount if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`mount` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`device`, `device_type`, `domain`, `dump`, `enabled`, `fsck_device`, `fstype`,
  `mount_point`, `options`, `pass`, `password`, `supports`, and `username` are the
  properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :disable:
    markdown: Remove an entry from the file systems table (`fstab`).
  :enable:
    markdown: Add an entry to the file systems table (`fstab`).
  :mount:
    markdown: Default. Mount a device.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :remount:
    markdown: Remount a device.
  :umount:
    markdown: Unmount a device.
  :unmount:
    markdown: Alias for `:umount` action.
properties_list:
- property: device
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Required for `:umount` and `:remount` actions (for the purpose of

      checking the mount command output for presence). The special block

      device or remote node, a label, or a uuid to be mounted.'
- property: device_type
  ruby_type: String, Symbol
  required: false
  default_value: :device
  new_in: null
  description_list:
  - markdown: 'The type of device: :device, :label, or :uuid'
- property: domain
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Windows only: Use to specify the domain in which the `username` and

      `password` are located.'
- property: dump
  ruby_type: Integer, false
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: 'The dump frequency (in days) used while creating a file systems

      table (fstab) entry.'
- property: enabled
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Use to specify if a mounted file system is enabled.
- property: fsck_device
  ruby_type: String
  required: false
  default_value: '"-"'
  new_in: null
  description_list:
  - markdown: 'Solaris only: The fsck device.'
- property: fstype
  ruby_type: String
  required: false
  default_value: '"auto"'
  new_in: null
  description_list:
  - markdown: The file system type (fstype) of the device.
- property: mount_point
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The directory (or path) in which the device is to be mounted.

      Defaults to the name of the resource block if not provided.'
- property: options
  ruby_type: Array, String
  required: false
  default_value: '["defaults"]'
  new_in: null
  description_list:
  - markdown: An array or comma separated list of options for the mount.
- property: pass
  ruby_type: Integer, false
  required: false
  default_value: '2'
  new_in: null
  description_list:
  - markdown: 'The pass number used by the file system check (`fsck`) command while

      creating a file systems table (`fstab`) entry.'
- property: password
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Windows only. Use to specify the password for `username`.
- property: supports
  ruby_type: Array, Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Specify a Hash of supported mount features. Default value:

      `remount: false` (preferred). Array defaults to `remount: true`

      (non-preferred).'
- property: username
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Windows only: Use to specify the user name.'
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
- example_heading: Mount a labeled file system
  text_blocks:
  - code_block: "mount '/mnt/volume1' do\n  device 'volume1'\n  device_type :label\n\
      \  fstype 'xfs'\n  options 'rw'\nend"
- example_heading: Mount a local block drive
  text_blocks:
  - code_block: "mount '/mnt/local' do\n  device '/dev/sdb1'\n  fstype 'ext3'\nend"
- example_heading: Mount a non-block file system
  text_blocks:
  - code_block: "mount '/mount/tmp' do\n  pass     0\n  fstype   'tmpfs'\n  device\
      \   '/dev/null'\n  options  'nr_inodes=999k,mode=755,size=500m'\n  action  \
      \ [:mount, :enable]\nend"
- example_heading: Mount and add to the file systems table
  text_blocks:
  - code_block: "mount '/export/www' do\n  device 'nas1prod:/export/web_sites'\n \
      \ fstype 'nfs'\n  options 'rw'\n  action [:mount, :enable]\nend"
- example_heading: Mount a remote file system
  text_blocks:
  - code_block: "mount '/export/www' do\n  device 'nas1prod:/export/web_sites'\n \
      \ fstype 'nfs'\n  options 'rw'\nend"
- example_heading: Mount a remote folder in Microsoft Windows
  text_blocks:
  - code_block: "mount 'T:' do\n  action :mount\n  device '\\\\\\\\hostname.example.com\\\
      \\folder'\nend"
- example_heading: Unmount a remote folder in Microsoft Windows
  text_blocks:
  - code_block: "mount 'T:' do\n  action :umount\n  device '\\\\\\\\hostname.example.com\\\
      \\D$'\nend"
- example_heading: Stop a service, do stuff, and then restart it
  text_blocks:
  - shortcode: resource_service_stop_do_stuff_start.md

---
