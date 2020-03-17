---
title: systemd_unit resource
resource: systemd_unit
draft: false
aliases:
- /resource_systemd_unit.html
menu:
  infra:
    title: systemd_unit
    identifier: chef_infra/cookbook_reference/resources/systemd_unit systemd_unit
    parent: chef_infra/cookbook_reference/resources
    weight: 1170
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **systemd_unit** resource to create, manage, and run [systemd

    units](https://www.freedesktop.org/software/systemd/man/systemd.html#Concepts).'
resource_new_in: '12.11'
handler_types: false
syntax_description: "The systemd_unit resource has the following syntax:\n\n``` ruby\n\
  systemd_unit 'sysstat-collect.timer' do\n  content <<-EOU.gsub(/^\\s+/, '')\n  [Unit]\n\
  \  Description=Run system activity accounting tool every 10 minutes\n\n  [Timer]\n\
  \  OnCalendar=*:00/10\n\n  [Install]\n  WantedBy=sysstat.service\n  EOU\n\n  action\
  \ [:create, :enable]\nend\n```"
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "systemd_unit 'name.service' do\n  content               \
  \ String or Hash\n  user                   String\n  triggers_reload        Boolean\n\
  end"
syntax_full_properties_list:
- '`systemd_unit` is the resource.'
- '`name` is the name of the unit. Must include the type/suffix (e.g. <span class="title-ref">name.socket</span>
  or <span class="title-ref">name.service</span>).'
- '`user` is the user account that systemd units run under. If not specified, systemd
  units will run under the system account.'
- '`content` describes the behavior of the unit'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Create a unit file, if it does not already exist.
  :delete:
    markdown: Delete a unit file, if it exists.
  :enable:
    markdown: Ensure the unit will be started after the next system boot.
  :disable:
    markdown: Ensure the unit will not be started after the next system boot.
  :nothing:
    markdown: Default. Do nothing with the unit.
  :mask:
    markdown: Ensure the unit will not start, even to satisfy dependencies.
  :unmask:
    markdown: Stop the unit from being masked and cause it to start as specified.
  :preset:
    markdown: "Restore the preset \"enable/disable\" configuration for a unit.\n *New\
      \ in Chef Client 14.0.*"
  :reenable:
    markdown: "Reenable a unit file.\n *New in Chef Client 14.0.*"
  :revert:
    markdown: "Revet to a vendor's version of a unit file.\n *New in Chef Client 14.0.*"
  :start:
    markdown: Start a unit based in its systemd unit file.
  :stop:
    markdown: Stop a running unit.
  :restart:
    markdown: Restart a unit.
  :reload:
    markdown: Reload the configuration file for a unit.
  :try_restart:
    markdown: Try to restart a unit if the unit is running.
  :reload_or_restart:
    markdown: For units that are services, this action reloads the configuration of
      the service without restarting, if possible; otherwise, it will restart the
      service so the new configuration is applied.
  :reload_or_try_restart:
    markdown: For units that are services, this action reloads the configuration of
      the service without restarting, if possible; otherwise, it will try to restart
      the service so the new configuration is applied.
properties_list:
- property: content
  ruby_type: String, Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A string or hash that contains a systemd [unit

      file](https://www.freedesktop.org/software/systemd/man/systemd.unit.html)

      definition that describes the properties of systemd-managed

      entities, such as services, sockets, devices, and so on. In Chef

      14.4 or later, repeatable options can be implemented with an array.'
- property: triggers_reload
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Specifies whether to trigger a daemon reload when creating or

      deleting a unit.'
- property: unit_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: '13.7'
  description_list:
  - markdown: 'The name of the unit file if it differs from the resource block''s

      name.'
- property: user
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The user account that the systemd unit process is run under. The

      path to the unit for that user would be something like

      `/etc/systemd/user/sshd.service`. If no user account is specified,

      the systemd unit will run under a `system` account, with the path to

      the unit being something like `/etc/systemd/system/sshd.service`.'
- property: verify
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Specifies if the unit will be verified before installation. Systemd

      can be overly strict when verifying units, so in certain cases it is

      preferable not to verify the unit.'
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
unit_file_verification: true
examples_list:
- example_heading: Create etcd systemd service unit file
  text_blocks:
  - code_block: "systemd_unit 'etcd.service' do\n  content({Unit: {\n            Description:\
      \ 'Etcd',\n            Documentation: ['https://coreos.com/etcd', 'man:etcd(1)'],\n\
      \            After: 'network.target',\n          },\n          Service: {\n\
      \            Type: 'notify',\n            ExecStart: '/usr/local/etcd',\n  \
      \          Restart: 'always',\n          },\n          Install: {\n        \
      \    WantedBy: 'multi-user.target',\n          }})\n  action :create\nend"

---
