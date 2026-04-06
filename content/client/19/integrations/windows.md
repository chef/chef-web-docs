+++
title = "Chef for Windows"
draft = false

[menu]
  [menu.integrations]
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

{{< readfile file="content/reusable/md/windows_install_overview.md" >}}

## Setting up Windows Workstations

To set up your Windows workstation follow the steps on [Chef for
Windows](https://docs.chef.io/workstation/install_workstation/)

## Install Chef Infra Client on Windows Nodes

{{< readfile file="content/reusable/md/chef_client_summary.md" >}}

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

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Operating System</th>
<th>Architecture</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr>
<td>Windows</td>
<td><code>x86</code>, <code>x64</code></td>
<td><code>8.1</code>, <code>2012</code>, <code>2012 R2</code>, <code>2016</code>, <code>10 (all channels except "insider" builds)</code>, <code>2019 (Long-term servicing channel (LTSC), both Desktop Experience and Server Core)</code></td>
</tr>
</tbody>
</table>

After Chef Infra Client is installed, it's located at `C:\opscode`. The
main configuration file for Chef Infra Client is located at
`C:\chef\client.rb`.

### Information for Windows Users

#### Run With Elevated Privileges

{{< readfile file="content/reusable/md/workstation/ctl_chef_client_elevated_privileges.md" >}}

{{< readfile file="content/reusable/md/workstation/ctl_chef_client_elevated_privileges_windows.md" >}}

#### Spaces and Directories

{{< readfile file="content/reusable/md/windows_spaces_and_directories.md" >}}

#### Top-level Directory Names

{{< readfile file="content/reusable/md/windows_top_level_directory_names.md" >}}

#### PATH System Variable

{{< readfile file="content/reusable/md/windows_environment_variable_path.md" >}}

#### Proxy Settings

{{< readfile file="content/reusable/md/proxy_windows.md" >}}

### Remotely administering nodes

{{< readfile file="content/reusable/md/workstation/knife_windows_summary.md" >}}

For more information, see the [`knife windows` documentation](https://docs.chef.io/workstation/knife_windows/).

#### Ports

{{< readfile file="content/reusable/md/workstation/knife_windows_winrm_ports.md" >}}

### Install Chef Infra Client using the MSI Installer

A Microsoft Installer Package (MSI) is available for installing Chef
Infra Client on a Windows machine from [Chef Downloads](https://www.chef.io/downloads).

#### Msiexec.exe

{{< readfile file="content/reusable/md/windows_msiexec.md" >}}

#### ADDLOCAL Options

{{< readfile file="content/reusable/md/windows_msiexec_addlocal.md" >}}

#### Enable as a Scheduled Task

{{< readfile file="content/reusable/md/install_chef_client_windows_as_scheduled_task.md" >}}

### Install Chef Infra Client using an Existing Process

{{< readfile file="content/reusable/md/windows_install_system_center.md" >}}

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

{{< readfile file="content/reusable/md/resources_common.md" >}}

### Windows Resources

Chef Infra provides a growing number of Windows-specific resources.

- [cab_package](/resources/bundled/cab_package/)
- [chef_client_scheduled_task](/resources/bundled/chef_client_scheduled_task/)
- [chocolatey_config](/resources/bundled/chocolatey_config/)
- [chocolatey_feature](/resources/bundled/chocolatey_feature/)
- [chocolatey_package](/resources/bundled/chocolatey_package/)
- [chocolatey_source](/resources/bundled/chocolatey_package/)
- [dsc_resource](/resources/bundled/dsc_resource/)
- [dsc_script](/resources/bundled/dsc_script/)
- [msu_package](/resources/bundled/msu_package/)
- [powershell_package_source](/resources/bundled/powershell_package_source/)
- [powershell_package](/resources/bundled/powershell_package/)
- [powershell_script](/resources/bundled/powershell_script/)
- [registry_key](/resources/bundled/registry_key/)
- [windows_ad_join](/resources/bundled/windows_ad_join/)
- [windows_audit_policy](/resources/bundled/windows_audit_policy/)
- [windows_auto_run](/resources/bundled/windows_auto_run/)
- [windows_certificate](/resources/bundled/windows_certificate/)
- [windows_defender_exclusion](/resources/bundled/windows_defender_exclusion/)
- [windows_defender](/resources/bundled/windows_defender/)
- [windows_dfs_folder](/resources/bundled/windows_dfs_folder/)
- [windows_dfs_namespace](/resources/bundled/windows_dfs_namespace/)
- [windows_dfs_server](/resources/bundled/windows_dfs_server/)
- [windows_dns_record](/resources/bundled/windows_dns_record/)
- [windows_dns_zone](/resources/bundled/windows_dns_zone/)
- [windows_env](/resources/bundled/windows_env/)
- [windows_feature_dism](/resources/bundled/windows_feature_dism/)
- [windows_feature_powershell](/resources/bundled/windows_feature_powershell/)
- [windows_feature](/resources/bundled/windows_feature/)
- [windows_firewall_profile](/resources/bundled/windows_firewall_profile/)
- [windows_firewall_rule](/resources/bundled/windows_firewall_rule/)
- [windows_font](/resources/bundled/windows_font/)
- [windows_package](/resources/bundled/windows_package/)
- [windows_pagefile](/resources/bundled/windows_pagefile/)
- [windows_path](/resources/bundled/windows_path/)
- [windows_printer_port](/resources/bundled/windows_printer_port/)
- [windows_printer](/resources/bundled/windows_printer/)
- [windows_security_policy](/resources/bundled/windows_security_policy/)
- [windows_service](/resources/bundled/windows_service/)
- [windows_share](/resources/bundled/windows_share/)
- [windows_shortcut](/resources/bundled/windows_shortcut/)
- [windows_task](/resources/bundled/windows_task/)
- [windows_uac](/resources/bundled/windows_uac/)
- [windows_user_privilege](/resources/bundled/windows_user_privilege/)
- [windows_workgroup](/resources/bundled/windows_workgroup/)

### Windows Compatible Resources

The most popular core resources in Chef Infra Client work the same way
in Windows as they do on any UNIX or Linux-based platform.

<!-- markdownlint-disable MD059 -->

- [cookbook_file](/resources/bundled/cookbook_file/)
- [directory](/resources/bundled/directory/)
- [execute](/resources/bundled/execute/)
- [file](/resources/bundled/file/)
- [group](/resources/bundled/group/)
- [http_request](/resources/bundled/http_request/)
- [link](/resources/bundled/link/)
- [mount](/resources/bundled/mount/)
- [package](/resources/bundled/package/)
- [remote_directory](/resources/bundled/remote_directory/)
- [remote_file](/resources/bundled/remote_file/)
- [ruby_block](/resources/bundled/ruby_block/)
- [service](/resources/bundled/service/)
- [template](/resources/bundled/template/)
- [user](/resources/bundled/user/)

The file-based resources have attributes that support unique
requirements within the Windows platform, including `inherits`
(for file inheritance), `mode` (for octal modes), and `rights` (for
access control lists, or ACLs).

- [cookbook_file](/resources/bundled/cookbook_file/)
- [file](/resources/bundled/file/)
- [remote_file](/resources/bundled/remote_file/)
- [template](/resources/bundled/template/)
