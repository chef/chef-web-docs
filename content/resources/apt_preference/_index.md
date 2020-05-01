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
title: apt_preference resource
resource: apt_preference
aliases:
- "/resource_apt_preference.html"
menu:
  infra:
    title: apt_preference
    identifier: chef_infra/cookbook_reference/resources/apt_preference apt_preference
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **apt_preference** resource to create APT [preference files](https://wiki.debian.org/AptPreferences).
    Preference files are used to control which package versions and sources are prioritized
    during installation.
resource_new_in: '13.3'
syntax_full_code_block: |-
  apt_preference 'name' do
    glob              String
    package_name      String # default value: 'name' unless specified
    pin               String
    pin_priority      String, Integer
    action            Symbol # defaults to :add if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`apt_preference` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`glob`, `package_name`, `pin`, and `pin_priority` are the properties available
  to this resource."
actions_list:
  add:
    markdown: Default action. Creates a preferences file under `/etc/apt/preferences.d`.
  remove:
    markdown: Removes the preferences file, thus unpinning the package.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: glob
  ruby_type: String
  required: false
  description_list:
  - markdown: Pin by a `glob()` expression or with a regular expression surrounded
      by `/`.
- property: package_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to set the package name if it differs from the
      resource block's name.
- property: pin
  ruby_type: String
  required: true
  description_list:
  - markdown: The package version or repository to pin.
- property: pin_priority
  ruby_type: String, Integer
  required: true
  description_list:
  - markdown: Sets the Pin-Priority for a package. See <https://wiki.debian.org/AptPreferences>
      for more details.
examples: |
  **Pin libmysqlclient16 to a version 5.1.49-3**:

  ```ruby
  apt_preference 'libmysqlclient16' do
    pin          'version 5.1.49-3'
    pin_priority '700'
  end
  ```

  Note: The `pin_priority` of `700` ensures that this version will be preferred over any other available versions.

  **Unpin a libmysqlclient16**:

  ```ruby
  apt_preference 'libmysqlclient16' do
    action :remove
  end
  ```

  **Pin all packages to prefer the packages.dotdeb.org repository**:

  ```ruby
  apt_preference 'dotdeb' do
    glob         '*'
    pin          'origin packages.dotdeb.org'
    pin_priority '700'
  end
  ```
---