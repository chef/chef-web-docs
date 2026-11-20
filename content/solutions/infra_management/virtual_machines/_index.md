+++
title = "Virtual machine configuration management"
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/virtual_machines"
  parent = "overview/solutions/infra_management"
  title = "Virtual machine configuration management"
  weight = 60
+++

Virtual machines are quick to create and slow to keep consistent.
Clones drift from their template, one-off fixes pile up, and nobody can say with confidence what's installed on a given machine.

Chef Infra Client solves this by configuring each virtual machine from code.
It runs inside the guest operating system, applies the cookbooks or policies assigned to that machine, and corrects anything that no longer matches the next time it runs.

This page explains how Chef Infra fits into a virtual machine workflow, how to bring new and existing machines under management, and how to keep them in the state you defined.
For an overview of the solution, see [Chef Infrastructure Management](/solutions/infra_management/).
For Windows guests, also see [Windows configuration management](/solutions/infra_management/windows/).

## When to use Chef Infra for virtual machines

| Situation | What Chef Infra does |
| --- | --- |
| You clone many machines from a template and need each one configured the same way | Applies the same cookbook or policy to every clone when it first starts |
| Machines drift from their intended state over time | Runs on a schedule and reverts any setting that no longer matches the cookbook |
| You run Linux and Windows guests on the same platform | Uses one cookbook workflow for both, with platform-specific resources where you need them |
| You need to show that machines meet a security baseline | Runs Chef InSpec profiles during each Chef Infra Client run and reports the results to Chef Automate |
| You need to change a setting on hundreds of machines | Changes the cookbook once, so you can test it and let each machine pick up the change on its next run |

## How Chef Infra manages virtual machines

Chef Infra manages what runs inside the virtual machine, such as packages, files, services, users, and operating system settings.
Your hypervisor or cloud platform still creates, clones, resizes, and deletes the machine itself.
Chef provides knife plugins for VMware and Google Cloud, and an extension for Microsoft Azure, that connect the two steps so you can create a machine and bootstrap it in one workflow.

The following table shows which tool handles each task:

| Task | Tool |
| --- | --- |
| Create or clone the machine | Your hypervisor or cloud platform, or a knife plugin |
| Install Chef Infra Client and register the node | [`knife bootstrap`](/client/latest/install/bootstrap/), or Chef Infra Client built into the machine image |
| Apply configuration | [Cookbooks](/client/latest/cookbooks/) selected by a [Policyfile](/client/latest/policy/policyfile/) or run-list |
| Keep configuration in place | A scheduled Chef Infra Client run |
| Review results | The [Client Runs](/automate/client_runs/) page in Chef Automate |

## Before you begin

Each virtual machine that runs Chef Infra Client needs the following:

- **Memory:** At least 512 MB of RAM during a Chef Infra Client run.
- **Disk space:** At least 600 MB for the Chef Infra Client binaries on Linux, and at least 2.1 GB on Windows.
- **Cache space:** A cache directory for downloaded cookbooks and packages.
  On Linux, the default is `/var/chef/cache`.
  Start with 5 GB and adjust the size for your cookbooks.
