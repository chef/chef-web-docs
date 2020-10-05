+++
title = "Install Chef Infra Client on Windows Nodes"
draft = false

aliases = ["/install_windows.html"]

[menu]
  [menu.infra]
    title = "Chef Infra Client on Windows"
    identifier = "chef_infra/getting_started/chef_on_windows_guide/install_windows.md Chef Infra Client on Windows"
    parent = "chef_infra/getting_started/chef_on_windows_guide"
    weight = 20
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/install_windows.md)

## Nodes

{{% node %}}

{{% windows_install_overview %}}

### Use knife windows

{{% knife_windows_summary %}}

#### Ports

{{% knife_windows_winrm_ports %}}

### Msiexec.exe

{{% windows_msiexec %}}

#### ADDLOCAL Options

{{% windows_msiexec_addlocal %}}

### Use MSI Installer

A Microsoft Installer Package (MSI) is available for installing Chef Infra Client on a Microsoft Windows machine at [Chef Downloads](https://downloads.chef.io/products/infra-client?os=windows)

#### Running as a Scheduled Task

On the Microsoft Windows Chef Infra Client should be run periodically as a scheduled task. Scheduled tasks provides visibility, configurability, and reliability around log rotation and permissions. You can configure the Chef Infra Client to run as a scheduled task using the [chef_client_scheduled_task](/resources/chef_client_scheduled_task/)

#### Scheduled Task Options

{{% install_chef_client_windows_as_scheduled_task %}}

### Use an Existing Process

{{% windows_install_system_center %}}

### PATH System Variable

{{% windows_environment_variable_path %}}
