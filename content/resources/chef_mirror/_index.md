---
title: chef_mirror resource
resource: chef_mirror
draft: false
aliases:
- /resource_chef_mirror.html
menu:
  infra:
    title: chef_mirror
    identifier: chef_infra/cookbooks/resources/chef_mirror chef_mirror
    parent: chef_infra/cookbooks/resources
    weight: 270
resource_reference: true
robots: null
resource_description_list:
- warning:
    shortcode: EOL_provisioning.md
- markdown: 'Use the **chef_mirror** resource to mirror objects in the chef-repo to

    a specified location.'
resource_new_in: null
handler_types: false
syntax_description: "The syntax for using the **chef_mirror** resource in a recipe\
  \ is as\nfollows:\n\n``` ruby\nchef_mirror 'name' do\n  attribute 'value' # see\
  \ properties section below\n  ...\n  action :action # see actions section below\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`chef_mirror` tells Chef Infra Client to use the `Chef::Provider::ChefMirror` provider
  during a Chef Infra Client run'
- '`name` is the name of the resource block; when the `path` property is not specified
  as part of a recipe, `name` is also the name of the Chef Infra Client'
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
  :download:
    markdown: ''
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: chef_repo_path
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The path to the chef-repo.
- property: chef_server
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The URL for the Chef server.
- property: concurrency
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The number of threads to run in-parallel. Default value: `10`.'
- property: freeze_on_upload
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to freeze cookbooks upon upload to the mirrored location. When

      `true` (default), cookbooks are frozen.'
- property: ignore_failure
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Continue running a recipe if a resource fails for any reason.
- property: no_diff
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to upload only new files.
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
- property: path
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A path to a directory in the chef-repo to be mirrored. For example:

      `nodes`, `nodes/*`, `/nodes/my_node`, `*/*`, `roles/base`,

      `data/secrets`, `cookbooks/apache2`, and so on.'
- property: purge
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to remove objects that have been deleted locally from the

      mirrored location. For example, when used with the `:upload` action,

      cookbooks that exist in the mirrored location, but do not exist

      locally, will be deleted.'
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
- property: versioned_cookbooks
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Append cookbook versions to cookbooks. Set to `false` to hide

      cookbook versions: `cookbooks/apache`. Set to `true` to show

      cookbook versions: `cookbooks/apache-1.0.0` and/or

      `cookbooks/apache-1.0.1`. When this setting is `true`,

      `knife download` downloads ALL cookbook versions, which can be

      useful if a full-fidelity backup of data on the Chef server is

      required. Defaults to `true` when `chef_repo_path` is specified, but

      this property is not.'
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
examples_list: null

---
