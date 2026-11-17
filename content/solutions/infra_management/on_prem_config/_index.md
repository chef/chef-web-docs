+++
title = "The Chef way of on-prem config management"
description = "Configure the servers in your own data center with Chef: write the baseline settings as code, converge servers on a schedule, correct drift, and roll changes out one server group at a time."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/on_prem_config"
  parent = "overview/solutions/infra_management"
  title = "On-prem config management"
  weight = 30
+++

<!-- cspell:ignore chrony iburst sshd somaxconn sysctl -->

On-premises servers drift when people configure them by hand.
One administrator picks different SSH settings than another.
A setting is changed during an incident and never changed back.
A new server is built from last year's notes, and the difference only shows up when something fails on that one server.
A security scan finds that one server in the rack is missing a hardening step.

You need one reviewed definition of how a server should be configured, and a way to keep every server matching it.

Chef does this by letting you describe the configuration as code, and by running an agent, Chef Infra Client, on each server that makes the server match that code, again and again.
The agent changes only what has drifted, so a hand-made change doesn't survive for long, and every change is reported.

This page covers the operating system layer of servers you run yourself: packages, files, services, and kernel settings.
It's honest about the rest: Chef Infra Client doesn't provision bare-metal servers, manage your network, or back up your data.
See [Where Chef fits](#where-chef-fits).

## Who this page is for

**If you're accountable for the outcome**, such as an infrastructure owner, read this section and [Where Chef fits](#where-chef-fits).
You'll learn what Chef gives you for the servers in your data center, what it doesn't, and where the risks are when you change servers that are in service.

**If you run the servers**, work through the rest of the page.
It builds a small cookbook that sets up time synchronization, SSH hardening, and kernel parameters, converges a server, shows a manual change being corrected, sets different values for different server groups, and tests the result.
If you haven't used Chef before, you don't need to read anything else first.

### What you get

- **Consistency across a fleet.** Every server of a given type is built from the same code, so two servers can't quietly diverge.
- **Drift correction.** A change made by hand is reverted at the next run, and the run reports what it changed.
- **Different values where you need them.** Server groups can differ, such as different NTP servers for a development rack, without copying the cookbook.
- **Controlled change.** A change is tested on a workstation, promoted through groups of servers, and rolled out a group at a time.
- **A record.** Each run reports which resources it changed, so you can see when a server's configuration changed.

### What you don't get

Chef Infra Client configures the server it runs on.
It doesn't boot or install servers from scratch, configure your network, or back up data.
It doesn't know when it's safe to restart a service that other systems depend on, so you plan those steps yourself.
A server is in a known state only for the settings you wrote code for, and only as of its last successful run.

## Where Chef fits

On-premises infrastructure has several layers.
Chef covers the operating system and application configuration layers, and the rest of the Chef platform helps you check and watch the result.

| Layer | What it means | Chef piece | On this page |
| --- | --- | --- | --- |
| Bare-metal provisioning | Booting servers from scratch, partitioning disks, and installing the operating system | Not a Chef Infra Client feature. Use a provisioning tool such as Cobbler or MAAS | No |
| Operating system and application configuration | Packages, files, services, users, and kernel parameters | [Chef Infra Client](/client/latest/) resources and [cookbooks](/client/latest/cookbooks/) | Yes |
| Credentials and secrets | Passwords, API keys, and certificates | [The `secret` helper](/client/latest/infra_language/secrets/), or [data bags](/client/latest/policy/data_bags/) with [Chef Vault](/workstation/latest/tools/chef_vault/) | See [Handle credentials](#handle-credentials) |
| Compliance | Checking that servers meet your security and regulatory requirements | [Chef InSpec](/inspec/latest/) and the [Compliance Phase](/client/latest/features/chef_compliance_phase/) | See [Check compliance after each run](#check-compliance-after-each-run) |
| Reporting | Seeing the state and run results of your servers | [Chef Automate](/automate/client_runs/) | See [See the state of your servers](#see-the-state-of-your-servers) |

The pieces that make up the Chef way for the server layer:

| Idea | What it means | Chef piece |
| --- | --- | --- |
| Describe the state you want | You write what a server should look like, not the steps to get there. A `sysctl` resource says a kernel parameter should have a value, and Chef works out how. | Chef Infra cookbooks, recipes, and resources |
| Converge, don't script | An agent on each server compares the server with the code and changes only what doesn't match. Running it twice changes nothing the second time. | Chef Infra Client |
| Keep the code in one place | Servers ask a central service for the cookbooks and policy that apply to them. | Chef Declarative State Management (DSM) in [Chef 360 Platform](/360/latest/), the direct replacement for Chef Infra Server |
| Test before you ship, and roll out in groups | You test on a workstation first, then promote the same code through groups of servers. | [Chef Workstation](/workstation/latest/) and [Policyfiles](/policyfile/) |

## What you'll build

A Chef Infra cookbook, `onprem_baseline`, that manages these settings on an Ubuntu server:

- Installs `chrony` and sets its NTP servers.
- Writes an SSH configuration drop-in file that turns off root login and password authentication, and checks the SSH configuration before restarting `sshd`.
- Sets three kernel parameters with the `sysctl` resource.

It's a small stand-in for real work: the same pattern applies to any other package, configuration file, or kernel parameter.
You'll test it, converge a test server, change a file by hand, and watch Chef correct it.
Then the page shows how the same cookbook serves different server groups and how it reaches many servers.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/install/) on the machine where you write and test code.
  It includes the `chef` and `chef-client` commands and the testing tools.
- A Progress Chef license, for bootstrapping servers and for commercial downloads.
  See [Chef license key](/licensing/license_key/).
- A central service your servers can reach: [Chef 360 Platform Declarative State Management (DSM)](/360/latest/understand/dsm/) or [Chef Infra Server](/server/).
- A Linux test server running Ubuntu 22.04 or later, where you have SSH access and `sudo`.
  The example writes files under `/etc` and changes SSH settings, so don't run it on a production server.

The cookbook was checked with ChefSpec and Cookstyle in Chef Workstation, but it wasn't converged on a real server for this page.
The converge steps describe what to look for instead of showing captured output, and the output you see differs by release and distribution.

## Write the cookbook

To create a cookbook that describes the baseline, follow these steps:

1. Create a repository and a cookbook inside it:

   ```shell
   chef generate repo chef-repo
   cd chef-repo
   chef generate cookbook cookbooks/onprem_baseline
   ```

   The cookbook contains a `recipes/default.rb` for your recipe, a `metadata.rb`, a `Policyfile.rb`, a `kitchen.yml` for testing, and a `compliance` directory.
   See [cookbooks](/client/latest/cookbooks/) for what each part is for.

1. Create `cookbooks/onprem_baseline/attributes/default.rb`.
   The attributes keep the values out of the recipe, so a server group can change them without changing the logic:

   ```ruby
   default['onprem_baseline']['ntp_servers'] = %w(
     0.pool.ntp.org
     1.pool.ntp.org
     2.pool.ntp.org
     3.pool.ntp.org
   )

   default['onprem_baseline']['ssh_config'] = {
     'PermitRootLogin' => 'no',
     'PasswordAuthentication' => 'no',
     'MaxAuthTries' => '3',
     'LogLevel' => 'VERBOSE',
   }

   default['onprem_baseline']['kernel_params'] = {
     'net.ipv4.tcp_syncookies' => '1',
     'net.ipv4.tcp_max_syn_backlog' => '2048',
     'net.core.somaxconn' => '1024',
   }
   ```

1. Replace `cookbooks/onprem_baseline/recipes/default.rb`:

   ```ruby
   package 'chrony'

   directory '/etc/chrony/conf.d' do
     mode '0755'
   end

   file '/etc/chrony/conf.d/onprem-baseline.conf' do
     content node['onprem_baseline']['ntp_servers'].map { |server| "server #{server} iburst\n" }.join
     notifies :restart, 'service[chrony]'
   end

   service 'chrony' do
     action %i(enable start)
   end

   file '/etc/ssh/sshd_config.d/00-onprem-baseline.conf' do
     content node['onprem_baseline']['ssh_config'].map { |key, value| "#{key} #{value}\n" }.join
     notifies :run, 'execute[validate-sshd-config]', :immediately
     notifies :restart, 'service[ssh]'
   end

   execute 'validate-sshd-config' do
     command 'sshd -t'
     action :nothing
   end

   service 'ssh' do
     action %i(enable start)
   end

   node['onprem_baseline']['kernel_params'].each do |name, setting|
     sysctl name do
       value setting
     end
   end
   ```

   The two `file` resources notify the services that read them, so a service restarts only when its file changed.
   The loop gives each `sysctl` resource its own value.
   The block variable is `setting` and not `value`, because inside a resource block `value` refers to the resource's own property.

1. Replace `cookbooks/onprem_baseline/metadata.rb`:

   ```ruby
   name 'onprem_baseline'
   description 'Manage on-premises server baseline configuration'
   license 'Apache-2.0'
   version '0.1.0'
   chef_version '>= 18.0'

   supports 'ubuntu', '>= 22.04'
   ```

The recipe is for Ubuntu.
Other distributions use different file paths and service names, such as `/etc/chrony.conf` and `sshd` on Red Hat Enterprise Linux, so `metadata.rb` lists only Ubuntu.

{{< warning >}}

This example turns off root login and password authentication over SSH.
A server with no SSH key for your user is unreachable after the next run.
Confirm that key-based login works before you converge a server, and keep a second session open while you test.

{{< /warning >}}

## Converge a server and correct drift

To see Chef Infra Client apply the cookbook and then undo a manual change, follow these steps on your Linux test server, from the cookbook's repository:

1. Run the recipe in local mode, which runs a lightweight Chef Infra Server on the machine for the length of the run:

   ```shell
   sudo chef-client -z -o 'recipe[onprem_baseline]'
   ```

   Accept the license prompt if you see one.
   On a new server, each resource is created or installed, and the services that read a changed file are restarted.
   The run ends with a summary of how many resources it updated, which depends on what's already on the server.

1. Run it again.
   Nothing has drifted, so nothing changes, and the resources report `(up to date)`.
   This is idempotence, and it's why you can run Chef on a schedule without worrying about what it will do to a server that's already correct.

1. Make a change by hand, as an administrator might during an incident:

   ```shell
   sudo sed -i 's/MaxAuthTries 3/MaxAuthTries 5/' /etc/ssh/sshd_config.d/00-onprem-baseline.conf
   ```

1. Run the recipe again:

   ```shell
   sudo chef-client -z -o 'recipe[onprem_baseline]'
   ```

   Chef Infra Client finds the difference and reverts it.
   The `file` resource shows a diff of the line it changed, which looks like this:

   ```text
   -MaxAuthTries 5
   +MaxAuthTries 3
   ```

   The change also runs the `sshd -t` check and restarts `sshd`.
   The other resources were already correct, so they're not changed.

This diff shows the expected change.
It isn't output captured from a test run, and your checksums and timings differ.

{{< note >}}

Chef changes the file on disk, and the notifications restart the service.
On a server that people are logged in to, decide when that restart is acceptable.
See [Roll changes out safely](#roll-changes-out-safely).

{{< /note >}}

## Use different settings for different server groups

Server groups often need different settings.
A development rack might use fewer NTP servers than production, or a stricter SSH log level.
Keep the logic in the cookbook the same, and change only the attributes.

A [Policyfile](/policyfile/) locks a run list and cookbook versions into one versioned revision, and it can carry attributes.
This Policyfile sets the NTP servers for production servers:

```ruby
name 'onprem-prod'
default_source :supermarket
run_list 'onprem_baseline::default'
cookbook 'onprem_baseline', path: 'cookbooks/onprem_baseline'
default['onprem_baseline']['ntp_servers'] = %w(ntp1.example.com ntp2.example.com)
```

Running `chef install` in the repository evaluates this file and writes `Policyfile.lock.json`, which records the run list, the cookbook, and the attribute.
A second Policyfile with a different `name` and different attributes serves the development servers.
See [Policyfiles](/policyfile/) for the full syntax.

## Test before you ship

A cookbook that changes servers needs testing before it runs on them.
Chef Workstation includes the tools for that, so a change can be checked on your workstation or in a disposable machine first.

| Tool | What it checks |
| --- | --- |
| Cookstyle | Style and common mistakes in your Chef Infra code |
| [ChefSpec](/workstation/latest/tools/chefspec/) | What a recipe would do, without running it on a system |
| [Test Kitchen](/workstation/latest/tools/kitchen/) | Whether the cookbook converges on a real, throwaway machine, and whether the result passes your tests |
| [Chef InSpec](/inspec/latest/) | Whether the finished system meets requirements |

Here's a ChefSpec test for this cookbook.
Create `cookbooks/onprem_baseline/spec/unit/recipes/default_spec.rb`:

```ruby
require 'chefspec'

describe 'onprem_baseline::default' do
  platform 'ubuntu', '22.04'

  it 'installs chrony' do
    expect(chef_run).to install_package('chrony')
  end

  it 'writes the NTP servers to a chrony drop-in' do
    expect(chef_run).to render_file('/etc/chrony/conf.d/onprem-baseline.conf')
      .with_content("server 0.pool.ntp.org iburst\n")
  end

  it 'writes the SSH settings and validates them before restarting sshd' do
    file = chef_run.file('/etc/ssh/sshd_config.d/00-onprem-baseline.conf')
    expect(chef_run).to render_file(file.path).with_content(/^PermitRootLogin no$/)
    expect(file).to notify('execute[validate-sshd-config]').to(:run).immediately
    expect(file).to notify('service[ssh]').to(:restart).delayed
  end

  it 'sets each kernel parameter to its own value' do
    expect(chef_run).to apply_sysctl('net.core.somaxconn').with(value: '1024')
    expect(chef_run).to apply_sysctl('net.ipv4.tcp_syncookies').with(value: '1')
  end

  context 'when a policy overrides the NTP servers' do
    override_attributes['onprem_baseline'] = { 'ntp_servers' => %w(ntp.internal) }

    it 'uses the override' do
      expect(chef_run).to render_file('/etc/chrony/conf.d/onprem-baseline.conf')
        .with_content("server ntp.internal iburst\n")
    end
  end
end
```

Run it from the cookbook directory:

```shell
chef exec rspec spec
```

```text
.....

5 examples, 0 failures
```

ChefSpec runs the recipe in memory, so you can run this test on a laptop.
It checks that the notifications are declared, but it doesn't restart a service or change a kernel parameter.
Use Test Kitchen to converge the cookbook on a real Linux machine before you roll it out.
The `kitchen.yml` that `chef generate cookbook` creates is the starting point.

## Roll changes out safely

Changing servers that are in service carries risk.
Chef gives you ways to control which servers change and when.
The decisions about the applications on those servers are yours.

**Promote through policy groups.**
A policy group binds a set of servers to a specific policy revision.
Use one policy group for a small set of servers that try a change first, and promote the same revision to the next group when it's healthy.
Servers in the later groups don't see the change until you promote it.
Chef Workstation's `chef push` uploads a revision to a policy group:

```shell
chef install
chef push canary Policyfile.lock.json
chef push production Policyfile.lock.json
```

To pick up a change in a cookbook you depend on, run `chef update` before `chef install`.
See [Policyfiles](/policyfile/) and [policy groups in DSM](/360/latest/use/operators/dsm_operations/#policy-groups).

**Decide when services restart.**
The cookbook restarts `chrony` and `sshd` when their files change.
The `sshd -t` check runs after the file is written, so a configuration that fails the check stays on disk and the run fails.
Always apply an SSH change to the canary group first, and keep a second session open.

**Plan for applications on the server.**
Chef doesn't know which applications depend on a server.
A kernel parameter such as `net.core.somaxconn` affects every application on the machine, so test it with the workloads it will run.

## Run Chef on a schedule

A server stays in a known state only if Chef runs regularly.
The `chef_client_systemd_timer` resource sets up Chef Infra Client to run as a systemd timer, which is how you manage the schedule with Chef itself:

```ruby
chef_client_systemd_timer 'Run Chef Infra Client every hour' do
  interval '1hr'
end
```

The default `interval` is `30min`.
See [`chef_client_systemd_timer`](/client/latest/resources/bundled/chef_client_systemd_timer/) for every property, and [`chef_client_cron`](/client/latest/resources/bundled/chef_client_cron/) for the cron equivalent.

This snippet is from the resource reference and isn't part of the tested example.

Pick an interval that matches how fast you need drift corrected.
A run restarts a service when its file changed, so check that the schedule suits servers that can't restart at any time.

## Bring servers under management

A server is any machine Chef manages.
Bootstrapping installs Chef Infra Client on a server over SSH and registers it with the central service:

```shell
knife bootstrap <ADDRESS> -U <USERNAME> --sudo --chef-license-key <LICENSE> --policy-name onprem-prod --policy-group production
```

Replace:

- `<ADDRESS>` with the IP address or FQDN of the server.
- `<USERNAME>` with the user that connects over SSH.
- `<LICENSE>` with your Progress Chef license ID.

`--policy-name` and `--policy-group` apply a policy on the first run.
Push the policy to its group before you bootstrap, as shown in [Roll changes out safely](#roll-changes-out-safely).
See [bootstrap a node](/client/latest/install/bootstrap/) for the other options, including [unattended bootstrapping](/client/latest/install/bootstrap/#unattended-bootstrapping) for first-boot scripts.

The central service is Chef Declarative State Management (DSM) in Chef 360 Platform, which is the direct replacement for Chef Infra Server.
If you run Chef Infra Server today, see [Migrate from Chef Infra Server](/360/latest/migrate/on_prem_to_self_managed/).

## Handle credentials

Don't write a password, key, or token into a recipe, an attribute file, or a template.
The Chef documentation describes these options:

- **The `secret` helper.** It reads a secret from AWS Secrets Manager, Akeyless Vault, Azure Key Vault, or HashiCorp Vault. See [the `secret` helper](/client/latest/infra_language/secrets/).
- **Encrypted data bags and Chef Vault.** See [data bags](/client/latest/policy/data_bags/) and [Chef Vault](/workstation/latest/tools/chef_vault/).
  The Chef documentation doesn't say whether they're supported on DSM, so check before you build on them.

Set `sensitive true` on any resource that handles a credential, so Chef Infra Client doesn't log its data.

## Check compliance after each run

Configuration and compliance answer different questions.
Chef Infra Client makes the server match your code.
Chef InSpec checks that the result meets a requirement.

The [Compliance Phase](/client/latest/features/chef_compliance_phase/) runs Chef InSpec profiles after each Chef Infra Client run.
It requires Chef Infra Client 17 or later.
You turn it on with attributes, and you can set them in a Policyfile:

```ruby
default['audit']['compliance_phase'] = true
default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
}
```

This snippet is adapted from the Compliance Phase reference and isn't part of the tested example.
You can also fetch profiles from Chef Automate, a local path, GitHub, or a URL.
To write your own profile, run `chef generate profile` from Chef Workstation, and keep it in the cookbook's `compliance` directory.

See [The Chef way of compliance](/solutions/compliance/) for guidance on building audits.

## See the state of your servers

After each run, Chef Infra Client reports a summary of what it did.
Chef Automate collects those reports and shows the status of your servers and their Chef Infra Client runs.
See [client runs](/automate/client_runs/).

To send run data to Chef Automate, set the data collector in each server's `client.rb`:

```ruby
data_collector.server_url 'https://<AUTOMATE_FQDN>/data-collector/v0/'
data_collector.token '<TOKEN>'
```

Replace `<AUTOMATE_FQDN>` with the FQDN of your Chef Automate server, and `<TOKEN>` with an API token.
See [Data collection](/automate/data_collection/) for how to create the token.

## What the documentation doesn't say

This page sticks to what the Chef documentation states and what the example proved.
A few things that people often assume aren't covered, so confirm them before you rely on them:

- **A converge on a real server.** The cookbook passes ChefSpec and Cookstyle, but this page doesn't show output from a full run on a server. Run it with Test Kitchen on a throwaway machine first.
- **Other distributions.** The cookbook is for Ubuntu. Red Hat Enterprise Linux and other distributions need different paths and service names.
- **Bare-metal provisioning and networks.** Chef Infra Client doesn't provision servers or manage network devices.
- **Chef Vault on DSM.** The Chef documentation doesn't say whether it's supported, so check before you build on it.
- **DSM and the Chef Infra Server commands.** This page uses `knife bootstrap` and `chef push`, and it doesn't describe how DSM and Chef Infra Server differ when you run them. Check the DSM documentation for your service.

## Where to start

If you're new to Chef, start with the example on this page, and then read the [Chef Infra quickstart guide](/client/latest/quickstart/).
Before you scale up:

- Pick the settings that must be identical on every server, and put them in a cookbook.
- Keep values that differ between server groups in attributes, not in recipes, and test every branch.
- Give each server group its own policy group, and try every change on a small group first.
- Decide when services restart after a change.
- Run Chef on a schedule, and use Chef Automate to watch the run reports.
- Check the result with Chef InSpec.

## Related documentation

- [Chef Infra Client](/client/latest/)
- [Chef Workstation](/workstation/latest/)
- [Chef 360 Platform](/360/latest/)
- [Declarative State Management](/360/latest/understand/dsm/)
- [Policyfiles](/policyfile/)
- [Compliance Phase](/client/latest/features/chef_compliance_phase/)
- [Chef Automate client runs](/automate/client_runs/)
- [The Chef way of compliance](/solutions/compliance/)
