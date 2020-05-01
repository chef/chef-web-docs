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
title: locale resource
resource: locale
aliases:
- "/resource_locale.html"
menu:
  infra:
    title: locale
    identifier: chef_infra/cookbook_reference/resources/locale locale
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **locale** resource to set the system's locale.
resource_new_in: '14.5'
syntax_full_code_block: |-
  locale 'name' do
    lang        String
    lc_env      Hash
    action      Symbol # defaults to :update if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`locale` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`lang` and `lc_env` are the properties available to this resource."

actions_list:
  :update:
    markdown: Updates the system's locale.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: lang
  ruby_type: String
  required: false
  description_list:
  - markdown: Sets the default system language.
- property: lc_env
  ruby_type: Hash
  required: false
  default_value: null
  description_list:
  - markdown: "Sets the locale category that corresponds to environment variable.\n\
      \n-   *lc_env* is a hash of [LC]()\\* env variables in the form of\n    ({'LC_ENV_VARIABLE'\
      \ =\\> 'VALUE'}).\n-   Valid values that can be used to set *LC_ENV_VARIABLE*\
      \ are:\n    LC_ADDRESS, LC_COLLATE, LC_CTYPE, LC_IDENTIFICATION,\n    LC_MEASUREMENT,\
      \ LC_MESSAGES, LC_MONETARY, LC_NAME,\n    LC_NUMERIC, LC_PAPER, LC_TELEPHONE\
      \ and LC_TIME."
examples: |
  Set the lang to 'en_US.UTF-8'

  ```ruby
    locale 'set system locale' do
      lang 'en_US.UTF-8'
    end
  ```


---
