+++
title = "Chef for Windows"
draft = false

[menu]
  [menu.client_19]
    title = "Chef for Windows"
    identifier = "integrations/windows/windows.md Chef for Windows"
    parent = "integrations/windows"
    weight = 10
+++
<!-- markdownlint-disable-file MD033 -->
## Overview

The Chef Infra Client has specific components that are designed to
support unique aspects of the Windows platform, including
PowerShell, PowerShell DSC, and Internet Information Services (IIS).

{{< readfile file="content/client/19/reusable/md/windows_install_overview.md" >}}

## Setting up Windows Workstations

To set up your Windows workstation follow the steps on [Chef for
Windows](https://docs.chef.io/workstation/latest/install/)

## Install Chef Infra Client on Windows Nodes

{{< readfile file="content/client/19/reusable/md/chef_client_summary.md" >}}

This command has the following syntax:

```bash
chef-client OPTION VALUE OPTION VALUE ...
```

This command has the following option specific to Windows:

`-A`, `--fatal-windows-admin-check`

:   Cause a Chef Infra Client run to fail when Chef Infra Client does
    not have administrator privileges in Windows.

### System Requirements

The recommended minimum amount of RAM available to Chef Infra Client
during a Chef Infra Client run is 512MB. Each node and workstation must
have access to Chef Infra Server using HTTPS. The Chef Infra Client can be
used to manage machines that run on the following versions of Microsoft
Windows:

| Operating System | Architecture | Version                                                 |
| ---------------- | ------------ | ------------------------------------------------------- |
| Windows          | `x64`        | `10`, `11`, `Server 2016`, `Server 2019`, `Server 2022` |

After Chef Infra Client is installed, it's located at `C:\opscode`. The
After Chef Infra Client is installed, it's located at `C:\hab`. The
main configuration file for Chef Infra Client is located at
`C:\chef\client.rb`.

### Information for Windows Users

#### Run With Elevated Privileges

{{< readfile file="content/client/19/reusable/md/workstation/ctl_chef_client_elevated_privileges.md" >}}

{{< readfile file="content/client/19/reusable/md/workstation/ctl_chef_client_elevated_privileges_windows.md" >}}

#### Spaces and Directories

{{< readfile file="content/client/19/reusable/md/windows_spaces_and_directories.md" >}}

#### Top-level Directory Names

{{< readfile file="content/client/19/reusable/md/windows_top_level_directory_names.md" >}}

#### PATH System Variable

{{< readfile file="content/client/19/reusable/md/windows_environment_variable_path.md" >}}

#### Proxy Settings

{{< readfile file="content/client/19/reusable/md/proxy_windows.md" >}}

### Remotely administering nodes

{{< readfile file="content/client/19/reusable/md/workstation/knife_windows_summary.md" >}}

For more information, see the [`knife windows` documentation](https://docs.chef.io/workstation/latest/tools/knife/knife_windows/).

#### Ports

{{< readfile file="content/client/19/reusable/md/workstation/knife_windows_winrm_ports.md" >}}

### Install Chef Infra Client using the MSI Installer

A Microsoft Installer Package (MSI) is available for installing Chef
Infra Client on a Windows machine from [Chef Downloads](https://www.chef.io/downloads).

#### Msiexec.exe

{{< readfile file="content/client/19/reusable/md/windows_msiexec.md" >}}

#### ADDLOCAL Options

{{< readfile file="content/client/19/reusable/md/windows_msiexec_addlocal.md" >}}

#### Enable as a Scheduled Task

{{< readfile file="content/client/19/reusable/md/install_chef_client_windows_as_scheduled_task.md" >}}

### Install Chef Infra Client using an Existing Process

{{< readfile file="content/client/19/reusable/md/windows_install_system_center.md" >}}

## Windows Cookbooks

Some of the most popular Chef-maintained cookbooks that contain custom
resources useful when configuring machines running Windows are
listed below:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Cookbook</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://github.com/chef-cookbooks/iis">iis Cookbook</a></td>
<td>The <code>iis</code> cookbook is used to install and configure Internet Information Services (IIS).</td>
</tr>
<tr>
<td><a href="https://github.com/chef-cookbooks/iis_urlrewrite">iis_urlrewrite Cookbook</a></td>
<td>This cookbook downloads and installs the IIS URL Rewrite 2.0 extension into Microsoft Internet Information Server.</td>
</tr>
<tr>
<td><a href="https://github.com/chef-cookbooks/powershell">PowerShell Cookbook</a></td>
<td>Installs and configures PowerShell 2.0, 3.0, 4.0 or 5.0.</td>
</tr>
<tr>
<td><a href="https://github.com/chef-cookbooks/vcruntime">Microsoft Visual C++ Runtime Cookbook</a></td>
<td>Installs Microsoft Visual C++ runtime version 6 (2005), 9 (2008), 10 (2010), 11 (2012), 12 (2013), 14 (2015) or 15 (2017) on Windows.</td>
</tr>
<tr>
<td><a href="https://github.com/chef-cookbooks/mingw">Mingw Cookbook</a></td>
<td>Installs <code>msys/mingw</code> compiler toolchains on windows.</td>
</tr>
<tr>
<td><a href="https://github.com/chef-cookbooks/webpi">Webpi Cookbook</a></td>
<td>The <code>webpi</code> cookbook is used to run the Microsoft Web Platform Installer (WebPI).</td>
</tr>
</tbody>
</table>

### Community Supported Windows Projects

Two community supports two provisioners for Kitchen:

- [kitchen-dsc](https://github.com/test-kitchen/kitchen-dsc)
- [kitchen-pester](https://github.com/test-kitchen/kitchen-pester)

## Windows Resources

{{< readfile file="content/client/19/reusable/md/resources_common.md" >}}

### Windows Resources

Chef Infra provides a growing number of Windows-specific resources.

- [cab_package](/client/19/resources/bundled/cab_package/)
- [chef_client_scheduled_task](/client/19/resources/bundled/chef_client_scheduled_task/)
- [chocolatey_config](/client/19/resources/bundled/chocolatey_config/)
- [chocolatey_feature](/client/19/resources/bundled/chocolatey_feature/)
- [chocolatey_package](/client/19/resources/bundled/chocolatey_package/)
- [chocolatey_source](/client/19/resources/bundled/chocolatey_package/)
- [dsc_resource](/client/19/resources/bundled/dsc_resource/)
- [dsc_script](/client/19/resources/bundled/dsc_script/)
- [msu_package](/client/19/resources/bundled/msu_package/)
- [powershell_package_source](/client/19/resources/bundled/powershell_package_source/)
- [powershell_package](/client/19/resources/bundled/powershell_package/)
- [powershell_script](/client/19/resources/bundled/powershell_script/)
- [registry_key](/client/19/resources/bundled/registry_key/)
- [windows_ad_join](/client/19/resources/bundled/windows_ad_join/)
- [windows_audit_policy](/client/19/resources/bundled/windows_audit_policy/)
- [windows_auto_run](/client/19/resources/bundled/windows_auto_run/)
- [windows_certificate](/client/19/resources/bundled/windows_certificate/)
- [windows_defender_exclusion](/client/19/resources/bundled/windows_defender_exclusion/)
- [windows_defender](/client/19/resources/bundled/windows_defender/)
- [windows_dfs_folder](/client/19/resources/bundled/windows_dfs_folder/)
- [windows_dfs_namespace](/client/19/resources/bundled/windows_dfs_namespace/)
- [windows_dfs_server](/client/19/resources/bundled/windows_dfs_server/)
- [windows_dns_record](/client/19/resources/bundled/windows_dns_record/)
- [windows_dns_zone](/client/19/resources/bundled/windows_dns_zone/)
- [windows_env](/client/19/resources/bundled/windows_env/)
- [windows_feature_dism](/client/19/resources/bundled/windows_feature_dism/)
- [windows_feature_powershell](/client/19/resources/bundled/windows_feature_powershell/)
- [windows_feature](/client/19/resources/bundled/windows_feature/)
- [windows_firewall_profile](/client/19/resources/bundled/windows_firewall_profile/)
- [windows_firewall_rule](/client/19/resources/bundled/windows_firewall_rule/)
- [windows_font](/client/19/resources/bundled/windows_font/)
- [windows_package](/client/19/resources/bundled/windows_package/)
- [windows_pagefile](/client/19/resources/bundled/windows_pagefile/)
- [windows_path](/client/19/resources/bundled/windows_path/)
- [windows_printer_port](/client/19/resources/bundled/windows_printer_port/)
- [windows_printer](/client/19/resources/bundled/windows_printer/)
- [windows_security_policy](/client/19/resources/bundled/windows_security_policy/)
- [windows_service](/client/19/resources/bundled/windows_service/)
- [windows_share](/client/19/resources/bundled/windows_share/)
- [windows_shortcut](/client/19/resources/bundled/windows_shortcut/)
- [windows_task](/client/19/resources/bundled/windows_task/)
- [windows_uac](/client/19/resources/bundled/windows_uac/)
- [windows_user_privilege](/client/19/resources/bundled/windows_user_privilege/)
- [windows_workgroup](/client/19/resources/bundled/windows_workgroup/)

### Windows Compatible Resources

The most popular core resources in Chef Infra Client work the same way
in Windows as they do on any UNIX or Linux-based platform.

<!-- markdownlint-disable MD059 -->

- [cookbook_file](/client/19/resources/bundled/cookbook_file/)
- [directory](/client/19/resources/bundled/directory/)
- [execute](/client/19/resources/bundled/execute/)
- [file](/client/19/resources/bundled/file/)
- [group](/client/19/resources/bundled/group/)
- [http_request](/client/19/resources/bundled/http_request/)
- [link](/client/19/resources/bundled/link/)
- [mount](/client/19/resources/bundled/mount/)
- [package](/client/19/resources/bundled/package/)
- [remote_directory](/client/19/resources/bundled/remote_directory/)
- [remote_file](/client/19/resources/bundled/remote_file/)
- [ruby_block](/client/19/resources/bundled/ruby_block/)
- [service](/client/19/resources/bundled/service/)
- [template](/client/19/resources/bundled/template/)
- [user](/client/19/resources/bundled/user/)

The file-based resources have attributes that support unique
requirements within the Windows platform, including `inherits`
(for file inheritance), `mode` (for octal modes), and `rights` (for
access control lists, or ACLs).

- [cookbook_file](/client/19/resources/bundled/cookbook_file/)
- [file](/client/19/resources/bundled/file/)
- [remote_file](/client/19/resources/bundled/remote_file/)
- [template](/client/19/resources/bundled/template/)
