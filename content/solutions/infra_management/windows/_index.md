+++
title = "Windows configuration management"
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/windows"
  parent = "overview/solutions/infra_management"
  title = "Windows configuration management"
  weight = 70
+++

Windows servers and workstations accumulate settings that nobody tracks: roles and features, registry values, services, firewall rules, scheduled tasks, and installed software.

Chef Infra Client manages these settings from code.
It uses the same cookbooks, recipes, and policies you use for Linux, and adds resources built for Windows, including Windows features, registry keys, services, scheduled tasks, firewall rules, and PowerShell Desired State Configuration (DSC).
You describe the state you want, and Chef Infra Client changes only what doesn't match.

This page explains how to install Chef Infra Client on Windows, what you can manage, and how to configure and maintain Windows nodes.
For an overview of the solution, see [Chef Infrastructure Management](/solutions/infra_management/).
For virtual machine workflows, also see [Virtual machine configuration management](/solutions/infra_management/virtual_machines/).

## When to use Chef Infra for Windows

| Situation | What Chef Infra does |
| --- | --- |
| You build servers that need the same roles, features, and settings every time | Installs Windows features and applies registry, service, and firewall settings from one cookbook |
| Administrators change settings by hand and servers drift apart | Runs on a schedule and reverts any setting that no longer matches the cookbook |
| You already manage some settings with PowerShell scripts or DSC | Runs your scripts and DSC resources from a recipe, with guards that stop them from repeating work |
| You deploy and update software on many Windows machines | Installs MSI, EXE, Chocolatey, and PowerShell packages and keeps them at the version you set |
| You need to harden Windows Server to a security benchmark | Applies security settings and checks them with Chef InSpec |

## How Chef Infra manages Windows nodes

You write and test cookbooks on a workstation and upload them to Chef Infra Server or Chef 360 Platform Declarative State Management (DSM).
Chef Infra Client runs on each Windows node as a scheduled task, downloads the cookbooks assigned to that node, and applies them.
After each run, it reports the results to Chef Automate.

## Before you begin

Each Windows node that runs Chef Infra Client needs the following:

