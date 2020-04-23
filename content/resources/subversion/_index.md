---
title: subversion resource
resource: subversion
draft: false
aliases:
- /resource_subversion.html
menu:
  infra:
    title: subversion
    identifier: chef_infra/cookbooks/resources/subversion subversion
    parent: chef_infra/cookbooks/resources
    weight: 1130
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **subversion** resource to manage source control resources that

    exist in a Subversion repository.'
- warning:
    markdown: 'The subversion resource has known bugs and may not work as expected.
      For

      more information see Chef GitHub issues, particularly

      [\#4050](https://github.com/chef/chef/issues/4050) and

      [\#4257](https://github.com/chef/chef/issues/4257).'
resource_new_in: null
handler_types: false
syntax_description: "The subversion resource has the following syntax:\n\n``` ruby\n\
  subversion 'name' do\n  checkout_branch        String # default value: \"deploy\"\
  \n  depth                  Integer\n  destination            String # default value:\
  \ 'name' unless specified\n  enable_checkout        true, false # default value:\
  \ true\n  enable_submodules      true, false # default value: false\n  environment\
  \            Hash\n  group                  String, Integer\n  remote          \
  \       String # default value: \"origin\"\n  repository             String\n  revision\
  \               String # default value: \"HEAD\"\n  ssh_wrapper            String\n\
  \  svn_arguments          String, false # default value: \"--no-auth-cache\"\n \
  \ svn_binary             String\n  svn_info_args          String, false # default\
  \ value: \"--no-auth-cache\"\n  svn_password           String\n  svn_username  \
  \         String\n  timeout                Integer\n  user                   String,\
  \ Integer\n  action                 Symbol # defaults to :sync if not specified\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`subversion` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`checkout_branch`, `depth`, `destination`, `enable_checkout`, `enable_submodules`,
  `environment`, `group`, `remote`, `repository`, `revision`, `ssh_wrapper`, `svn_arguments`,
  `svn_binary`, `svn_info_args`, `svn_password`, `svn_username`, `timeout`, and `user`
  are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :checkout:
    markdown: Clone or check out the source. When a checkout is available, this provider
      does nothing.
  :export:
    markdown: Export the source, excluding or removing any version control artifacts.
  :force_export:
    markdown: Export the source, excluding or removing any version control artifacts
      and force an export of the source that is overwriting the existing copy (if
      it exists).
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :sync:
    markdown: Default. Update the source to the specified version, or get a new clone
      or checkout. This action causes a hard reset of the index and working tree,
      discarding any uncommitted changes.
properties_list:
- property: destination
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The location path to which the source is to be cloned, checked out,

      or exported. Default value: the `name` of the resource block. See

      "Syntax" section above for more information.'
- property: group
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The system group that is responsible for the checked-out code.
- property: repository
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The URI for the Subversion repository.
- property: revision
  ruby_type: String
  required: false
  default_value: HEAD
  new_in: null
  description_list:
  - markdown: 'A branch, tag, or commit to be synchronized with git. This can be

      symbolic, like `HEAD` or it can be a source control

      management-specific revision identifier.'
- property: svn_arguments
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The extra arguments that are passed to the Subversion command.
- property: svn_info_args
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use when the `svn info` command is used by Chef Infra Client and

      arguments need to be passed. The `svn_arguments` command does not

      work when the `svn info` command is used.'
- property: svn_password
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The password for a user that has access to the Subversion

      repository.'
- property: svn_username
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The user name for a user that has access to the Subversion

      repository.'
- property: timeout
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The amount of time (in seconds) to wait for a command to execute

      before timing out. When this property is specified using the

      **deploy** resource, the value of the `timeout` property is passed

      from the **deploy** resource to the **subversion** resource.'
- property: user
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The system user that is responsible for the checked-out code.
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
- example_heading: Get the latest version of an application
  text_blocks:
  - code_block: "subversion 'CouchDB Edge' do\n  repository 'http://svn.apache.org/repos/asf/couchdb/trunk'\n\
      \  revision 'HEAD'\n  destination '/opt/mysources/couch'\n  action :sync\nend"

---
