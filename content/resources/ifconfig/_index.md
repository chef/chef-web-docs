---
title: ifconfig resource
resource: ifconfig
draft: false
aliases:
- /resource_ifconfig.html
menu:
  docs:
    title: ifconfig
    identifier: chef_infra/cookbook_reference/resources/ifconfig ifconfig
    parent: chef_infra/cookbook_reference/resources
    weight: 460
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **ifconfig** resource to manage interfaces on Unix and Linux

    systems.'
resource_new_in: null
handler_types: false
syntax_description: "An **ifconfig** resource block manages interfaces, such as a\
  \ static IP\naddress:\n\n``` ruby\nifconfig '33.33.33.80' do\n  device 'eth1'\n\
  end\n```"
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "ifconfig 'name' do\n  bcast             String\n  bonding_opts\
  \      String\n  bootproto         String\n  device            String\n  ethtool_opts\
  \      String\n  family            String # default value: \"inet\"\n  gateway \
  \          String\n  hwaddr            String\n  inet_addr         String\n  mask\
  \              String\n  master            String\n  metric            String\n\
  \  mtu               String\n  network           String\n  onboot            String\n\
  \  onparent          String\n  slave             String\n  target            String\
  \ # default value: 'name' unless specified\n  vlan              String\n  action\
  \            Symbol # defaults to :add if not specified\nend"
syntax_full_properties_list:
- '`ifconfig` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`bcast`, `bonding_opts`, `bootproto`, `device`, `ethtool_opts`, `family`, `gateway`,
  `hwaddr`, `inet_addr`, `mask`, `master`, `metric`, `mtu`, `network`, `onboot`, `onparent`,
  `slave`, `target`, and `vlan` are the properties available to this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :add:
    markdown: Default. Run ifconfig to configure a network interface and (on some
      platforms) write a configuration file for that network interface.
  :delete:
    markdown: Run ifconfig to disable a network interface and (on some platforms)
      delete that network interface's configuration file.
  :disable:
    markdown: Run ifconfig to disable a network interface.
  :enable:
    markdown: Run ifconfig to enable a network interface.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: bcast
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The broadcast address for a network interface. On some platforms

      this property is not set using ifconfig, but instead is added to the

      startup configuration file for the network interface.'
- property: bonding_opts
  ruby_type: String
  required: false
  default_value: null
  new_in: '13.4'
  description_list:
  - markdown: 'Bonding options to pass via `BONDING_OPTS` on RHEL and CentOS. For

      example: `mode=active-backup miimon=100`'
- property: bootproto
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The boot protocol used by a network interface.
- property: device
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The network interface to be configured.
- property: ethtool_opts
  ruby_type: String
  required: false
  default_value: null
  new_in: '13.4'
  description_list:
  - markdown: 'Options to be passed to ethtool(8). For example:

      `-A eth0 autoneg off rx off tx off`.'
- property: family
  ruby_type: String
  required: false
  default_value: '"inet"'
  new_in: '14.0'
  description_list:
  - markdown: 'Networking family option for Debian-based systems; for example:

      `inet` or `inet6`.'
- property: gateway
  ruby_type: String
  required: false
  default_value: null
  new_in: '14.4'
  description_list:
  - markdown: The gateway to use for the interface.
- property: hwaddr
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The hardware address for the network interface.
- property: inet_addr
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The Internet host address for the network interface.
- property: mask
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The decimal representation of the network mask. For example:

      `255.255.255.0`.'
- property: master
  ruby_type: String
  required: false
  default_value: null
  new_in: '13.4'
  description_list:
  - markdown: 'Specifies the channel bonding interface to which the Ethernet

      interface is linked.'
- property: metric
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The routing metric for the interface.
- property: mtu
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The maximum transmission unit (MTU) for the network interface.
- property: network
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The address for the network interface.
- property: onboot
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Bring up the network interface on boot.
- property: onparent
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Bring up the network interface when its parent interface is brought

      up.'
- property: slave
  ruby_type: String
  required: false
  default_value: null
  new_in: '13.4'
  description_list:
  - markdown: 'When set to `yes`, this device is controlled by the channel bonding

      interface that is specified via the `master` property.'
- property: target
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The IP address that is to be assigned to the network interface. If

      not specified we''ll use the resource''s name.'
- property: vlan
  ruby_type: String
  required: false
  default_value: null
  new_in: '14.4'
  description_list:
  - markdown: The VLAN to assign the interface to.
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
- example_heading: Configure a network interface
  text_blocks:
  - code_block: "ifconfig \"33.33.33.80\" do\n  bootproto \"dhcp\"\n  device \"eth1\"\
      \nend"
  - markdown: 'will create the following interface:


      ``` none

      vagrant@default-ubuntu-1204:~cat /etc/network/interfaces.d/ifcfg-eth1

      iface eth1 inet dhcp

      ```'
- example_heading: Specify a boot protocol
  text_blocks:
  - code_block: "ifconfig '192.186.0.1' do\n  device 'eth0'\nend"
- example_heading: Specify a static IP address
  text_blocks:
  - code_block: "ifconfig \"33.33.33.80\" do\n  device \"eth1\"\nend"
  - markdown: "will create the following interface:\n\n``` none\niface eth1 inet static\n\
      \  address 33.33.33.80\n```"
- example_heading: Update a static IP address with a boot protocol
  text_blocks:
  - code_block: "ifconfig \"33.33.33.80\" do\n  bootproto \"dhcp\"\n  device \"eth1\"\
      \nend"
  - markdown: "will update the interface from `static` to `dhcp`:\n\n``` none\niface\
      \ eth1 inet dhcp\n  address 33.33.33.80\n```"

---