- **A supported Windows version:** Chef Infra Client 19 runs on x64 versions of Windows 10, Windows 11, Windows Server 2016, Windows Server 2019, and Windows Server 2022.
  See [Chef Infra Client supported platforms](/platforms/#chef-infra-client).
- **Memory:** At least 512 MB of RAM during a Chef Infra Client run.
- **Disk space:** At least 2.1 GB for the Chef Infra Client binaries, plus space for the cache directory that holds downloaded cookbooks and packages.
- **Network access:** HTTPS access from the node to Chef Infra Server or Chef 360 Platform DSM.
- **Administrator privileges:** Required to converge most recipes.
- **A Chef license key:** Required when a bootstrap or install downloads Chef software.
  See [Chef license key](/licensing/license_key/).

To bootstrap nodes from your workstation, you also need Windows Remote Management (WinRM) access to each node.
The node must be reachable on the ports that you configured for WinRM over HTTP or HTTPS.
Knife supports NT LAN Manager (NTLM) and Kerberos authentication for WinRM.
For the full requirements, see [Chef Infra Client system requirements](/client/latest/install/system_requirements/).

## Install Chef Infra Client on Windows nodes

You can install Chef Infra Client on a Windows node in any of these ways:

| Method | Use for |
| --- | --- |
| [`knife bootstrap` over WinRM](#bootstrap-a-windows-node) | Installing and registering nodes from a workstation |
| [Unattended bootstrap](#bootstrap-without-winrm) | Nodes created automatically from an image or with user data |
| Microsoft Installer Package (MSI) | Installing on one node, or building the client into an image |
| An existing Windows management process, such as System Center | Using the deployment tooling you already run |

The MSI is available from [Chef Downloads](https://www.chef.io/downloads).

### Bootstrap a Windows node

Run `knife bootstrap` from your workstation with the WinRM protocol.
Knife connects to the node, installs Chef Infra Client with the MSI, and runs it with the run list or policy you specify.

```shell
# Bootstrap a Windows node over WinRM with a run list
knife bootstrap <address> -o winrm -U <username> -P '<password>' \
  --node-name <node-name> --run-list 'recipe[<cookbook>]'
```

Replace the following:

- `<address>`: the IP address or fully qualified domain name (FQDN) of the node.
- `<username>` and `<password>`: credentials for an account with administrator privileges on the node.
- `<node-name>`: a unique name for the node.
- `<cookbook>`: the cookbook that the first run applies.

To assign a Policyfile instead of a run list, replace `--run-list` with `--policy-name <policy-name> --policy-group <policy-group>`.
To encrypt the WinRM connection, add the `--winrm-ssl` option.
Your node needs a WinRM HTTPS listener for this option to work.

> **Note:** Downloading Chef software during a bootstrap requires a [Chef license key](/licensing/license_key/).

### Bootstrap without WinRM

When you create Windows machines automatically, for example from an image or with user data, build the bootstrap into the machine.
An unattended bootstrap downloads the MSI, installs it, writes the `first-boot.json` and `client.rb` files, and runs Chef Infra Client.
Each node needs a unique node name and access to the validation key.

The following PowerShell excerpt installs Chef Infra Client and turns on the scheduled task:

```powershell
# Install Chef Infra Client and configure it as a scheduled task
Start-Process msiexec.exe -ArgumentList @(
  '/qn',
  '/lv C:\Windows\Temp\chef-log.txt',
  '/i C:\chef-client.msi',
  'ADDLOCAL="ChefClientFeature,ChefSchTaskFeature,ChefPSModuleFeature"'
) -Wait
```

For the complete script, including how to download the MSI and write the configuration files, see [Unattended bootstrapping](/client/latest/install/bootstrap/#unattended-bootstrapping).

### Run Chef Infra Client on a schedule

To keep configuration in place over time, run Chef Infra Client as a Windows scheduled task.
You can turn on the task during an MSI install with the `ChefSchTaskFeature` option of the `ADDLOCAL` parameter:

| `ADDLOCAL` option | What it does |
| --- | --- |
| `ChefClientFeature` | Installs Chef Infra Client |
| `ChefSchTaskFeature` | Configures Chef Infra Client as a scheduled task |
| `ChefPSModuleFeature` | Installs the Chef PowerShell module |

You can also manage the task from a cookbook with the [`chef_client_scheduled_task`](/client/latest/resources/bundled/chef_client_scheduled_task/) resource.
By default, it runs Chef Infra Client every 30 minutes:

```ruby
# Run Chef Infra Client every 30 minutes as a scheduled task
chef_client_scheduled_task 'Run Chef Infra Client as a scheduled task'
```

To run on a different schedule, set the `frequency` and `start_time` properties.
For example, `frequency 'daily'` with `start_time '01:00'` runs once a day at 01:00.
The default log file for the scheduled task is `C:\chef\chef-client.log`.

> **Note:** The `--daemonize` option isn't available on Windows.
> To run Chef Infra Client as a Windows service, use the `chef-client::service` recipe in the [`chef-client` cookbook](https://supermarket.chef.io/cookbooks/chef-client).

## What you can manage

The following sections group the resources that Chef Infra Client provides for Windows.

### Windows-specific resources

| Area | Resources |
| --- | --- |
| Roles and features | [`windows_feature`](/client/latest/resources/bundled/windows_feature/), [`windows_feature_dism`](/client/latest/resources/bundled/windows_feature_dism/), [`windows_feature_powershell`](/client/latest/resources/bundled/windows_feature_powershell/) |
| Registry and environment | [`registry_key`](/client/latest/resources/bundled/registry_key/), [`windows_env`](/client/latest/resources/bundled/windows_env/), [`windows_path`](/client/latest/resources/bundled/windows_path/) |
| Services and tasks | [`windows_service`](/client/latest/resources/bundled/windows_service/), [`windows_task`](/client/latest/resources/bundled/windows_task/), [`windows_auto_run`](/client/latest/resources/bundled/windows_auto_run/) |
| Packages and updates | [`windows_package`](/client/latest/resources/bundled/windows_package/), [`msu_package`](/client/latest/resources/bundled/msu_package/), [`cab_package`](/client/latest/resources/bundled/cab_package/), [`chocolatey_package`](/client/latest/resources/bundled/chocolatey_package/), [`powershell_package`](/client/latest/resources/bundled/powershell_package/) |
| PowerShell and DSC | [`powershell_script`](/client/latest/resources/bundled/powershell_script/), [`dsc_resource`](/client/latest/resources/bundled/dsc_resource/), [`dsc_script`](/client/latest/resources/bundled/dsc_script/) |
| Security | [`windows_firewall_rule`](/client/latest/resources/bundled/windows_firewall_rule/), [`windows_firewall_profile`](/client/latest/resources/bundled/windows_firewall_profile/), [`windows_security_policy`](/client/latest/resources/bundled/windows_security_policy/), [`windows_audit_policy`](/client/latest/resources/bundled/windows_audit_policy/), [`windows_user_privilege`](/client/latest/resources/bundled/windows_user_privilege/), [`windows_certificate`](/client/latest/resources/bundled/windows_certificate/), [`windows_uac`](/client/latest/resources/bundled/windows_uac/), [`windows_defender`](/client/latest/resources/bundled/windows_defender/) |
| Domain and network services | [`windows_ad_join`](/client/latest/resources/bundled/windows_ad_join/), [`windows_workgroup`](/client/latest/resources/bundled/windows_workgroup/), [`windows_dns_zone`](/client/latest/resources/bundled/windows_dns_zone/), [`windows_dns_record`](/client/latest/resources/bundled/windows_dns_record/), [`windows_share`](/client/latest/resources/bundled/windows_share/), [`windows_printer`](/client/latest/resources/bundled/windows_printer/) |

For every bundled resource, see the [resource reference](/client/latest/resources/).

### Resources shared with other platforms

These core resources work on Windows the way they do on Linux: `cookbook_file`, `directory`, `execute`, `file`, `group`, `http_request`, `link`, `mount`, `package`, `remote_directory`, `remote_file`, `ruby_block`, `service`, `template`, and `user`.
The file-based resources (`cookbook_file`, `file`, `remote_file`, and `template`) also support the Windows properties `inherits`, `mode`, and `rights` for file inheritance, octal modes, and access control lists (ACLs).

### Chef-maintained cookbooks

These cookbooks add custom resources for common Windows workloads:

| Cookbook | Use for |
| --- | --- |
| [`iis`](https://github.com/chef-cookbooks/iis) | Installing and configuring Internet Information Services (IIS) |
| [`iis_urlrewrite`](https://github.com/chef-cookbooks/iis_urlrewrite) | Installing the IIS URL Rewrite 2.0 extension |
| [`powershell`](https://github.com/chef-cookbooks/powershell) | Installing and configuring PowerShell |
| [`vcruntime`](https://github.com/chef-cookbooks/vcruntime) | Installing Microsoft Visual C++ runtimes |
| [`mingw`](https://github.com/chef-cookbooks/mingw) | Installing MSYS and MinGW compiler toolchains |
| [`webpi`](https://github.com/chef-cookbooks/webpi) | Running the Microsoft Web Platform Installer |

## Configure a Windows node with a cookbook

This walkthrough builds a cookbook that installs the IIS role, opens the firewall for web traffic, installs a package, and sets a registry value.
It uses Chef Infra Server.
If you use Chef 360 Platform DSM, see [Declarative State Management overview](/360/latest/understand/dsm/) to store and assign the cookbook.

You need [Chef Workstation](/workstation/latest/), a configured `knife` connection to your Chef Infra Server, and a Windows node that you can reach over WinRM.

1. Generate a cookbook:

   ```shell
   # Run from the directory where you keep your cookbooks
   chef generate cookbook win_web
   ```

1. Replace the contents of the `recipes/default.rb` file in the new cookbook with the following recipe:

   ```ruby
   # Install the IIS role and its management tools
   windows_feature 'Web-Server' do
     action :install
     management_tools true
     install_method :windows_feature_powershell
   end

   # Allow inbound HTTP traffic on port 80
   windows_firewall_rule 'IIS' do
     local_port '80'
     protocol 'TCP'
     firewall_action :allow
   end

   # Install a package from an MSI and verify the download
   windows_package '<package-name>' do
     source 'https://<artifact-server>/<package>.msi'
     checksum '<sha256-checksum>'
   end

   # Set a registry value, creating the key if it doesn't exist
   registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Example' do
     values [{
       name: 'Environment',
       type: :string,
       data: 'production'
     }]
     recursive true
     action :create
   end
   ```

   Replace `<package-name>`, `<artifact-server>`, `<package>`, and `<sha256-checksum>` with the values for the package you deploy.

1. Test the cookbook with Test Kitchen on a Windows platform before you apply it to a real node.
   From the cookbook directory, run `kitchen converge` and then `kitchen verify`.
   For the `kitchen.yml` file, see [Run Test Kitchen](/workstation/latest/tools/kitchen/run/).

1. Upload the cookbook to Chef Infra Server:

   ```shell
   # Run from the directory that contains the cookbook
   knife cookbook upload win_web
   ```

1. Bootstrap the node with the cookbook in its run list:

   ```shell
   # Install Chef Infra Client, register the node, and apply the cookbook
   knife bootstrap <address> -o winrm -U <username> -P '<password>' \
     --node-name <node-name> --run-list 'recipe[win_web]'
   ```

1. Confirm that the node registered and converged:

   ```shell
   # Show the node's run list and attributes
   knife node show <node-name>
   ```

   In Chef Automate, the [Client Runs](/automate/client_runs/) page shows the run status and the resources that changed.

To change the configuration later, edit the cookbook, test it, and upload the new version.
The node applies the change on its next Chef Infra Client run.

## Run PowerShell and Desired State Configuration

If you already have PowerShell scripts or DSC resources, run them from a recipe.
Prefer a built-in resource when one exists, because built-in resources check the current state for you.
When you do run a script, add a guard so it runs only when work remains.

The [`powershell_script`](/client/latest/resources/bundled/powershell_script/) resource runs PowerShell code and accepts `not_if` and `only_if` guards:

```ruby
# Create a directory only if it doesn't exist
powershell_script 'create-app-directory' do
  code 'New-Item -ItemType Directory -Path C:\app'
  not_if 'Test-Path C:\app'
end
```

The [`dsc_resource`](/client/latest/resources/bundled/dsc_resource/) resource runs a single DSC resource.
To run a DSC configuration script, use [`dsc_script`](/client/latest/resources/bundled/dsc_script/).

```ruby
# Create a local group with a DSC resource
dsc_resource 'demogroupadd' do
  resource :group
  property :groupname, 'demo1'
  property :ensure, 'present'
end
```

## Handle reboots

Some changes, such as installing a Windows feature, need a reboot to finish.
Use the [`reboot`](/client/latest/resources/bundled/reboot/) resource to request one without stopping the run.
The following example requests a reboot when the run completes successfully:

```ruby
# Reboot after the run completes, if the run succeeds
reboot 'app_requires_reboot' do
  action :request_reboot
  reason 'Need to reboot when the run completes successfully.'
  delay_mins 5
end
```

## Check Windows nodes against a security benchmark

Chef Compliance has audit coverage, remediation coverage, or both for these Windows Server benchmarks:

- Center for Internet Security (CIS) benchmarks for Windows Server 2012, 2012 R2, 2016, 2019, 2022, and 2025
- Security Technical Implementation Guide (STIG) benchmarks for Windows Server 2012, 2012 R2, 2016, 2019, and 2022

To run Chef InSpec profiles during each Chef Infra Client run, turn on the [Compliance Phase](/client/latest/features/chef_compliance_phase/).
For the versions available for each benchmark, see [Operating systems](/premium_content/operating_systems/).

## Plan for production

Windows has a few behaviors that you should plan for before you apply a cookbook to nodes that are in service:

- **Run with administrator privileges.**
  Without them, a run that needs elevation can appear to succeed but make no changes.
  To fail the run instead, use the `--fatal-windows-admin-check` (`-A`) option.
- **Avoid spaces in directory paths.**
  Chef commands can fail against a directory with a space in its name, such as `C:\Users\User Name`.
- **Keep top-level directory names short.**
  Windows returns errors when path names get too long, so use a short top-level directory such as `C:\chef`.
- **Check the `PATH` variable.**
  The installer adds the Chef Infra Client directories to the system `PATH`, and Chef Infra Client doesn't run correctly without them.
- **Set proxy variables in lowercase.**
  If your nodes use a proxy, set `http_proxy` and `https_proxy` as system environment variables.
- **Review what the cookbook manages.**
  The first run on a node that's already in service changes everything that differs from the cookbook.
- **Protect credentials.**
  Don't put passwords in cookbooks, and don't store them in recipes in version control.
  Use WinRM over SSL or Kerberos when you bootstrap.
- **Test before you expand.**
  Apply a new or changed cookbook to a few nodes, review what changed, then expand.

## Troubleshoot common problems

| Symptom | Cause and fix |
| --- | --- |
| The run reports success but nothing changed | Chef Infra Client ran without administrator privileges. Run it as an administrator, or use the `-A` option to fail the run. |
| `knife bootstrap` can't connect | WinRM isn't reachable. Check that WinRM is running, that the firewall allows the WinRM port, and that you use a supported authentication method (NTLM or Kerberos). |
| `401 Unauthorized` when the node registers | The validation key is wrong or missing, or the node's clock is more than 15 minutes off. Check the key, and synchronize the clock. |
| Commands fail in a directory | The path contains a space. Use a path without spaces. |
| `chef-client` isn't found | The Chef Infra Client directories aren't in the system `PATH`. Add them, or reinstall from the MSI. |
| The node can't reach the server through a proxy | The proxy variables are missing or in uppercase. Set `http_proxy` and `https_proxy` in lowercase as system environment variables. |

For more detail, see [Troubleshooting](/client/latest/troubleshooting/).

## Related resources

- [Chef Infrastructure Management](/solutions/infra_management/)
- [Virtual machine configuration management](/solutions/infra_management/virtual_machines/)
- [Chef for Windows](/client/latest/integrations/windows/)
- [Install Chef Infra Client on Windows nodes](/client/latest/integrations/install_windows/)
- [Bootstrap a node with Chef Infra](/client/latest/install/bootstrap/)
- [Chef Infra Client resources](/client/latest/resources/)
- [Troubleshooting](/client/latest/troubleshooting/)
