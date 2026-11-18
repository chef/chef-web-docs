+++
title = "The Chef way of hybrid fleet config management"
description = "Configure a fleet that spans operating systems and sites with one codebase: handle Linux and Windows in the cookbook, handle each site in a layered policy, and roll changes out one site at a time."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/hybrid_fleet_config"
  parent = "overview/solutions/infra_management"
  title = "Hybrid fleet config management"
  weight = 40
+++

<!-- cspell:ignore splay winrm launchd remoting Policyfile Policyfiles -->

A hybrid fleet differs along two axes at once.
The operating system differs: Linux servers in the racks, Windows servers in a domain, and a few of each in a cloud account.
The site differs: each data center, branch office, and cloud has its own log collector, its own time source, and its own network rules.
Teams usually answer this with one script for each combination, and the combinations multiply.
A change to the baseline then means editing and re-testing every script, and the answer to "which servers are out of line?" depends on which script you ask.

You need one definition of the baseline, a clear place for each thing that varies, and a way to roll a change out one site at a time.

Chef does this by separating the two axes.
The operating system is handled in the cookbook, where one recipe applies the right resource for each platform.
The site is handled in policy, where a small policy for each site layers its own values on top of one shared base policy.
Chef Infra Client runs on every node, applies the result, and reports what it changed.

