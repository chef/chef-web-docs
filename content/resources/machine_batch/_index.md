---
title: machine_batch resource
resource: machine_batch
draft: false
aliases: /resource_machine_batch.html
resource_reference: false
robots: noindex, nofollow
resource_description_list:
- markdown: 'Use the **machine_batch** resource to explicitly declare a parallel

    process when building machines.'
- warning:
    shortcode: EOL_provisioning.md
resource_new_in: null
handler_types: false
syntax_description: 'The syntax for using the **machine_batch** resource in a recipe
  is as follows:'
syntax_code_block: "machine_batch 'name' do\n  attribute 'value' # see properties\
  \ section below\n  ...\n  action :action # see actions section below\nend"
syntax_properties_list:
- '`machine_batch` tells Chef Infra Client to use the `Chef::Provider::MachineBatch`
  provider during a Chef Infra Client run'
- '`name` is the name of the resource block'
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
    markdown: ''
  :converge:
    markdown: Default.
  :converge_only:
    markdown: ''
  :destroy:
    markdown: ''
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :ready:
    markdown: ''
  :setup:
    markdown: ''
  :stop:
    markdown: ''
properties_list:
- property: chef_server
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The URL for the Chef Infra Server.
- property: driver
  ruby_type: Chef::Provisioning::Driver
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Use to specify the driver to be used for provisioning.
- property: files
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '...'
- property: from_recipe
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '...'
- property: machine_options
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '...'
- property: machines
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '...'
- property: max_simultaneous
  ruby_type: null
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '...'
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Set up multiple machines, in-parallel
  text_blocks:
  - code_block: "machine_batch do\n  action :setup\n  machines 'a', 'b', 'c', 'd',\
      \ 'e'\nend"
- example_heading: Converge multiple machines, in-parallel
  text_blocks:
  - code_block: "machine_batch do\n  action :converge\n  machines 'a', 'b', 'c', 'd',\
      \ 'e'\nend"
- example_heading: Stop multiple machines, in-parallel
  text_blocks:
  - code_block: "machine_batch do\n  action :stop\n  machines 'a', 'b', 'c', 'd',\
      \ 'e'\nend"
- example_heading: Destroy multiple machines, in-parallel
  text_blocks:
  - code_block: "machine_batch do\n  action :delete\n  machines 'a', 'b', 'c', 'd',\
      \ 'e'\nend"
- example_heading: Destroy all machines
  text_blocks:
  - code_block: "machine_batch do\n  machines search(:node, '*:*').map { |n| n.name\
      \ }\n  action :destroy\nend"
- example_heading: Converge multiple machine types, in-parallel
  text_blocks:
  - shortcode: resource_machine_batch_multiple_machine_types.md
- example_heading: Set up primary and secondary machines for high availability
  text_blocks:
  - code_block: "machine_batch do\n  machines %w(primary secondary web1 web2)\nend\n\
      \nmachine_batch do\n  machine 'primary' do\n    recipe 'initial_ha_setup'\n\
      \  end\nend\n\nmachine_batch do\n  machine 'secondary' do\n    recipe 'initial_ha_setup'\n\
      \  end\nend\n\nmachine_batch do\n  %w(primary secondary).each do |name|\n  \
      \  machine name do\n      recipe 'rest_of_setup'\n    end\n  end\nend"
- example_heading: Destroy EBS volumes for batch of machines, along with keys
  text_blocks:
  - markdown: 'The following example destroys an Amazon Elastic Block Store (EBS)

      volume for the specified batch of machines, along with any associated

      public and/or private keys:'
  - code_block: "['ref-volume-ebs', 'ref-volume-ebs-2'].each { |volume|\n  aws_ebs_volume\
      \ volume do\n    action :destroy\n  end\n}\n\nmachine_batch do\n  machines 'ref-machine-1',\
      \ 'ref-machine-2'\n  action :destroy\nend\n\naws_key_pair 'ref-key-pair-ebs'\
      \ do\n  action :destroy\nend"
- example_heading: Define subnets for a batch of machines on Amazon AWS
  text_blocks:
  - code_block: "require 'chef/provisioning/aws_driver'\n\nwith_driver 'aws::eu-west-1'\n\
      \  aws_vpc 'provisioning-vpc' do\n    cidr_block '10.0.0.0/24'\n    internet_gateway\
      \ true\n    main_routes '0.0.0.0/0' => :internet_gateway\n  end\n\n  aws_subnet\
      \ 'provisioning-vpc-subnet-a' do\n    vpc 'provisioning-vpc'\n    cidr_block\
      \ '10.0.0.0/26'\n    availability_zone 'eu-west-1a'\n    map_public_ip_on_launch\
      \ true\n  end\n\n  aws_subnet 'provisioning-vpc-subnet-b' do\n    vpc 'provisioning-vpc'\n\
      \    cidr_block '10.0.0.128/26'\n    availability_zone 'eu-west-1a'\n    map_public_ip_on_launch\
      \ true\n  end\n\nmachine_batch do\n  machines %w(mario-a mario-b)\n  action\
      \ :destroy\nend\n\nmachine_batch do\n  machine 'mario-a' do\n    machine_options\
      \ bootstrap_options: { subnet: 'provisioning-vpc-subnet-a' }\n  end\n\n  machine\
      \ 'mario-b' do\n    machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-b'\
      \ }\n  end\nend\n\naws_security_group 'provisioning-vpc-security-group' do\n\
      \  inbound_rules [\n    {:port => 2223, :protocol => :tcp, :sources => ['10.0.0.0/24']\
      \ },\n    {:port => 80..100, :protocol => :udp, :sources => ['1.1.1.0/24'] }\n\
      \  ]\n  outbound_rules [\n    {:port => 2223, :protocol => :tcp, :destinations\
      \ => ['1.1.1.0/16'] },\n    {:port => 8080, :protocol => :tcp, :destinations\
      \ => ['2.2.2.0/24'] }\n  ]\n  vpc 'provisioning-vpc'\nend"

---
