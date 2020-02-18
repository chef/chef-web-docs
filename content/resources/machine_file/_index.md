---
title: machine_file resource
resource: machine_file
draft: false
aliases:
- /resource_machine_file.html
resource_reference: false
robots: noindex, nofollow
resource_description_list:
- markdown: 'Use the **machine_file** resource to manage a file on a remote machine

    in much the same way the **file** resource is used to manage a file on a

    local machine.'
- warning:
    shortcode: EOL_provisioning.md
resource_new_in: null
handler_types: false
syntax_description: "The syntax for using the **machine_file** resource in a recipe\
  \ is as\nfollows:\n\n``` ruby\nmachine_file 'name' do\n  attribute 'value' # see\
  \ properties section below\n  ...\n  action :action # see actions section below\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`machine_file` tells Chef Infra Client to use the `Chef::Provider::MachineFile`
  provider during a Chef Infra Client run'
- '`name` is the name of the resource block; when the `path` property is not specified
  as part of a recipe, `name` is also the path to a file'
- '`attribute` is zero (or more) of the properties that are available for this resource'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :delete:
    markdown: Use to delete a file from a machine.
  :download:
    markdown: Use to download a file from a machine.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :upload:
    markdown: Default. Use to upload a file to a machine.
properties_list:
- property: chef_server
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The URL for the Chef Infra Server.
- property: content
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A string that is written to the file. The contents of this property

      replace any previous content when this property has something other

      than the default value. The default behavior will not modify

      content.'
- property: driver
  ruby_type: Chef::Provisioning::Driver
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify the driver to be used for provisioning.
- property: group
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A string or ID that identifies the group owner by group name,

      including fully qualified group names such as `domain\group` or

      `group@domain`. If this value is not specified, existing groups

      remain unchanged and new group assignments use the default `POSIX`

      group (if available).'
- property: local_path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The local path to a file.
- property: machine
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify the machine type.
- property: mode
  ruby_type: String
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
resources_common_guards: false
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Get a remote file onto a new machine
  text_blocks:
  - shortcode: resource_machine_file_get_remote_file.md

---