- **Network access:** HTTPS access from the machine to Chef Infra Server or Chef 360 Platform Declarative State Management (DSM).
- **A supported operating system:** See [Chef Infra Client supported platforms](/platforms/#chef-infra-client).
- **A Chef license key:** Required when a bootstrap or install downloads Chef software.
  See [Chef license key](/licensing/license_key/).
- **An accurate system clock:** If the clock drifts more than 15 minutes, authentication to Chef Infra Server fails with a `401 Unauthorized` error.
  Synchronize the clock with a Network Time Protocol (NTP) server.

On your workstation, install [Chef Workstation](/workstation/latest/) to write and test cookbooks and to run `knife` commands.

## Bring virtual machines under management

Choose the method that matches how you create machines:

| Method | Use for |
| --- | --- |
| [`knife bootstrap`](#bootstrap-an-existing-virtual-machine) | Existing machines that you can reach over SSH (Linux) or WinRM (Windows) |
| [Unattended bootstrap](#bootstrap-from-a-template-or-image) | Machines created automatically from a template, image, or user data |
| [A VMware knife plugin](#clone-and-bootstrap-vmware-virtual-machines) | Cloning a machine from a template and bootstrapping it in one step |
| [Cloud integrations](#bootstrap-cloud-virtual-machines) | Machines on Microsoft Azure or Google Cloud |
| [Agentless Mode](/client/latest/features/agentless/) | Linux machines where you don't want to install Chef Infra Client |
| [Chef 360 Platform node enrollment](/360/latest/use/operators/node_enrollment/cookbook/) | Machines that Chef 360 Platform manages |

### Bootstrap an existing virtual machine

To install Chef Infra Client on a running Linux machine and register it, run `knife bootstrap` from your workstation:

```shell
# Install Chef Infra Client over SSH and register the node
knife bootstrap <address> -U <username> --sudo \
  --node-name <node-name> --run-list 'recipe[<cookbook>]' \
  --chef-license-key <license-key>
```

Replace the following:

- `<address>`: the IP address or fully qualified domain name (FQDN) of the machine.
- `<username>`: the account that connects to the machine.
- `<node-name>`: a unique name for the node.
- `<cookbook>`: the cookbook that the first run applies.
- `<license-key>`: your Chef license key.

The `--sudo` option elevates privileges on the machine.
Knife connects to the machine, installs Chef Infra Client with the platform's native package, creates the node's keys, registers the node, and runs Chef Infra Client with the run list you specify.
If you don't specify a run list, the first run has an empty run list.

### Bootstrap from a template or image

When you create machines automatically, no one is available to run `knife bootstrap`.
Instead, build the bootstrap into the template or pass it to the machine as user data.
An unattended bootstrap doesn't need SSH or WinRM access.

The machine needs the following to bootstrap itself:

| Item | Purpose |
| --- | --- |
| Chef Infra Client | Installed from the Chef download service with your license key |
| A `client.rb` file | Sets the server URL, the node name, and the validation key settings |
| A `first-boot.json` file | Sets the initial run list |
| Access to the validation key | Lets the machine create its own identity on Chef Infra Server |

Each machine needs a unique node name.
By default, Chef Infra Client uses the machine's FQDN.

A minimal `client.rb` file for Chef Infra Server looks like this:

```ruby
chef_server_url        'https://<server-fqdn>/organizations/<organization>'
validation_client_name '<organization>-validator'
validation_key         '/etc/chef/<organization>-validator.pem'
node_name              '<unique-node-name>'
```

After the files are in place, run Chef Infra Client with the initial run list:

```shell
# Run Chef Infra Client with the initial run list
chef-client -j /etc/chef/first-boot.json
```

For complete Linux and Windows examples, see [Unattended bootstrapping](/client/latest/install/bootstrap/#unattended-bootstrapping).

### Clone and bootstrap VMware virtual machines

Chef supports these knife plugins for VMware:

| Plugin | Supports | Use for |
| --- | --- | --- |
| [`knife-vsphere`](https://github.com/chef-partners/knife-vsphere) | vCenter later than 5.0 | The main starting point for Chef and VMware compute use cases |
| [`knife-vcenter`](https://github.com/chef/knife-vcenter) | vCenter 6.5 and later, using the REST API | Environments that run the vCenter Server Appliance or plan to upgrade to vCenter 6.5 or later |
| [`knife-vrealize`](https://github.com/chef-partners/knife-vrealize) | vRealize Automation and vRealize Orchestrator | Provisioning from predefined blueprints, catalogs, and workflows |

Version 7.0.0 and later of `knife-vrealize` supports vRealize Automation 8.x.
Version 6.0.3 and earlier supports vRealize Automation 7.x.

Each plugin reads connection settings from your `config.rb` file.
For example, `knife-vsphere` uses these settings:

```ruby
knife[:vsphere_host] = '<vcenter-hostname>'
knife[:vsphere_user] = '<username>'
knife[:vsphere_pass] = '<password>'
knife[:vsphere_dc] = '<datacenter>'
```

To clone a machine from a template and bootstrap it with Chef Infra Client, run:

```shell
# Clone a machine from a VMware template, then bootstrap it
knife vsphere vm clone <vm-name> --template <template-name> --bootstrap --cips dhcp
```

To delete the machine and remove its node from Chef Infra Server, add the `-P` option to `knife vsphere vm delete`.
For the full set of plugin options, see [Chef and VMware](/client/latest/integrations/vmware/).

### Bootstrap cloud virtual machines

If your machines run in a public cloud, use the Chef integration for that platform:

| Platform | Integration | What it does |
| --- | --- | --- |
| Microsoft Azure | [Azure Chef Extension](/client/latest/integrations/azure_powershell/) | Turns on Chef Infra Client on an Azure virtual machine with PowerShell cmdlets or the Azure CLI |
| Google Cloud | [`knife-google`](/client/latest/integrations/google/) | Creates, bootstraps, and manages Google Compute Engine instances |

## Configure a virtual machine with a cookbook

This walkthrough creates a small cookbook, tests it, uploads it, and applies it to a Linux machine.
It uses Chef Infra Server.
If you use Chef 360 Platform DSM, see [Declarative State Management overview](/360/latest/understand/dsm/) to store and assign the cookbook.

You need [Chef Workstation](/workstation/latest/), a configured `knife` connection to your Chef Infra Server, and a machine that you can reach over SSH.

1. Generate a cookbook:

   ```shell
   # Run from the directory where you keep your cookbooks
   chef generate cookbook vm_baseline
   ```

1. Replace the contents of the `recipes/default.rb` file in the new cookbook with the following recipe.
   It installs a package, manages a file, and sets a kernel parameter:

   ```ruby
   # Install a package
   package 'curl'

   # Manage the login banner
   file '/etc/motd' do
     content "This system is managed by Chef Infra.\n"
     owner 'root'
     group 'root'
     mode '0644'
   end

   # Set a kernel parameter
   sysctl 'vm.swappiness' do
     value 10
   end
   ```

1. Test the cookbook with Test Kitchen before you apply it to a real machine.
   From the cookbook directory, run `kitchen converge` and then `kitchen verify`.
   For the `kitchen.yml` file, see [Run Test Kitchen](/workstation/latest/tools/kitchen/run/).

1. Upload the cookbook to Chef Infra Server:

   ```shell
   # Run from the directory that contains the cookbook
   knife cookbook upload vm_baseline
   ```

1. Bootstrap the machine with the cookbook in its run list:

   ```shell
   # Install Chef Infra Client, register the node, and apply the cookbook
   knife bootstrap <address> -U <username> --sudo \
     --node-name <node-name> --run-list 'recipe[vm_baseline]' \
     --chef-license-key <license-key>
   ```

1. Confirm that the node registered and converged:

   ```shell
   # Show the node's run list and attributes
   knife node show <node-name>
   ```

   In Chef Automate, the [Client Runs](/automate/client_runs/) page shows the run status and the resources that changed.

To change the configuration later, edit the cookbook, test it, and upload the new version.
Each machine applies the change on its next Chef Infra Client run.

## Keep virtual machines in the desired state

A single Chef Infra Client run configures the machine once.
To keep it configured, run Chef Infra Client at regular intervals.
The default interval is 1800 seconds (30 minutes).
A `splay` value adds a random delay, so every machine doesn't contact the server at the same moment.

On Linux, use a resource in your cookbook to schedule the runs.
Choose either a systemd timer or a cron job:

```ruby
# Run Chef Infra Client every 30 minutes with a systemd timer
chef_client_systemd_timer 'Run Chef Infra Client as a systemd timer'
```

```ruby
# Run Chef Infra Client every 30 minutes as a cron job
chef_client_cron 'Run Chef Infra Client as a cron job'
```

For options, see [`chef_client_systemd_timer`](/client/latest/resources/bundled/chef_client_systemd_timer/), [`chef_client_cron`](/client/latest/resources/bundled/chef_client_cron/), and [Run Chef Infra Client as a service](/client/latest/reference/ctl_chef_client/#run-as-a-service).
On Windows, use a scheduled task.
See [Windows configuration management](/solutions/infra_management/windows/#run-chef-infra-client-on-a-schedule).

## Check virtual machines against a security baseline

You can assess machines with Chef InSpec during the same Chef Infra Client run that configures them.
Turn on the Compliance Phase and set the profiles to run:

```ruby
# Run Chef InSpec profiles during each Chef Infra Client run
default['audit']['compliance_phase'] = true
default['audit']['profiles']['linux-baseline'] = {
  'compliance': 'user/linux-baseline',
  'version': '2.1.0'
}
```

Chef Infra Client can fetch profiles from Chef Automate, Chef Supermarket, a local file, GitHub, or an HTTP location.
Results appear in the Chef Automate [compliance reports](/automate/reports/).
For setup details, see [Compliance Phase](/client/latest/features/chef_compliance_phase/).
To see which benchmarks Chef Compliance covers, go to [Operating systems](/premium_content/operating_systems/) and [Virtualization](/premium_content/virtualization/).

## Plan for production

Before you apply a cookbook to machines that are in service, follow these practices:

- Test a new or changed cookbook on a few machines, review what changed, then expand.
- Review what the cookbook manages before the first run on a machine that's already in service.
  The first run changes everything that differs from the cookbook.
- Give every machine a unique node name and its own client key.
  Don't copy a registered client's key into a template.
- Keep cookbooks in version control and review every change.
- Don't put passwords or keys in cookbooks.
- Keep each machine's system clock synchronized with an NTP server.

## Troubleshoot common problems

| Symptom | Cause and fix |
| --- | --- |
| `401 Unauthorized` when a new machine registers | The validation key is wrong or missing, or the machine's clock is more than 15 minutes off. Check the key, and synchronize the clock with an NTP server. |
| `401 Unauthorized` on a machine that registered before | The `client.pem` file is invalid. Delete the file on the machine, delete the node and client with knife, and run Chef Infra Client again. |
| `403 Forbidden` | The node's client lacks a permission on Chef Infra Server. Run Chef Infra Client with the `-l debug` option to see the request URL, and then grant the missing permission. |
| `knife bootstrap` can't connect | The machine isn't reachable on the SSH port, or the account or key is wrong. Test the connection with `ssh` first. |
| Two machines appear as one node | The clone kept the template's node name or client key. Give each clone a unique node name and a new identity. |

For more detail, see [Troubleshooting](/client/latest/troubleshooting/).

## Limitations

- Chef Infra manages the guest operating system and what runs on it.
  It doesn't create, size, or delete machines, and it doesn't manage hypervisor settings.
  Use your hypervisor's tooling or one of the knife plugins for those tasks.
- [Agentless Mode](/client/latest/features/agentless/) runs only on Linux nodes and supports the SSH protocol.
- Each knife plugin supports specific platform versions.
  Check the plugin's documentation before you plan around it.

## Related resources

- [Chef Infrastructure Management](/solutions/infra_management/)
- [Windows configuration management](/solutions/infra_management/windows/)
- [Chef and VMware](/client/latest/integrations/vmware/)
- [Bootstrap a node with Chef Infra](/client/latest/install/bootstrap/)
- [Chef Infra Client resources](/client/latest/resources/)
- [Troubleshooting](/client/latest/troubleshooting/)
