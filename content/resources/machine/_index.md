---
title: machine resource
resource: machine
draft: false
aliases:
- /resource_machine.html
resource_reference: false
robots: noindex, nofollow
resource_description_list:
- markdown: 'Use the **machine** resource to define one (or more) machines, and then

    converge entire clusters of machines. This allows clusters to be

    maintained in a version control system and to be defined using

    multi-machine orchestration scenarios. For example, spinning up small

    test clusters and using them for continuous integration and local

    testing, building clusters that auto-scale, moving a set of machines in

    one cluster to another, building images, and so on.


    Each machine is declared as a separate application topology, defined

    using operating system- and provisioner-independent files. Recipes

    (defined in cookbooks) are used to manage them. Chef Infra Client is

    used to converge the individual nodes (machines) within the cluster.'
- warning:
    shortcode: EOL_provisioning.md
resource_new_in: null
handler_types: false
syntax_description: "The syntax for using the **machine** resource in a recipe is\
  \ as follows:\n\n``` ruby\nmachine 'name' do\n  attribute 'value' # see properties\
  \ section below\n  ...\n  action :action # see actions section below\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`machine` tells Chef Infra Client to use the `Chef::Provider::Machine` provider
  during a Chef Infra Client run'
- '`name` is the name of the resource block and also the name of the machine'
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
  :allocate:
    markdown: Use to create a machine, return its machine identifier, and then (depending
      on the provider) boot the machine to an image. This reserves the machine with
      the provider and subsequent `:allocate` actions against this machine no longer
      need to create the machine, just update it.
  :converge:
    markdown: Default. Use to create a machine, return its machine identifier, boot
      the machine to an image with the specified parameters and transport, install
      Chef Infra Client, and then converge the machine.
  :converge_only:
    markdown: Use to converge a machine, but only if the machine is in a ready state.
  :destroy:
    markdown: Use to destroy a machine.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :ready:
    markdown: Use to create a machine, return its machine identifier, and then boot
      the machine to an image with the specified parameters and transport. This machine
      is in a ready state and may be connected to (via SSH or other transport).
  :setup:
    markdown: Use to create a machine, return its machine identifier, boot the machine
      to an image with the specified parameters and transport, and then install Chef
      Infra Client. This machine is in a ready state, has Chef Infra Client installed,
      and all of the configuration data required to apply the run-list to the machine.
  :stop:
    markdown: Use to stop a machine.
properties_list:
- property: admin
  ruby_type: true, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify whether Chef Infra Client is an API client.
- property: allow_overwrite_keys
  ruby_type: true, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to overwrite the key on a machine when it is different from the

      key specified by `source_key`.'
- property: attribute
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify an attribute, and then modify that attribute with the

      specified value. The following patterns may be used to specify the

      value.


      ``` ruby

      attribute <name>, <value>

      ```


      ``` ruby

      attribute [<path>], <value>

      ```


      The following example will set attribute `a` to `b`:


      ``` ruby

      attribute ''a'', ''b''

      ```


      The following example will set attribute `node[''a''][''b''][''c'']` to

      `d` and will ignore attributes `a.b.x`, `a.b.y`, etc.:


      ``` ruby

      attribute %w[a b c], ''d''

      ```


      The following example is similar to `%w[a b c], ''d''`:


      ``` ruby

      attribute ''a'', { ''b'' => { ''c'' => ''d'' } }

      ```


      Each modified attribute should be specified individually. This

      attribute should not be used in the same recipe as `attributes`.'
- property: attributes
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify a Hash that contains all of the normal attributes to

      be applied to a machine. This attribute should not be used in the

      same recipe as `attribute`.'
- property: chef_config
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to specify a string that contains extra configuration settings

      for a machine.'
- property: chef_environment
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The name of the environment.
- property: chef_server
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The URL for the Chef Infra Server.
- property: complete
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "Use to specify if all of the normal attributes specified by this\n\
      resource represent a complete specification of normal attributes for\na machine.\
      \ When `true`, any attributes not specified will be reset\nto their default\
      \ values. For example, if a **machine** resource is\nempty and sets `complete`\
      \ to `true`, all existing attributes will be\nreset:\n\n``` ruby\nmachine \"\
      foo\" do\n  complete \"true\"\nend\n```"
- property: converge
  ruby_type: true, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to manage convergence when used with the `:create` action. Set

      to `false` to prevent convergence. Set to `true` to force

      convergence. When `nil`, the machine will converge only if something

      changes.'
- property: driver
  ruby_type: Chef::Provisioning::Driver
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify the URL for the driver to be used for provisioning.
- property: files
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "A list of files to upload. Syntax:\n`REMOTE_PATH => LOCAL_PATH_OR_HASH`.\n\
      \nFor example:\n\n``` ruby\nfiles '/remote/path.txt' => '/local/path.txt'\n\
      ```\n\nor:\n\n``` ruby\nfiles '/remote/path.txt' => {\n  :local_path => '/local/path.txt'\n\
      }\n```\n\nor:\n\n``` ruby\nfiles '/remote/path.txt' => { :content => 'foo' }\n\
      ```"
- property: from_image
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify an image created by the **machine_image** resource.
- property: machine_options
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: A Hash that is specifies driver options.
- property: name
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The name of the machine.
- property: ohai_hints
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An Ohai hint to be set on the target node. For example:

      `''ec2'' => { ''a'' => ''b'' } creates file ec2.json with json contents { ''a'':
      ''b'' }`.'
- property: private_key_options
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to generate a private key of the desired size, type, and so on.
- property: public_key_format
  ruby_type: String
  required: false
  default_value: pem
  new_in: null
  description_list:
  - markdown: 'Use to specify the format of a public key. Possible values: `pem`

      and `der`.'
