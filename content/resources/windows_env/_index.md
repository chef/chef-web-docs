---
title: windows_env resource
resource: windows_env
draft: false
aliases:
- /resource_windows_env.html
- /resource_env.html
menu:
  infra:
    title: windows_env
    identifier: chef_infra/cookbook_reference/resources/windows_env windows_env
    parent: chef_infra/cookbook_reference/resources
    weight: 1290
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_env** resource to manage environment keys in

    Microsoft Windows. After an environment key is set, Microsoft Windows

    must be restarted before the environment key will be available to the

    Task Scheduler.


    This resource was previously called the **env** resource; its name was

    updated in Chef Client 14.0 to reflect the fact that only Windows is

    supported. Existing cookbooks using `env` will continue to function, but

    should be updated to use the new name.'
- note:
    markdown: 'On UNIX-based systems, the best way to manipulate environment keys
      is

      with the `ENV` variable in Ruby; however, this approach does not have

      the same permanent effect as using the **windows_env** resource.'
resource_new_in: null
handler_types: false
syntax_description: "The windows_env resource has the following syntax:\n\n``` ruby\n\
  windows_env 'name' do\n  delim         String, false\n  key_name      String # default\
  \ value: 'name' unless specified\n  user          String # default value: \"<System>\"\
  \n  value         String\n  action        Symbol # defaults to :create if not specified\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_env` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`delim`, `key_name`, `user`, and `value` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create an environment variable. If an environment variable
      already exists (but does not match), update that environment variable to match.
  :delete:
    markdown: Delete an environment variable.
  :modify:
    markdown: Modify an existing environment variable. This prepends the new value
      to the existing value, using the delimiter specified by the `delim` property.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: delim
  ruby_type: String, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The delimiter that is used to separate multiple values for a single

      key.'
- property: key_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the name of the key that is to be

      created, deleted, or modified if it differs from the resource

      block''s name.'
- property: user
  ruby_type: String
  required: false
  default_value: '"<System>"'
  new_in: null
  description_list: []
- property: value
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The value of the environmental variable to set.
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
- example_heading: Set an environment variable
  text_blocks:
  - code_block: "windows_env 'ComSpec' do\n  value \"C:\\\\Windows\\\\system32\\\\\
      cmd.exe\"\nend"

---
