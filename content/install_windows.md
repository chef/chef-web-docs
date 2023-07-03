+++
title = "Install Chef Infra Client on Windows Nodes"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/install_windows.html"]

[menu]
  [menu.infra]
    title = "Windows Installation Guide"
    identifier = "chef_infra/integrations/windows/install_windows.md Chef Infra Client on Windows"
    parent = "chef_infra/integrations/windows"
    weight = 20
+++

## Installation Methods

There are several methods available to install Chef Infra Client depending on the needs of your organization.

{{< readfile file="content/reusable/md/windows_install_overview.md" >}}

### Use knife CLI

{{% chef-workstation/knife_windows_summary %}}

#### Necessary Ports

{{% chef-workstation/knife_windows_winrm_ports %}}

### Use MSI Installer

A Microsoft Installer Package (MSI) is available for installing Chef Infra Client on a Windows machine at [Chef Downloads](https://www.chef.io/downloads).

{{< readfile file="content/reusable/md/windows_msiexec.md" >}}

#### ADDLOCAL Options

{{< readfile file="content/reusable/md/windows_msiexec_addlocal.md" >}}

#### Running as a Scheduled Task

On Windows, run Chef Infra Client periodically as a scheduled task. Scheduled tasks provides visibility, configurability, and reliability around log rotation and permissions. You can configure the Chef Infra Client to run as a scheduled task using the [chef_client_scheduled_task](/resources/chef_client_scheduled_task/) resource.

#### Scheduled Task Options

{{< readfile file="content/reusable/md/install_chef_client_windows_as_scheduled_task.md" >}}

### Use an Existing Process

{{< readfile file="content/reusable/md/windows_install_system_center.md" >}}

### PATH System Variable

{{< readfile file="content/reusable/md/windows_environment_variable_path.md" >}}
