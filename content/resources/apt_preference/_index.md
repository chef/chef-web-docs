---
title: apt_preference resource
resource: apt_preference
draft: false
aliases: /resource_apt_preference.html
menu:
  docs:
    title: apt_preference
    identifier: chef_infra/cookbook_reference/resources/resource_apt_preference.md
      apt_preference
    parent: chef_infra/cookbook_reference/resources
    weight: 70
resource_reference: true
robots: null
resource_description_list:
- markdown: 'The **apt_preference** resource allows for the creation of APT

    [preference files](https://wiki.debian.org/AptPreferences). Preference

    files are used to control which package versions and sources are

    prioritized during installation.'
resource_new_in: '13.3'
handler_types: false
syntax_description: 'The apt_preference resource has the following syntax:'
syntax_code_block: "apt_preference 'name' do\n  glob              String\n  package_name\
  \      String # default value: 'name' unless specified\n  pin               String\n\
  \  pin_priority      String, Integer\n  action            Symbol # defaults to :add\
  \ if not specified\nend"
syntax_properties_list:
- '`apt_preference` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`glob`, `package_name`, `pin`, and `pin_priority` are the properties available
  to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
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
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Pin by `glob()` expression or with regular expressions surrounded by

      `/`.'
- property: package_name
  ruby_type: String
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the package name if it differs from the

      resource block''s name.'
- property: pin
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The package version or repository to pin.
- property: pin_priority
  ruby_type: String, Integer
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Sets the `Pin-Priority` for a package. See the [APT pinning

      documentation](https://wiki.debian.org/AptPreferences) for more

      details.'
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
- example_heading: Pin a package to a specific version
  text_blocks:
  - markdown: 'This example pins the `libmysqlclient16` package to `version 5.1.49-3`:'
  - code_block: "apt_preference 'libmysqlclient16' do\n  pin          'version 5.1.49-3'\n\
      \  pin_priority '700'\nend"
  - markdown: 'Note that the `pin_priority` of `700` ensures that this version will
      be

      preferred over any other available versions.'
- example_heading: Unpin a package
  text_blocks:
  - markdown: 'This example unpins the `libmysqlclient16` package, disabling all

      preferences for it:'
  - code_block: "apt_preference 'libmysqlclient16' do\n  action :remove\nend"
- example_heading: Pin all packages to prefer a specific repository
  text_blocks:
  - markdown: 'This example instructs APT to prefer the `packages.dotdeb.org`

      repository:'
  - code_block: "apt_preference 'dotdeb' do\n  glob         '*'\n  pin          'origin\
      \ packages.dotdeb.org'\n  pin_priority '700'\nend"

---
