---
title: locale resource
resource: locale
draft: false
aliases: /resource_locale.html
menu:
  docs:
    title: locale
    identifier: chef_infra/cookbook_reference/resources/resource_locale.md locale
    parent: chef_infra/cookbook_reference/resources
    weight: 520
resource_reference: true
robots: null
resource_description_list:
- markdown: Use the **locale** resource to set the system's locale.
resource_new_in: '14.5'
handler_types: false
syntax_description: 'The locale resource has the following syntax:'
syntax_code_block: "locale 'name' do\n  lang        String\n  lc_env      Hash\n \
  \ action      Symbol # defaults to :update if not specified\nend"
syntax_properties_list:
- '`locale` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`lang` and `lc_env` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :update:
    markdown: Updates the system's locale.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: lang
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Sets the default system language.
- property: lc_env
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "Sets the locale category that corresponds to environment variable.\n\
      \n-   *lc_env* is a hash of [LC]()\\* env variables in the form of\n    ({'LC_ENV_VARIABLE'\
      \ =\\> 'VALUE'}).\n-   Valid values that can be used to set *LC_ENV_VARIABLE*\
      \ are:\n    LC_ADDRESS, LC_COLLATE, LC_CTYPE, LC_IDENTIFICATION,\n    LC_MEASUREMENT,\
      \ LC_MESSAGES, LC_MONETARY, LC_NAME,\n    LC_NUMERIC, LC_PAPER, LC_TELEPHONE\
      \ and LC_TIME."
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
examples_list: null

---
