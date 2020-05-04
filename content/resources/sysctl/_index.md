---
resource_reference: true
common_resource_functionality_multiple_packages: false
properties_shortcode: 
resources_common_guards: true
resources_common_notification: true
resources_common_properties: true
title: sysctl resource
resource: sysctl
aliases:
- "/resource_sysctl.html"
menu:
  infra:
    title: sysctl
    identifier: chef_infra/cookbook_reference/resources/sysctl sysctl
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: 'Use the **sysctl** resource to set or remove kernel parameters using
    the

    `sysctl` command line tool and configuration files in the system''s

    `sysctl.d` directory. Configuration files managed by this resource are

    named `99-chef-KEYNAME.conf`. If an existing value was already set, it

    will be backed up to the node and restored if the `:remove` action is

    used later.'
resource_new_in: '14.0'
syntax_full_code_block: |-
  sysctl 'name' do
    comment           Array, String # default value: []
    conf_dir          String # default value: "/etc/sysctl.d"
    ignore_error      true, false # default value: false
    key               String # default value: 'name' unless specified
    value             Array, String, Integer, Float
    action            Symbol # defaults to :apply if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`sysctl` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`comment`, `conf_dir`, `ignore_error`, `key`, and `value` are the properties available
  to this resource."
actions_list:
  :apply:
    markdown: Default. Set the kernel parameter and update the `sysctl` settings.
  :remove:
    markdown: Remove the kernel parameter and update the `sysctl` settings.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: comment
  ruby_type: Array, String
  required: false
  default_value: "[]"
  new_in: '15.8'
  description_list:
  - markdown: Comments, placed above the resource setting in the generated file. For
      multi-line comments, use an array of strings, one per line.
- property: conf_dir
  ruby_type: String
  required: false
  default_value: "/etc/sysctl.d"
  description_list:
  - markdown: The configuration directory to write the config to.
- property: ignore_error
  ruby_type: true, false
  required: false
  default_value: 'false'
  description_list:
  - markdown: Ignore any errors when setting the value on the command line.
- property: key
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: The kernel parameter key in dotted format if it differs from the resource
      block's name.
- property: value
  ruby_type: Array, String, Integer, Float
  required: true
  description_list:
  - markdown: The value to set.
examples: "
  Set vm.swappiness\n\n  ``` ruby\n  sysctl 'vm.swappiness' do\n  \
  \  value 19\n  end\n  ```\n\n  Remove kernel.msgmax\n\n  Note: This only removes\
  \ the sysctl.d config for kernel.msgmax. The value\n  will be set back to the kernel\
  \ default value.\n\n  ``` ruby\n  sysctl 'kernel.msgmax' do\n    action :remove\n\
  \  end\n  ```\n\n  Adding Comments to sysctl configuration files\n\n  ``` ruby\n\
  \  sysctl 'vm.swappiness' do\n    value 19\n    comment \"define how aggressively\
  \ the kernel will swap memory pages.\"\n  end\n  ```\n\n  This produces /etc/sysctl.d/99-chef-vm.swappiness.conf\
  \ as follows:\n\n  ``` none\n  # define how aggressively the kernel will swap memory\
  \ pages.\n  vm.swappiness = 1\n  ```\n\n  Converting sysctl settings from shell\
  \ scripts\n\n  Example of existing settings:\n\n  `fs.aio-max-nr = 1048576` `net.ipv4.ip_local_port_range\
  \ = 9000 65500`\n  `kernel.sem = 250 32000 100 128`\n\n  Converted to sysctl resources:\n\
  \n  ``` ruby\n  sysctl 'fs.aio-max-nr' do\n    value '1048576'\n  end\n\n  sysctl\
  \ 'net.ipv4.ip_local_port_range' do\n    value '9000 65500'\n  end\n\n  sysctl 'kernel.sem'\
  \ do\n    value '250 32000 100 128'\n  end\n  ```\n"

---
