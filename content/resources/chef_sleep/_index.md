---
title: chef_sleep resource
resource: chef_sleep
aliases:
- "/resource_chef_sleep.html"
menu:
  infra:
    title: chef_sleep
    identifier: chef_infra/cookbook_reference/resources/chef_sleep chef_sleep
    parent: chef_infra/cookbook_reference/resources
resource_reference: true
resource_description_list:
- markdown: 'The **chef_sleep** resource will pause a Chef Infra Client run for a

    set number of seconds. Only use this resource when a command or service

    exits successfully but is not ready for the next step in a recipe.'
resource_new_in: '15.5'
syntax_full_code_block: |-
  chef_sleep 'name' do
    seconds      String, Integer # default value: 'name' unless specified
    action       Symbol # defaults to :sleep if not specified
  end
syntax_properties_list: 
syntax_full_properties_list:
- "`chef_sleep` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`seconds` is the property available to this resource."
actions_list:
  :sleep:
    markdown: Pause the Chef Infra Client run for a specified number of seconds.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: seconds
  ruby_type: String, Integer
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: The number of seconds to sleep.
examples_list:
- example_heading: Sleep for 10 seconds
  text_blocks:
  - code_block: chef_sleep '10'
- example_heading: Sleep for 10 seconds with a descriptive resource name for logging
  text_blocks:
  - code_block: "chef_sleep 'wait for the service to start' do\n  seconds 10\nend"
- example_heading: 'Use a notification from another resource to sleep only when

    necessary'
  text_blocks:
  - code_block: "service 'Service that is slow to start and reports as started' do\n\
      \  service_name 'my_database'\n  action :start\n  notifies :sleep, chef_sleep['wait\
      \ for service start']\nend\n\nchef_sleep 'wait for service start' do\n  seconds\
      \ 30\n  action :nothing\nend"

---