This page covers the configuration layer of a fleet you run across sites and operating systems.
Chef Infra Client doesn't provision servers or manage your network, and it doesn't make Linux and Windows behave the same.
See [Where Chef fits](#where-chef-fits).

## Who this page is for

**If you're accountable for the outcome**, such as an infrastructure or platform owner, read this section and [Where Chef fits](#where-chef-fits).
You'll learn what Chef gives you for a fleet that spans sites and operating systems, what it doesn't, and what layering policy costs you.

**If you run the fleet**, work through the rest of the page.
It builds a small cookbook that runs on Linux and Windows, tests both from one workstation, layers a policy for each site on a shared base, and then covers enrollment, scheduling, rollout, and what to do for a site that can't reach your central service.
If you haven't used Chef before, start with the [Chef Infra quickstart guide](/client/latest/quickstart/).

### What you get

- **One codebase for both operating systems.** A recipe chooses the right resources for each platform, so the baseline lives in one place.
- **One place for site values.** Each site's settings live in a small Policyfile, so adding a site means adding a file and not copying a cookbook.
- **Identical code everywhere.** Every site's policy pins the same cookbook, so a site can differ in its values but not in its logic.
- **Site-by-site rollout.** You promote a change to one site, check it, and then move to the next.
- **A record.** Each run reports which resources it changed, and Chef Automate can filter nodes by platform, policy name, and policy group.

### What you don't get

Chef Infra Client configures the node it runs on.
It doesn't build the server, join it to a network, or reconcile two operating systems for you: where Linux and Windows differ, you write both branches.
Agentless Mode, which configures a node over SSH without installing Chef Infra Client, supports Linux nodes only.
A node is in a known state only for the settings you wrote code for, and only as of its last successful run.

## Where Chef fits

A hybrid fleet has several layers.
Chef covers the configuration layer and gives you what you need to watch and check it.

| Layer | What it means | Chef piece | On this page |
| --- | --- | --- | --- |
| Provisioning | Building servers and virtual machines in each data center and cloud | Not a Chef Infra Client feature. Use your cloud's tools or your provisioning tools | No |
| Operating system configuration | Directories, files, packages, services, scheduled work, registry settings | [Chef Infra Client](/client/latest/) resources, with one branch for each platform | Yes |
| Site-specific values | Log collectors, time sources, and other values that change by location | [Policyfile](/policyfile/) attributes, one policy for each site | Yes |
| Connectivity | Proxies, firewalls, and routes from each site to the central service | Chef Infra Client proxy settings. The network itself is yours | See [Sites that can't reach the central service](#sites-that-cant-reach-the-central-service) |
| Visibility | Seeing run status across sites and platforms | [Chef Automate](/automate/client_runs/) | See [See the fleet in one place](#see-the-fleet-in-one-place) |
| Compliance | Checking that nodes meet a baseline | [Chef InSpec](/inspec/latest/) and the [Compliance Phase](/client/latest/features/chef_compliance_phase/) | See [Keep compliance consistent](#keep-compliance-consistent) |

The ideas behind the Chef way for a mixed fleet:

| Idea | What it means | Chef piece |
| --- | --- | --- |
| Describe the state you want | You write what a node should look like, not the steps to get there. A `directory` resource means the same on Linux and Windows, and Chef works out how. | Chef Infra cookbooks, recipes, and resources |
| Branch on the platform | Where Linux and Windows differ, one recipe checks the platform and applies the matching resources. | The [`platform?` helper](/client/latest/infra_language/checking_platforms/) and the [Windows helpers](/client/latest/infra_language/windows/) |
| Put site values in policy | A policy locks the run-list and cookbook versions and carries the attributes for one site. | [Policyfiles](/policyfile/), with `include_policy` to share a base |
| Keep the code in one place | Nodes ask a central service for the policy that applies to them. | Chef Declarative State Management (DSM) in [Chef 360 Platform](/360/latest/), the direct replacement for Chef Infra Server |
| Test before you ship | You test on a workstation first, then promote the same revision. | [Chef Workstation](/workstation/latest/) |

## What you'll build

A Chef Infra cookbook, `fleet_baseline`, and three policies:

- A base recipe for each operating system. Each creates a configuration directory and schedules Chef Infra Client with the scheduler that platform uses: a systemd timer on Linux, and a scheduled task on Windows.
- A site recipe that writes a site file with that site's name and log endpoint, using the right path and line endings for the platform.
- A `base` policy that runs the base recipe, and two site policies, `site-dc1` for a data center and `site-cloud-a` for a cloud account, that each include `base` and set their own values.

It's a small stand-in for real work: the same pattern applies to any setting that differs by operating system or by site.
You'll test both operating systems from one workstation, build the three policies, and check that every site pins the same cookbook.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/install/) on the machine where you write and test code.
  It includes the `chef` command, ChefSpec, and Cookstyle.
- A Progress Chef license, for bootstrapping nodes and for commercial downloads.
  See [Chef license key](/licensing/license_key/).
- A central service your nodes can reach: [Chef 360 Platform Declarative State Management (DSM)](/360/latest/understand/dsm/) or [Chef Infra Server](/server/).
  The tests on this page don't need one.

The cookbook was checked with ChefSpec and Cookstyle in Chef Workstation, and the policies were built and exported with the `chef` command.
It wasn't converged on a Windows or Linux server for this page, so test it on a throwaway machine of each type before you roll it out.

## Write the cookbook

To create a cookbook that applies one baseline to both operating systems, follow these steps:

1. Create a repository, a cookbook, and a folder for the policies:

   ```shell
   chef generate repo chef-repo
   cd chef-repo
   chef generate cookbook cookbooks/fleet_baseline
   mkdir policyfiles
   ```

   The cookbook contains a `recipes/default.rb`, a `metadata.rb`, a `kitchen.yml` for testing, and a `compliance` directory.
   See [cookbooks](/client/latest/cookbooks/) for what each part is for.

1. Create `cookbooks/fleet_baseline/attributes/default.rb`.
   These are the defaults for every node, and a site policy overrides the ones that differ:

   ```ruby
   default['fleet_baseline']['site'] = 'unassigned'
   default['fleet_baseline']['log_endpoint'] = 'logs.example.com'
   default['fleet_baseline']['interval_minutes'] = 30
   default['fleet_baseline']['splay_minutes'] = 5
   ```

1. Replace `cookbooks/fleet_baseline/recipes/default.rb`.
   This recipe only chooses which platform recipe to run:

   ```ruby
   include_recipe "fleet_baseline::#{platform?('windows') ? 'windows' : 'linux'}"
   ```

   `platform?` is a [helper method](/client/latest/infra_language/checking_platforms/) that returns true when the node's platform matches one of the names you give it.
   Chef Infra Client reads the platform from the data that Ohai collects during each run.

1. Create `cookbooks/fleet_baseline/recipes/linux.rb`:

   ```ruby
   directory '/etc/fleet-baseline' do
     mode '0755'
   end

   chef_client_systemd_timer 'Run Chef Infra Client on a schedule' do
     interval "#{node['fleet_baseline']['interval_minutes']}min"
     splay "#{node['fleet_baseline']['splay_minutes']}min"
   end
   ```

1. Create `cookbooks/fleet_baseline/recipes/windows.rb`:

   ```ruby
   directory 'C:/fleet-baseline'

   chef_client_scheduled_task 'Run Chef Infra Client on a schedule' do
     frequency 'minute'
     frequency_modifier node['fleet_baseline']['interval_minutes']
     splay node['fleet_baseline']['splay_minutes'] * 60
   end
   ```

   The two scheduling resources do the same job, but they take different values.
   `chef_client_systemd_timer` takes durations such as `30min`, and `chef_client_scheduled_task` takes a `frequency`, a `frequency_modifier`, and a `splay` in seconds.
   The recipe converts one attribute for both, so the schedule for a site is one number.

1. Create `cookbooks/fleet_baseline/recipes/site.rb`.
   This is the recipe that each site policy adds to the run-list:

   ```ruby
   config_dir = platform?('windows') ? 'C:/fleet-baseline' : '/etc/fleet-baseline'
   eol = platform?('windows') ? "\r\n" : "\n"

   file "#{config_dir}/site.conf" do
     content "site=#{node['fleet_baseline']['site']}#{eol}" \
             "log_endpoint=#{node['fleet_baseline']['log_endpoint']}#{eol}"
   end
   ```

1. Replace `cookbooks/fleet_baseline/metadata.rb`:

   ```ruby
   name 'fleet_baseline'
   description 'Apply one baseline to Linux and Windows nodes at every site'
   license 'Apache-2.0'
   version '0.1.0'
   chef_version '>= 18.0'

   supports 'ubuntu', '>= 22.04'
   supports 'windows', '>= 10.0'
   ```

The `directory` and `file` resources are the same on both platforms.
The paths, the line endings, and the scheduler are the parts that differ, and each is in one place.
If you add macOS nodes, [`chef_client_launchd`](/client/latest/resources/bundled/chef_client_launchd/) is the equivalent scheduler.

## Test before you ship

A cookbook that changes nodes needs testing before it runs on them.
Chef Workstation includes the tools for that, so a change can be checked on your workstation or in a disposable machine first.

| Tool | What it checks |
| --- | --- |
| Cookstyle | Style and common mistakes in your Chef Infra code |
| [ChefSpec](/workstation/latest/tools/chefspec/) | What a recipe would do on a given platform, without running it on a system |
| [Test Kitchen](/workstation/latest/tools/kitchen/) | Whether the cookbook converges on a real, throwaway machine, and whether the result passes your tests |
| [Chef InSpec](/inspec/latest/) | Whether the finished system meets requirements |

ChefSpec lets you test the Windows branch from a Linux or macOS workstation, because it runs the recipe in memory and tells it which platform to pretend to be.
Create `cookbooks/fleet_baseline/spec/unit/recipes/default_spec.rb`:

```ruby
require 'chefspec'

describe 'fleet_baseline::default' do
  context 'on Linux' do
    platform 'ubuntu', '22.04'

    it 'creates the Linux config directory' do
      expect(chef_run).to create_directory('/etc/fleet-baseline')
    end

    it 'schedules Chef Infra Client with a systemd timer' do
      expect(chef_run).to add_chef_client_systemd_timer('Run Chef Infra Client on a schedule')
        .with(interval: '30min', splay: '5min')
    end

    it 'does not create a scheduled task' do
      expect(chef_run).not_to add_chef_client_scheduled_task('Run Chef Infra Client on a schedule')
    end
  end

  context 'on Windows' do
    platform 'windows', '2019'

    it 'creates the Windows config directory' do
      expect(chef_run).to create_directory('C:/fleet-baseline')
    end

    it 'schedules Chef Infra Client with a scheduled task' do
      expect(chef_run).to add_chef_client_scheduled_task('Run Chef Infra Client on a schedule')
        .with(frequency: 'minute', frequency_modifier: 30, splay: 300)
    end

    it 'does not create a systemd timer' do
      expect(chef_run).not_to add_chef_client_systemd_timer('Run Chef Infra Client on a schedule')
    end
  end
end
```

Create `cookbooks/fleet_baseline/spec/unit/recipes/site_spec.rb`.
It sets the site values the way a policy would, and checks the file on each platform:

```ruby
require 'chefspec'

describe 'fleet_baseline::site' do
  context 'on Linux with site values from a policy' do
    platform 'ubuntu', '22.04'
    override_attributes['fleet_baseline'] = { 'site' => 'dc1', 'log_endpoint' => 'logs.dc1.example.com' }

    it 'writes the site file with LF line endings' do
      expect(chef_run).to render_file('/etc/fleet-baseline/site.conf')
        .with_content("site=dc1\nlog_endpoint=logs.dc1.example.com\n")
    end
  end

  context 'on Windows with site values from a policy' do
    platform 'windows', '2019'
    override_attributes['fleet_baseline'] = { 'site' => 'cloud-a', 'log_endpoint' => 'logs.cloud-a.example.com' }

    it 'writes the site file with CRLF line endings' do
      expect(chef_run).to render_file('C:/fleet-baseline/site.conf')
        .with_content("site=cloud-a\r\nlog_endpoint=logs.cloud-a.example.com\r\n")
    end
  end
end
```

Run Cookstyle and the tests from the cookbook directory:

```shell
cd cookbooks/fleet_baseline
cookstyle .
chef exec rspec spec
```

```text
9 files inspected, no offenses detected
```

```text
........

8 examples, 0 failures
```

ChefSpec checks what the recipe would do, but it doesn't change a system or schedule a real task.
Use Test Kitchen to converge the cookbook on a Linux machine, and on a Windows machine if you have one, before you roll it out.
The `kitchen.yml` that `chef generate cookbook` creates is the starting point.

## Layer a policy for each site

A Policyfile locks a run-list and cookbook versions into one versioned revision, and it can carry attributes.
The `include_policy` setting merges another policy's lock into the current one, and the included run-list runs first.
That gives you a base policy for what every node gets, and a small policy for each site.

The Policyfiles go in `policyfiles`, next to the cookbook.
Create `policyfiles/base.rb`:

```ruby
name 'base'
default_source :supermarket
run_list 'fleet_baseline::default'
cookbook 'fleet_baseline', path: '../cookbooks/fleet_baseline'
```

Create `policyfiles/site-dc1.rb` for a data center:

```ruby
name 'site-dc1'
default_source :supermarket
include_policy 'base', path: '.'
run_list 'fleet_baseline::site'
cookbook 'fleet_baseline', path: '../cookbooks/fleet_baseline'
default['fleet_baseline']['site'] = 'dc1'
default['fleet_baseline']['log_endpoint'] = 'logs.dc1.example.com'
```

Create `policyfiles/site-cloud-a.rb` for a cloud account:

```ruby
name 'site-cloud-a'
default_source :supermarket
include_policy 'base', path: '.'
run_list 'fleet_baseline::site'
cookbook 'fleet_baseline', path: '../cookbooks/fleet_baseline'
default['fleet_baseline']['site'] = 'cloud-a'
default['fleet_baseline']['log_endpoint'] = 'logs.cloud-a.example.com'
```

`path: '.'` tells Chef Workstation to read the included policy from `base.lock.json` in the same folder, so build the base first.
Run these from the `policyfiles` folder:

```shell
cd ../../policyfiles
chef install base.rb
chef install site-dc1.rb
chef install site-cloud-a.rb
```

Each `chef install` resolves the policy and writes a `.lock.json` file next to it.
For `site-dc1`, the run-list in the lock is `fleet_baseline::default` followed by `fleet_baseline::site`, and the lock records the base revision it included and the site's attributes:

```text
Expanded run list: recipe[fleet_baseline::default], recipe[fleet_baseline::site]
```

A few behaviors are worth knowing, because each one comes up the first time you build this:

- **A site policy needs its own run-list.** A policy that only includes `base` and sets attributes fails with `Invalid run_list. run_list cannot be empty`. That's why `site-dc1` adds `fleet_baseline::site`.
- **The site's attributes win.** A `default` attribute set in a policy replaced the cookbook's own `default` for the same attribute in a test, so the site's value reaches the node.
- **`chef install` reuses an existing lock.** After you change the cookbook, run `chef update` on `base.rb` first, and then on each site policy, so every site records the new base revision and the same cookbook.

```shell
chef update base.rb
chef update site-dc1.rb
chef update site-cloud-a.rb
```

After the update, all three locks pin the same cookbook, and the two site locks record the same base revision.
That's the property that keeps sites from drifting apart: a site can differ in its values, and it can't differ in its code.

Layering has a cost.
A change to `base` produces a new revision of every site policy, so you rebuild and push each one.
For a handful of sites, that's a short loop, and it's the same loop that gives you site-by-site rollout.
See [Policyfiles](/policyfile/) for the full syntax, including other sources for `include_policy`.

## Bring Linux and Windows nodes under management

A node is any machine Chef manages.
Bootstrapping installs Chef Infra Client on it and registers it with the central service.
Add `--policy-name` and `--policy-group` to apply a site policy on the first run.

| Where the node runs | How to enroll it |
| --- | --- |
| Linux, over SSH | `knife bootstrap` with `--sudo` |
| Windows, over WinRM | `knife bootstrap` with `-o winrm`, after you enable WinRM on the node |
| Any node, with Chef 360 Platform | A self-enrollment script, a cookbook, or a CSV file. See [node enrollment](/360/latest/use/operators/node_enrollment/) |
| A machine created from an image | Install Chef Infra Client with user data or another first-boot script. See [unattended bootstrapping](/client/latest/install/bootstrap/#unattended-bootstrapping) |
| A Linux machine where you don't want an agent | Agentless Mode over SSH. See [Agentless Mode](/client/latest/features/agentless/) |

Bootstrap a Linux node in the data center site:

```shell
knife bootstrap <ADDRESS> -U <USERNAME> --sudo --chef-license-key <LICENSE> --policy-name site-dc1 --policy-group production
```

Bootstrap a Windows node in the cloud site:

```shell
knife bootstrap <ADDRESS> -o winrm -U <USERNAME> -P <PASSWORD> --chef-license-key <LICENSE> --policy-name site-cloud-a --policy-group production
```

Replace the placeholders with the node's address, an account that can administer it, and your Chef license ID.
The `-P` option puts a password on the command line, so use an account you can rotate.

Before you bootstrap a Windows node with WinRM, enable WinRM and PowerShell remoting on it, and allow WinRM traffic through the firewall on port 5985 (HTTP) or 5986 (HTTPS).
The [`knife bootstrap` reference](/workstation/latest/tools/knife/knife_bootstrap/) lists the commands and the WinRM connection options.

Push each policy to its group before you bootstrap, as shown in [Roll changes out one site at a time](#roll-changes-out-one-site-at-a-time).
The central service is Chef Declarative State Management (DSM) in Chef 360 Platform, which is the direct replacement for Chef Infra Server.
If you run Chef Infra Server today, see [Migrate from Chef Infra Server](/360/latest/migrate/on_prem_to_self_managed/).

## Run Chef on a schedule

A node stays in a known state only if Chef runs regularly.
The cookbook already schedules Chef Infra Client on each platform, so what's left is choosing the values.
Each platform has its own scheduling resource:

| Platform | Resource | Default interval | Default splay |
| --- | --- | --- | --- |
| Linux with systemd | [`chef_client_systemd_timer`](/client/latest/resources/bundled/chef_client_systemd_timer/) | `30min` | `5min` |
| Linux with cron | [`chef_client_cron`](/client/latest/resources/bundled/chef_client_cron/) | Every 30 minutes (`0,30`) | `300` seconds |
| Windows | [`chef_client_scheduled_task`](/client/latest/resources/bundled/chef_client_scheduled_task/) | `30` minutes | `300` seconds |
| macOS | [`chef_client_launchd`](/client/latest/resources/bundled/chef_client_launchd/) | `30` minutes | `300` seconds |

The splay matters more in a hybrid fleet, because nodes in every site contact one central service.
Chef Infra Client adds a random number between zero and the splay to the interval, to balance the load on the central service by keeping many runs from starting at the same moment.
Two settings help when a site's servers start together, such as after a power event:

- `delay_after_boot` on the systemd timer sets how long to wait after boot before the interval starts. Its default is `1min`.
- `use_consistent_splay` on the Windows scheduled task gives each node the same splay on every run, so a node's slot in the cycle doesn't change.

Pick an interval that matches how fast you need drift corrected, and a splay wide enough for the number of nodes in the largest site.
The documentation doesn't state how many nodes a central service supports for a given interval, so test with a representative group before you scale.

## Roll changes out one site at a time

Sites are policy names, and environments are policy groups.
A node bootstrapped with `--policy-name site-dc1 --policy-group production` follows the revision of `site-dc1` that you pushed to `production`.
Other sites aren't affected until you push their policy.

`chef push` uploads a lock file, with its cookbooks, to a policy group:

```shell
chef push production site-dc1.lock.json
```

To roll a change out, work from the smallest or least critical site to the largest:

1. Change the cookbook, and run the tests.
1. Run `chef update` on `base.rb`, and then on every site policy.
1. Push one site's lock to `production`, and watch that site's nodes through a few runs.
1. Push the next site's lock, and repeat.

Use a `staging` policy group for the same steps before `production`.
The policy group is the environment, and the policy name is the site, so a change can be promoted across environments and across sites independently.
Because every site's lock pins the same cookbook, what you tested in `staging` is what a site receives in `production`.

Use [Chef Courier](/360/latest/use/operators/job_execution/) when you need a coordinated, one-time action across nodes in a set order, such as a restart.
Use policy revisions for changes to the configuration itself.

## See the fleet in one place

After each run, Chef Infra Client reports a summary of what it did.
Chef Automate collects those reports and shows the status of your nodes and their runs.
See [client runs](/automate/client_runs/).

The [node filters](/automate/client_runs/#node-filters) in Chef Automate map to this design:

| Question | Filter |
| --- | --- |
| Which Windows nodes failed? | **Platform** |
| Which nodes belong to one site? | **Policy Name**, such as `site-dc1` |
| Which nodes are in one environment? | **Policy Group**, such as `production` |
| Which nodes run an older revision? | **Policy Revision** |

To send run data to Chef Automate, set the data collector in each node's `client.rb`:

```ruby
data_collector.server_url 'https://<AUTOMATE_FQDN>/data-collector/v0/'
data_collector.token '<TOKEN>'
```

Replace `<AUTOMATE_FQDN>` with the FQDN of your Chef Automate server, and `<TOKEN>` with an API token.
See [Data collection](/automate/data_collection/) for how to create the token.
The [`chef_client_config`](/client/latest/resources/bundled/chef_client_config/) resource can manage `client.rb`, including the data collector and proxy settings, from a cookbook.

## Sites that can't reach the central service

Some sites have restricted or unreliable links to the central service, such as a branch office or a segmented network.
Plan for these points:

- **Export the policy and apply it locally.** `chef export` creates a chef-zero-compatible repository from a lock file, and `chef-client -z` applies it on the node. See [`chef export`](/client/latest/policy/policyfile/#chef-export).
- **Set the proxy.** Chef Infra Client reads `http_proxy`, `https_proxy`, and `no_proxy`. See [proxies](/client/latest/install/proxies/).
- **Install without internet access.** See [install Chef Infra Client in an air-gapped environment](/client/latest/install/install_chef_air_gap/).
- **Chef Automate in a closed network.** See [air-gapped installation](/automate/airgapped_installation/).

To export the `site-dc1` policy, run this from the `policyfiles` folder:

```shell
chef export site-dc1.lock.json ./export-dc1
```

The command writes the repository and tells you how to apply it:

```text
To converge this system with the exported policy, run:
  cd ./export-dc1
  chef-client -z
```

An exported policy runs as a point-in-time copy, so you copy a new export to the site each time the policy changes.
The documentation doesn't describe a way for an exported policy to receive updates on its own.

## Keep compliance consistent

Convergence and compliance answer different questions.
Chef Infra Client makes the node match your code, and Chef InSpec checks that the result meets a requirement.

The [Compliance Phase](/client/latest/features/chef_compliance_phase/) runs Chef InSpec profiles after each Chef Infra Client run.
It requires Chef Infra Client 17 or later, and you turn it on with attributes.
Set them in `attributes/default.rb`, or in the base policy so they apply at every site:

```ruby
default['audit']['compliance_phase'] = true
default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
}
```

This snippet is adapted from the Compliance Phase reference and isn't part of the tested example.
Check each profile against the operating system it targets before you apply it to both Linux and Windows nodes.
See [The Chef way of compliance](/solutions/compliance/) for guidance on building and choosing audits.

## What the documentation doesn't say

This page sticks to what the Chef documentation states and what the example proved.
A few things that people often assume aren't covered, so confirm them before you rely on them:

- **Converges on real servers.** The cookbook passes ChefSpec and Cookstyle, and the policies build and export, but the page doesn't show a run on a Linux or Windows server. Use Test Kitchen on a throwaway machine of each type first.
- **Attribute precedence for policy attributes.** The documentation doesn't spell out how a Policyfile attribute ranks against every cookbook attribute level. The page tested one case: a policy `default` replaced the cookbook's `default`. Check any other combination before you depend on it.
- **Layering with `include_policy`.** The documentation describes the setting and its merge rules. The base-plus-sites pattern, and the behaviors in [Layer a policy for each site](#layer-a-policy-for-each-site), come from running it.
- **Agentless Mode on Windows.** The documentation lists Linux as the supported platform.
- **Central service capacity.** The documentation doesn't give the number of nodes a service supports for a given interval and splay.
- **DSM and the Chef Infra Server commands.** This page uses `knife bootstrap` and `chef push`, and it doesn't describe how DSM and Chef Infra Server differ when you run them. Check the DSM documentation for your service.
- **Provisioning and networks.** Chef Infra Client doesn't create servers or manage network devices.

## Where to start

If you're new to Chef, work through the example on this page, and then read [the Chef Infra Client run](/client/latest/#the-chef-infra-client-run).
Before you scale up:

- Decide what differs by operating system and what differs by site, and keep the first in recipes and the second in policy.
- Keep every site policy to its attributes and a short run-list, so the logic stays in one cookbook.
- Test each platform branch with ChefSpec, and converge each one on a throwaway machine.
- Give each environment its own policy group, and push one site at a time.
- Choose a splay for your largest site, and check run reports in Chef Automate after a rollout.
- Turn on the Compliance Phase where a baseline applies, and check each profile against its platform.

## Related documentation

- [Chef Infra Client](/client/latest/)
- [Chef Workstation](/workstation/latest/)
- [Chef 360 Platform](/360/latest/)
- [Declarative State Management](/360/latest/understand/dsm/)
- [Policyfiles](/policyfile/)
- [Checking platforms](/client/latest/infra_language/checking_platforms/)
- [Supported platforms](/platforms/)
- [Compliance Phase](/client/latest/features/chef_compliance_phase/)
- [Chef Automate client runs](/automate/client_runs/)
