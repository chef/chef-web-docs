---
title: dmg_package resource
resource: dmg_package
draft: false
aliases:
- /resource_dmg_package.html
menu:
  infra:
    title: dmg_package
    identifier: chef_infra/cookbooks/resources/dmg_package dmg_package
    parent: chef_infra/cookbooks/resources
    weight: 430
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **dmg_package** resource to install a package from a `.dmg`

    file. The resource will retrieve the file from a remote URL, mount it

    using OS X''s hdidutil, copy the application to the specified destination

    (`/Applications`), and detach the image using hdiutil. The `.dmg` file

    will be stored in the `Chef::Config[:file_cache_path]`.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The dmg_package resource has the following syntax:\n\n``` ruby\n\
  dmg_package 'name' do\n  accept_eula          true, false # default value: false\n\
  \  allow_untrusted      true, false # default value: false\n  app              \
  \    String # default value: 'name' unless specified\n  checksum             String\n\
  \  destination          String # default value: \"/Applications\"\n  dmg_name  \
  \           String # default value: The value passed for the application name.\n\
  \  dmg_passphrase       String\n  file                 String\n  headers       \
  \       Hash\n  owner                String, Integer\n  package_id           String\n\
  \  source               String\n  type                 String # default value: \"\
  app\"\n  volumes_dir          String # default value: The value passed for the application\
  \ name.\n  action               Symbol # defaults to :install if not specified\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`dmg_package` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`accept_eula`, `allow_untrusted`, `app`, `checksum`, `destination`, `dmg_name`,
  `dmg_passphrase`, `file`, `headers`, `owner`, `package_id`, `source`, `type`, and
  `volumes_dir` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Installs the application.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: accept_eula
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Specify whether to accept the EULA. Certain dmgs require acceptance

      of EULA before mounting.'
- property: allow_untrusted
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Allow installation of packages that do not have trusted

      certificates.'
- property: app
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The name of the application as it appears in the `/Volumes`

      directory if it differs from the resource block''s name.'
- property: checksum
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The sha256 checksum of the `.dmg` file to download.
- property: destination
  ruby_type: String
  required: false
  default_value: '"/Applications"'
  new_in: null
  description_list:
  - markdown: The directory to copy the `.app` into.
- property: dmg_name
  ruby_type: String
  required: false
  default_value: The value passed for the application name.
  new_in: null
  description_list:
  - markdown: 'The name of the `.dmg` file if it differs from that of the app, or

      if the name has spaces.'
- property: dmg_passphrase
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Specify a passphrase to be used to decrypt the `.dmg` file during

      the mount process.'
- property: file
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The full path to the `.dmg` file on the local system.
- property: headers
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Allows custom HTTP headers (like cookies) to be set on the

      `remote_file` resource.'
- property: owner
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The user that should own the package installation.
- property: package_id
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The package ID that is registered with `pkgutil` when a `pkg` or

      `mpkg` is installed.'
- property: source
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The remote URL that is used to download the `.dmg` file, if

      specified.'
- property: type
  ruby_type: String
  required: false
  default_value: '"app"'
  new_in: null
  allowed_values: 'app pkg mpkg'
  description_list:
  - markdown: The type of package.
- property: volumes_dir
  ruby_type: String
  required: false
  default_value: The value passed for the application name.
  new_in: null
  description_list:
  - markdown: 'The directory under `/Volumes` where the dmg is mounted if it

      differs from the name of the `.dmg` file.'
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
- example_heading: Install Google Chrome via the DMG package
  text_blocks:
  - code_block: "dmg_package 'Google Chrome' do\n  dmg_name 'googlechrome'\n  source\
      \   'https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg'\n  checksum\
      \ '7daa2dc5c46d9bfb14f1d7ff4b33884325e5e63e694810adc58f14795165c91a'\n  action\
      \   :install\nend"
- example_heading: Install Virtualbox from the .mpkg
  text_blocks:
  - code_block: "dmg_package 'Virtualbox' do\n  source 'http://dlc.sun.com.edgesuite.net/virtualbox/4.0.8/VirtualBox-4.0.8-71778-OSX.dmg'\n\
      \  type   'mpkg'\nend"
- example_heading: Install pgAdmin and automatically accept the EULA
  text_blocks:
  - code_block: "dmg_package 'pgAdmin3' do\n  source   'http://wwwmaster.postgresql.org/redir/198/h/pgadmin3/release/v1.12.3/osx/pgadmin3-1.12.3.dmg'\n\
      \  checksum '9435f79d5b52d0febeddfad392adf82db9df159196f496c1ab139a6957242ce9'\n\
      \  accept_eula true\nend"

---
