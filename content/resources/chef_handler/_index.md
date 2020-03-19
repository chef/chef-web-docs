---
title: chef_handler resource
resource: chef_handler
draft: false
aliases:
- /resource_chef_handler.html
menu:
  infra:
    title: chef_handler
    identifier: chef_infra/cookbook_reference/resources/chef_handler chef_handler
    parent: chef_infra/cookbook_reference/resources
    weight: 260
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **chef_handler** resource to enable handlers during a Chef

    Infra Client run. The resource allows arguments to be passed to Chef

    Infra Client, which then applies the conditions defined by the custom

    handler to the node attribute data collected during a Chef Infra Client

    run, and then processes the handler based on that data.


    The **chef_handler** resource is typically defined early in a node''s

    run-list (often being the first item). This ensures that all of the

    handlers will be available for the entire Chef Infra Client run.'
resource_new_in: '14.0'
handler_types: true
syntax_description: "A **chef_handler** resource block enables handlers during a chef-client\n\
  run. Two handlers---`JsonFile` and `ErrorReport`---are built into Chef:\n\n``` ruby\n\
  chef_handler 'Chef::Handler::JsonFile' do\n  source 'chef/handler/json_file'\n \
  \ arguments :path => '/var/chef/reports'\n  action :enable\nend\n```\n\nand:\n\n\
  ``` ruby\nchef_handler 'Chef::Handler::ErrorReport' do\n  source 'chef/handler/error_report'\n\
  \  action :enable\nend\n```\n\nshow how to enable those handlers in a recipe."
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "chef_handler 'name' do\n  arguments       Array, Hash\n \
  \ class_name      String # default value: 'name' unless specified\n  source    \
  \      String\n  type            Hash # default value: { \"report\" => true, \"\
  exception\" => true}\n  action          Symbol # defaults to :enable if not specified\n\
  end"
syntax_full_properties_list:
- '`chef_handler` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`arguments`, `class_name`, `source`, and `type` are the properties available to
  this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :disable:
    markdown: Disable the handler for the current chef-client run on the current node.
  :enable:
    markdown: Enable the handler for the current chef-client run on the current node.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: arguments
  ruby_type: Array, Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An array of arguments that are passed to the initializer for the

      handler class. For example:


      ``` ruby

      arguments :key1 => ''val1''

      ```


      or:


      ``` ruby

      arguments [:key1 => ''val1'', :key2 => ''val2'']

      ```'
- property: class_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: The name of the handler class. This can be module name-spaced.
- property: source
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The full path to the handler file or the path to a gem (if the

      handler ships as part of a Ruby gem).'
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
handler_custom: true
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Enable the CloudkickHandler handler
  text_blocks:
  - markdown: 'The following example shows how to enable the `CloudkickHandler`

      handler, which adds it to the default handler path and passes the

      `oauth` key/secret to the handler''s initializer:'
  - code_block: "chef_handler \"CloudkickHandler\" do\n  source \"#{node['chef_handler']['handler_path']}/cloudkick_handler.rb\"\
      \n  arguments [node['cloudkick']['oauth_key'], node['cloudkick']['oauth_secret']]\n\
      \  action :enable\nend"
- example_heading: Enable handlers during the compile phase
  text_blocks:
  - code_block: "chef_handler \"Chef::Handler::JsonFile\" do\n  source \"chef/handler/json_file\"\
      \n  arguments :path => '/var/chef/reports'\n  action :nothing\nend.run_action(:enable)"
- example_heading: Handle only exceptions
  text_blocks:
  - code_block: "chef_handler \"Chef::Handler::JsonFile\" do\n  source \"chef/handler/json_file\"\
      \n  arguments :path => '/var/chef/reports'\n  supports :exception => true\n\
      \  action :enable\nend"
- example_heading: Cookbook Versions (a custom handler)
  text_blocks:
  - shortcode: handler_custom_example_cookbook_versions.md
  - markdown: 'cookbook_versions.rb:'
  - shortcode: handler_custom_example_cookbook_versions_handler.md
  - markdown: 'default.rb:'
  - shortcode: handler_custom_example_cookbook_versions_recipe.md
- example_heading: JsonFile Handler
  text_blocks:
  - shortcode: handler_custom_example_json_file.md
- example_heading: Register the JsonFile handler
  text_blocks:
  - code_block: "chef_handler \"Chef::Handler::JsonFile\" do\n  source \"chef/handler/json_file\"\
      \n  arguments :path => '/var/chef/reports'\n  action :enable\nend"
- example_heading: ErrorReport Handler
  text_blocks:
  - shortcode: handler_custom_example_error_report.md

---
