---
title: service resource
resource: service
draft: false
aliases: /resource_service.html
menu:
  docs:
    title: service
    identifier: chef_infra/cookbook_reference/resources/resource_service.md service
    parent: chef_infra/cookbook_reference/resources
    weight: 950
resource_reference: true
robots: null
resource_description_list:
- markdown: Use the **service** resource to manage a service.
resource_new_in: null
handler_types: false
syntax_description: 'The service resource has the following syntax:'
syntax_code_block: "service \"tomcat\" do\n  action :start\nend"
syntax_properties_list: null
syntax_full_code_block: "service 'name' do\n  init_command         String\n  options\
  \              Array, String\n  parameters           Hash\n  pattern           \
  \   String\n  priority             Integer, String, Hash\n  reload_command     \
  \  String, false\n  restart_command      String, false\n  run_levels           Array\n\
  \  service_name         String # default value: 'name' unless specified\n  start_command\
  \        String, false\n  status_command       String, false\n  stop_command   \
  \      String, false\n  supports             Hash # default value: {\"restart\"\
  =>nil, \"reload\"=>nil, \"status\"=>nil}\n  timeout              Integer\n  user\
  \                 String\n  action               Symbol # defaults to :nothing if\
  \ not specified\nend"
syntax_full_properties_list:
- '`service` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`init_command`, `options`, `parameters`, `pattern`, `priority`, `reload_command`,
  `restart_command`, `run_levels`, `service_name`, `start_command`, `status_command`,
  `stop_command`, `supports`, `timeout`, and `user` are the properties available to
  this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :disable:
    markdown: Disable a service. This action is equivalent to a `Disabled` startup
      type on the Microsoft Windows platform. This action is not supported when using
      System Resource Controller (SRC) on the AIX platform because System Resource
      Controller (SRC) does not have a standard mechanism for enabling and disabling
      services on system boot.
  :enable:
    markdown: Enable a service at boot. This action is equivalent to an `Automatic`
      startup type on the Microsoft Windows platform. This action is not supported
      when using System Resource Controller (SRC) on the AIX platform because System
      Resource Controller (SRC) does not have a standard mechanism for enabling and
      disabling services on system boot.
  :nothing:
    markdown: Default. Do nothing with a service.
  :reload:
    markdown: Reload the configuration for this service.
  :restart:
    markdown: Restart a service.
  :start:
    markdown: Start a service, and keep it running until stopped or disabled.
  :stop:
    markdown: Stop a service.
properties_list:
- property: init_command
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The path to the init script that is associated with the service. Use

      `init_command` to prevent the need to specify overrides for the

      `start_command`, `stop_command`, and `restart_command` properties.

      When this property is not specified, Chef Infra Client will use the

      default init command for the service provider being used.'
- property: options
  ruby_type: Array, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Solaris platform only. Options to pass to the service command. See

      the `svcadm` manual for details of possible options.'
- property: parameters
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Upstart only: A hash of parameters to pass to the service command

      for use in the service definition.'
- property: pattern
  ruby_type: String
  required: false
  default_value: The value provided to service_name or the resource blocks name
  new_in: null
  description_list:
  - markdown: The pattern to look for in the process table.
- property: priority
  ruby_type: Integer, String, Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Debian platform only. The relative priority of the program for start

      and shutdown ordering. May be an integer or a Hash. An integer is

      used to define the start run levels; stop run levels are then

      100-integer. A Hash is used to define values for specific run

      levels. For example, `{ 2 => [:start, 20], 3 => [:stop, 55] }` will

      set a priority of twenty for run level two and a priority of

      fifty-five for run level three.'
- property: reload_command
  ruby_type: String, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The command used to tell a service to reload its configuration.
- property: restart_command
  ruby_type: String, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The command used to restart a service.
- property: run_levels
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'RHEL platforms only: Specific run_levels the service will run

      under.'
- property: service_name
  ruby_type: String
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the service name if it differs from the

      resource block''s name.'
- property: start_command
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The command used to start a service.
- property: status_command
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The command used to check the run status for a service.
- property: stop_command
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The command used to stop a service.
- property: supports
  ruby_type: Hash
  required: false
  default_value: '{"restart" => nil, "reload" => nil, "status" => nil}'
  new_in: null
  description_list:
  - markdown: 'A list of properties that controls how Chef Infra Client is to

      attempt to manage a service: `:restart`, `:reload`, `:status`. For

      `:restart`, the init script or other service provider can use a

      restart command; if `:restart` is not specified, Chef Infra Client

      attempts to stop and then start a service. For `:reload`, the init

      script or other service provider can use a reload command. For

      `:status`, the init script or other service provider can use a

      status command to determine if the service is running; if `:status`

      is not specified, Chef Infra Client attempts to match the

      `service_name` against the process table as a regular expression,

      unless a pattern is specified as a parameter property. Default

      value: `{ restart: false, reload: false, status: false }` for all

      platforms (except for the Red Hat platform family, which defaults to

      `{ restart: false, reload: false, status: true }`.)'
