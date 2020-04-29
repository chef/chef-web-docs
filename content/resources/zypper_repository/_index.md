---
title: zypper_repository resource
resource: zypper_repository
aliases:
- "/resource_zypper_repository.html"
menu:
  infra:
    title: zypper_repository
    identifier: chef_infra/cookbook_reference/resources/zypper_repository zypper_repository
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **zypper_repository** resource to create Zypper package

    repositories on SUSE Enterprise Linux and openSUSE systems. This

    resource maintains full compatibility with the **zypper_repository**

    resource in the existing zypper cookbook.'
resource_new_in: '13.3'
handler_types: false
syntax_description: "The zypper_repository resource has the following syntax:\n\n\
  ``` ruby\nzypper_repository 'name' do\n  autorefresh            true, false # default\
  \ value: true\n  baseurl                String\n  cookbook               String\n\
  \  description            String\n  enabled                true, false # default\
  \ value: true\n  gpgautoimportkeys      true, false # default value: true\n  gpgcheck\
  \               true, false # default value: true\n  gpgkey                 String\n\
  \  keeppackages           true, false # default value: false\n  mirrorlist     \
  \        String\n  mode                   String, Integer # default value: \"0644\"\
  \n  path                   String\n  priority               Integer # default value:\
  \ 99\n  refresh_cache          true, false # default value: true\n  repo_name  \
  \            String # default value: 'name' unless specified\n  source         \
  \        String\n  type                   String # default value: \"NONE\"\n  action\
  \                 Symbol # defaults to :create if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`zypper_repository` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`autorefresh`, `baseurl`, `cookbook`, `description`, `enabled`, `gpgautoimportkeys`,
  `gpgcheck`, `gpgkey`, `keeppackages`, `mirrorlist`, `mode`, `path`, `priority`,
  `refresh_cache`, `repo_name`, `source`, and `type` are the properties available
  to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :add:
    markdown: Default action. Add a new Zypper repository.
  :refresh:
    markdown: Refresh a Zypper repository.
  :remove:
    markdown: Remove a Zypper repository.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: autorefresh
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: 
  description_list:
  - markdown: Determines whether or not the repository should be refreshed automatically.
- property: baseurl
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The base URL for the Zypper repository, such as `http://download.opensuse.org`.
- property: cookbook
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The cookbook to source the repository template file from. Only necessary
      if you're not using the built in template.
- property: description
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The description of the repository that will be shown by the `zypper
      repos` command.
- property: enabled
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: 
  description_list:
  - markdown: Determines whether or not the repository should be enabled.
- property: gpgautoimportkeys
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: 
  description_list:
  - markdown: Automatically import the specified key when setting up the repository.
- property: gpgcheck
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: 
  description_list:
  - markdown: Determines whether or not to perform a GPG signature check on the repository.
- property: gpgkey
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The location of the repository key to be imported.
- property: keeppackages
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: 
  description_list:
  - markdown: Determines whether or not packages should be saved.
- property: mirrorlist
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The URL of the mirror list that will be used.
- property: mode
  ruby_type: String, Integer
  required: false
  default_value: '0644'
  new_in: 
  description_list:
  - markdown: The file mode of the repository file.
- property: path
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The relative path from the repository's base URL.
- property: priority
  ruby_type: Integer
  required: false
  default_value: '99'
  new_in: 
  description_list:
  - markdown: Determines the priority of the Zypper repository.
- property: refresh_cache
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: 
  description_list:
  - markdown: Determines whether or not the package cache should be refreshed.
- property: repo_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: 
  description_list:
  - markdown: An optional property to set the repository name if it differs from the
      resource block's name.
- property: source
  ruby_type: String
  required: false
  default_value: 
  new_in: 
  description_list:
  - markdown: The name of the template for the repository file. Only necessary if
      you're not using the built in template.
- property: type
  ruby_type: String
  required: false
  default_value: '"NONE"'
  new_in: 
  description_list:
  - markdown: Specifies the repository type.
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
- example_heading: Add a repository
  text_blocks:
  - markdown: 'This example adds the "Apache" repository for OpenSUSE Leap 15.0:'
  - code_block: "zypper_repository 'apache' do\n  baseurl 'http://download.opensuse.org/repositories/Apache'\n\
      \  path '/openSUSE_Leap_15.0'\n  type 'rpm-md'\n  priority '100'\nend"

---