- property: public_key_path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The path to a public key.
- property: raw_json
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "The machine as JSON data. For example:\n\n``` javascript\n{\n  \"name\"\
      : \"node1\",\n  \"chef_environment\": \"_default\",\n  \"json_class\": \"Chef::Node\"\
      ,\n  \"automatic\": {\n    \"languages\": {\n      \"ruby\": {\n        ...\n\
      \      },\n    ...\n  ...\n}\n```"
- property: recipe
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to add a recipe to the run-list for a machine. Use this property

      multiple times to add multiple recipes to a run-list. Use this

      property along with `role` to define a run-list. The order in which

      the `recipe` and `role` properties are specified will determine the

      order in which they are added to the run-list. This property should

      not be used in the same recipe as `run_list`. For example:


      ``` ruby

      recipe ''foo''

      role ''bar''

      recipe ''baz''

      ```'
- property: remove_recipe
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to remove a recipe from the run-list for the machine.
- property: remove_role
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to remove a role from the run-list for the machine.
- property: remove_tag
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to remove a tag.
- property: role
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to add a role to the run-list for the machine. Use this property

      multiple times to add multiple roles to a run-list. Use this

      property along with `recipe` to define a run-list. The order in

      which the `recipe` and `role` properties are specified will

      determine the order in which they are added to the run-list. This

      property should not be used in the same recipe as `run_list`. For

      example:


      ``` ruby

      recipe ''foo''

      role ''bar''

      recipe ''baz''

      ```'
- property: run_list
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An array of strings that specifies the run-list to apply to a

      machine. This property should not be used in the same recipe as

      `recipe` and `role`. For example:


      ``` ruby

      [ ''recipe[COOKBOOK::RECIPE]'',''COOKBOOK::RECIPE'',''role[NAME]'' ]

      ```'
- property: source_key
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to copy a private key, but apply a different `format` and

      `password`. Use in conjunction with `source_key_pass_phrase` and

      `source_key_path`.'
- property: source_key_pass_phrase
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The pass phrase for the private key. Use in conjunction with

      `source_key` and `source_key_path`.'
- property: source_key_path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The path to the private key. Use in conjunction with `source_key`

      and `source_key_pass_phrase`.'
- property: tag
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to add a tag.
- property: tags
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Use to add one (or more) tags. This will remove any tag currently

      associated with the machine. For example: `tags :a, :b, :c`.'
- property: validator
  ruby_type: true, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify if Chef Infra Client is a chef-validator.
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
- example_heading: Build machines dynamically
  text_blocks:
  - code_block: "machine 'mario' do\n  recipe 'postgresql'\n  recipe 'mydb'\n  tag\
      \ 'mydb_master'\nend\n\nnum_webservers = 1\n\n1.upto(num_webservers) do |i|\n\
      \  machine \"luigi#{i}\" do\n    recipe 'apache'\n    recipe 'mywebapp'\n  end\n\
      end"
- example_heading: Get a remote file onto a new machine
  text_blocks:
  - shortcode: resource_machine_file_get_remote_file.md
- example_heading: Build machines that depend on each other
  text_blocks:
  - markdown: 'The following example shows how to create two identical machines, both

      of which cannot exist without the other. The first **machine** resource

      block creates the first machine by omitting the recipe that requires the

      other machine to be defined. The second resource block creates the

      second machine; because the first machine exists, both recipes can be

      run. The third resource block applies the second recipe to the first

      machine:'
  - code_block: "machine 'server_a' do\n  recipe 'base_recipes'\nend\n\nmachine 'server_b'\
      \ do\n  recipe 'base_recipes'\n  recipe 'theserver'\nend\n\nmachine 'server_a'\
      \ do\n  recipe 'theserver'\nend"
- example_heading: Use a loop to build many machines
  text_blocks:
  - code_block: "1.upto(10) do |i|\n  machine \"hadoop#{i}\" do\n    recipe 'hadoop'\n\
      \  end\nend"
- example_heading: Converge multiple machine types, in-parallel
  text_blocks:
  - shortcode: resource_machine_batch_multiple_machine_types.md
- example_heading: Define machine_options for a driver
  text_blocks:
  - code_block: "require 'chef/provisioning_driver'\n\nmachine 'wario' do\n  recipe\
      \ 'apache'\n\n  machine_options :driver_options => {\n   :base_image => {\n\
      \     :name => 'ubuntu',\n     :repository => 'ubuntu',\n     :tag => '14.04'\n\
      \     },\n\n   :command => '/usr/sbin/httpd'\n  }\n\nend"
  - markdown: 'where `provisioning_driver` and `:driver_options` specify the actual

      `driver` that is being used to build the machine.'
- example_heading: Build a machine from a machine image
  text_blocks:
  - shortcode: resource_machine_image_add_apache_to_image.md
- example_heading: Set up a VPC, route table, key pair, and machine for Amazon AWS
  text_blocks:
  - code_block: "require 'chef/provisioning/aws_driver'\n\nwith_driver 'aws::eu-west-1'\n\
      \naws_vpc 'test-vpc' do\n  cidr_block '10.0.0.0/24'\n  internet_gateway true\n\
      end\n\naws_route_table 'ref-public1' do\n  vpc 'test-vpc'\n  routes '0.0.0.0/0'\
      \ => :internet_gateway\nend\n\naws_key_pair 'ref-key-pair'\n\nm = machine 'test'\
      \ do\n  machine_options bootstrap_options: { key_name: 'ref-key-pair' }\nend"

---
