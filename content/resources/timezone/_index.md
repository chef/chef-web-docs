---
resource_reference: true
common_resource_functionality_multiple_packages: false
common_resource_functionality_resources_common_windows_security: false
cookbook_file_specificity: false
debug_recipes_chef_shell: false
handler_custom: false
handler_types: false
nameless_apt_update: false
nameless_build_essential: false
properties_multiple_packages: false
properties_resources_common_windows_security: false
properties_shortcode: 
ps_credential_helper: false
registry_key: false
remote_directory_recursive_directories: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
resource_directory_recursive_directories: false
resource_package_options: false
resources_common_atomic_update: false
resources_common_guard_interpreter: false
resources_common_guards: true
resources_common_notification: true
resources_common_properties: true
ruby_style_basics_chef_log: false
syntax_shortcode: 
template_requirements: false
unit_file_verification: false
title: timezone resource
resource: timezone
aliases:
- "/resource_timezone.html"
menu:
  infra:
    title: timezone
    identifier: chef_infra/cookbook_reference/resources/timezone timezone
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: 'Use the **timezone** resource to change the system timezone on Windows,

    Linux, and macOS hosts. Timezones are specified in tz database format,

    with a complete list of available TZ values for Linux and macOS here:

    <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones> and for

    Windows here: <https://ss64.com/nt/timezones.html>.'
resource_new_in: '14.6'
syntax_full_code_block: |-
  timezone 'name' do
    timezone      String # default value: 'name' unless specified
    action        Symbol # defaults to :set if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`timezone` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`timezone` is the property available to this resource."
actions_list:
  :set:
    markdown: Set the system timezone.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: timezone
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to set the timezone value if it differs from the
      resource block's name.
examples: "
  Set the timezone to UTC\n\n  ``` ruby\n  timezone 'UTC'\n  ```\n\n\
  \  Set the timezone to UTC with a friendly resource name\n\n  ``` ruby\n  timezone\
  \ 'Set the hosts timezone to UTC' do\n    timezone 'UTC'\n  end\n  ```\n"

---
