---
title: machine_image resource
resource: machine_image
draft: false
aliases:
- /resource_machine_image.html
resource_reference: false
robots: noindex, nofollow
resource_description_list:
- markdown: 'Use the **machine_image** resource to define a machine image. This

    image may then be used by the **machine** resource when building

    machines.'
- warning:
    shortcode: EOL_provisioning.md
resource_new_in: null
handler_types: false
syntax_description: "The syntax for using the **machine_image** resource in a recipe\
  \ is as\nfollows:\n\n``` ruby\nmachine_image 'name' do\n  attribute 'value' # see\
  \ properties section below\n  ...\n  action :action # see actions section below\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`machine_image` tells Chef Infra Client to use the `Chef::Provider::MachineImage`
  provider during a Chef Infra Client run'
- '`name` is the name of the resource block and also the name of the machine image'
- '`attribute` is zero (or more) of the properties that are available for this resource'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :archive:
    markdown: Use to archive a machine image.
  :create:
    markdown: Default. Use to create a machine image.
  :destroy:
    markdown: Use to destroy a machine image.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: attributes
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify a hash of attributes to be applied to the machine

      image.'
- property: chef_environment
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The name of the environment.
- property: complete
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify if all of the attributes specified in `attributes`

      represent a complete specification for the machine image. When true,

      any attributes not specified in `attributes` will be reset to their

      default values.'
- property: image_options
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify options that are used with this machine image.
- property: name
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The name of the machine image.
- property: raw_json
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The machine image as JSON data. For example:


      ``` javascript

      {


      }

      ```'
- property: recipe
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to add a recipe to the run-list for the machine image. Each

      `recipe` adds a single recipe to the run-list. The order in which

      `recipe` defines the run-list is the order in which Chef will

      execute the run-list on the machine image.'
- property: remove_recipe
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to remove a recipe from the run-list for the machine image.
- property: remove_role
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to remove a role from the run-list for the machine image.
- property: role
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to add a role to the run-list for the machine image.
- property: run_list
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the run-list to be applied to the machine image. See

      [About Run Lists](/run_lists/) for more information.'
- property: tags
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify the list of tags to be applied to the machine image.

      Any tag not specified in this list will be removed.'
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
resources_common_properties: false
resources_common_notification: false
resources_common_guards: false
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Build a machine from a machine image
  text_blocks:
  - shortcode: resource_machine_image_add_apache_to_image.md

---