- property: timeout
  ruby_type: Integer
  required: false
  default_value: '60'
  new_in: null
  description_list:
  - markdown: 'Microsoft Windows platform only. The amount of time (in seconds) to

      wait before timing out.'
- property: user
  ruby_type: String
  required: false
  default_value: null
  new_in: '12.21'
  description_list:
  - markdown: 'systemd only: A username to run the service under.'
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Start a service
  text_blocks:
  - code_block: "service 'example_service' do\n  action :start\nend"
- example_heading: Start a service, enable it
  text_blocks:
  - code_block: "service 'example_service' do\n  supports :status => true, :restart\
      \ => true, :reload => true\n  action [ :enable, :start ]\nend"
- example_heading: Use a pattern
  text_blocks:
  - code_block: "service 'samba' do\n  pattern 'smbd'\n  action [:enable, :start]\n\
      end"
  - markdown: '**Use the :nothing common action**'
  - shortcode: resource_service_use_nothing_action.md
- example_heading: Use the retries common attribute
  text_blocks:
  - shortcode: resource_service_use_supports_attribute.md
- example_heading: Manage a service, depending on the node platform
  text_blocks:
  - code_block: "service 'example_service' do\n  case node['platform']\n  when 'centos','redhat','fedora'\n\
      \    service_name 'redhat_name'\n  else\n    service_name 'other_name'\n  end\n\
      \  supports :restart => true\n  action [ :enable, :start ]\nend"
- example_heading: Change a service provider, depending on the node platform
  text_blocks:
  - code_block: "service 'example_service' do\n  if platform?('ubuntu') && node['platform_version'].to_f\
      \ <= 14.04\n    provider Chef::Provider::Service::Upstart\n  end\n  action [:enable,\
      \ :start]\nend"
- example_heading: Reload a service using a template
  text_blocks:
  - shortcode: resource_service_subscribes_reload_using_template.md
- example_heading: Enable a service after a restart or reload
  text_blocks:
  - code_block: "service 'apache' do\n  supports :restart => true, :reload => true\n\
      \  action :enable\nend"
- example_heading: Set an IP address using variables and a template
  text_blocks:
  - shortcode: resource_template_set_ip_address_with_variables_and_template.md
- example_heading: Use a cron timer to manage a service
  text_blocks:
  - markdown: 'The following example shows how to install the crond application using

      two resources and a variable:'
  - code_block: "# the following code sample comes from the ``cron`` cookbook:\n#\
      \ https://github.com/chef-cookbooks/cron\n\ncron_package = case node['platform']\n\
      \  when 'redhat', 'centos', 'scientific', 'fedora', 'amazon'\n    node['platform_version'].to_f\
      \ >= 6.0 ? 'cronie' : 'vixie-cron'\n  else\n    'cron'\n  end\n\npackage cron_package\
      \ do\n  action :install\nend\n\nservice 'crond' do\n  case node['platform']\n\
      \  when 'redhat', 'centos', 'scientific', 'fedora', 'amazon'\n    service_name\
      \ 'crond'\n  when 'debian', 'ubuntu', 'suse'\n    service_name 'cron'\n  end\n\
      \  action [:start, :enable]\nend"
  - markdown: "where\n\n-   `cron_package` is a variable that is used to identify\
      \ which\n    platforms apply to which install packages\n-   the **package**\
      \ resource uses the `cron_package` variable to\n    determine how to install\
      \ the crond application on various nodes\n    (with various platforms)\n-  \
      \ the **service** resource enables the crond application on nodes that\n   \
      \ have Red Hat, CentOS, Red Hat Enterprise Linux, Fedora, or Amazon\n    Web\
      \ Services (AWS), and the cron service on nodes that run Debian,\n    Ubuntu,\
      \ or openSUSE"
- example_heading: Restart a service, and then notify a different service
  text_blocks:
  - shortcode: resource_service_restart_and_notify.md
- example_heading: Restart one service before restarting another
  text_blocks:
  - shortcode: resource_before_notification_restart.md
- example_heading: Stop a service, do stuff, and then restart it
  text_blocks:
  - shortcode: resource_service_stop_do_stuff_start.md
- example_heading: Control a service using the execute resource
  text_blocks:
  - shortcode: resource_execute_control_a_service.md
- example_heading: Enable a service on AIX using the mkitab command
  text_blocks:
  - shortcode: resource_service_aix_mkitab.md

---
