---
title: timezone resource
resource: timezone
draft: false
aliases: /resource_timezone.html
menu:
  docs:
    title: timezone
    identifier: chef_infra/cookbook_reference/resources/resource_timezone.md timezone
    parent: chef_infra/cookbook_reference/resources
    weight: 1060
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **timezone** resource to change the system timezone on Windows,

    Linux, and macOS hosts. Timezones are specified in tz database format,

    with a complete list of available TZ values for Linux and macOS here:

    <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones> and for

    Windows here: <https://ss64.com/nt/timezones.html>.'
resource_new_in: '14.6'
handler_types: false
syntax_description: 'The timezone resource has the following syntax:'
syntax_code_block: "timezone 'name' do\n  timezone      String # default value: 'name'\
  \ unless specified\n  action        Symbol # defaults to :set if not specified\n\
  end"
syntax_properties_list:
- '`timezone` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`timezone` is the property available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :set:
    markdown: Set the system timezone.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: timezone
  ruby_type: String
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the timezone value if it differs from

      the resource block''s name.'
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
- example_heading: Set the timezone to UTC
  text_blocks:
  - markdown: ':'
  - code_block: timezone 'UTC'
- example_heading: Set the timezone to UTC with a friendly resource name
  text_blocks:
  - markdown: ':'
  - code_block: "timezone 'Set the hosts timezone to UTC' do\n      timezone 'UTC'\n\
      \    end"

---
