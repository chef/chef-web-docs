---
title: log resource
resource: log
aliases:
- "/resource_log.html"
menu:
  infra:
    title: log
    identifier: chef_infra/cookbook_reference/resources/log log
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- shortcode: resource_log_summary.md
resource_new_in: null
handler_types: false
syntax_description: ''
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: resource_log_syntax.md
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list: {}
properties_list: []
properties_shortcode: resource_log_properties.md
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: false
properties_resources_common_windows_security: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
ps_credential_helper: false
ruby_style_basics_chef_log: true
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
examples: "
  Set default logging level\n\n  ``` ruby\n  log 'a string to log'\n\
  \  ```\n\n  Set debug logging level\n\n  ``` ruby\n  log 'a debug string' do\n \
  \   level :debug\n  end\n  ```\n\n  Add a message to a log file\n\n  ``` ruby\n\
  \  log 'message' do\n    message 'This is the message that will be added to the\
  \ log.'\n    level :info\n  end\n  ```\n"

---
