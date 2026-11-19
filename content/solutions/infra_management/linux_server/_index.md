+++
title = "The Chef way of Linux server configuration management"
description = "Define a baseline configuration for Linux servers in a Chef Infra cookbook, handle distribution differences, test it with Test Kitchen, and roll it out on a schedule with Chef Infra Client."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/linux_server"
  parent = "overview/solutions/infra_management"
  title = "Linux server configuration management"
  weight = 30
+++

Linux fleets rarely run one distribution.
Ubuntu, Red Hat Enterprise Linux, and RHEL-compatible servers name the same packages, services, and configuration files differently,
and settings changed by hand drift a little further apart on every server.

With Chef Infra, you describe the baseline once in a cookbook: time zone, time synchronization, kernel parameters, packages, and administrative access.
Chef Infra Client converges each server to that baseline and, on every later run, changes only what no longer matches.
You handle distribution differences in the cookbook, test them in containers with Test Kitchen, and roll the cookbook out with a Policyfile.

## Choose your target distributions

Chef Infra Client 19 supports these Linux families with a native installer:

| Family | Validated and supported versions | Package manager | Notes |
| --- | --- | --- | --- |
| Ubuntu LTS | 18.04, 20.04, 22.04, 24.04 | `apt` | Use 22.04 or 24.04 for new servers. |
| Debian | 10, 11 | `apt` | |
| Red Hat Enterprise Linux | 8.x, 9.x, 10.x | `dnf` | |
| Amazon Linux | 2, 2023 | `yum` (2), `dnf` (2023) | |
| SUSE Linux Enterprise Server | 12, 15 | `zypper` | |

Rocky Linux and AlmaLinux are supported but untested, and install through Chef Habitat packages.
For the complete matrix, including architectures, certification tiers, and agentless support,
see [Chef Infra Client supported platforms](/client/latest/overview/platforms/).

This page uses Ubuntu 24.04 and Rocky Linux 9 to show how one cookbook handles both the Debian and RHEL families.

## What you'll build

You'll create a `base_linux` cookbook that applies the same baseline to every server:

- The time zone is UTC.
- `chrony` synchronizes time against the NTP servers you choose.
- The `vm.swappiness` kernel parameter has a defined value.
- Members of the `ops` group can run commands with `sudo`.
- Chef Infra Client runs on a schedule so the baseline stays in place.

The example is a starting point, not a hardening standard.
To assess servers against a CIS Benchmark or DISA STIG, see the [Chef Compliance solution](/solutions/compliance/).

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/) 26 or later, which includes Test Kitchen, Cookstyle, and Chef InSpec.
- A [Chef license key](/licensing/license_key/).
  Test Kitchen and `knife bootstrap` use it to download Chef Infra Client 19.
- Docker or Podman on your workstation, for the Test Kitchen Dokken driver.
- At least one disposable Linux server for each distribution you run, with SSH access and `sudo` rights.
- Optional: A [Chef 360 Platform DSM](/360/latest/understand/dsm/) or [Chef Infra Server](/server/) organization,
  if you want nodes to download policies from a server.

## Create the cookbook

1. Generate a cookbook.
   Chef Workstation creates a Policyfile and a Test Kitchen configuration with it:

   ```shell
   chef generate cookbook base_linux
   cd base_linux
   ```

1. Create `attributes/default.rb` with the values that change between environments:

   ```ruby
   default['base_linux']['ntp_servers'] = %w(0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org)
   default['base_linux']['swappiness'] = 10
   ```

1. Replace `recipes/default.rb` with the following recipe:

   ```ruby
   timezone 'UTC'

   package %w(curl chrony)

   # Debian-family and RHEL-family distributions name the chrony service and file differently.
   chrony_conf, chrony_service = if platform_family?('debian')
                                   ['/etc/chrony/chrony.conf', 'chrony']
                                 else
                                   ['/etc/chrony.conf', 'chronyd']
                                 end

   template chrony_conf do
     source 'chrony.conf.erb'
     owner 'root'
     group 'root'
     mode '0644'
     variables(servers: node['base_linux']['ntp_servers'])
     notifies :restart, "service[#{chrony_service}]"
   end

   service chrony_service do
     action [:enable, :start]
   end

   sysctl 'vm.swappiness' do
     value node['base_linux']['swappiness']
   end

   group 'ops'

   sudo 'ops' do
     groups 'ops'
   end
   ```

1. Generate the `chrony` template:

   ```shell
   chef generate template . chrony.conf
   ```

1. Replace the contents of `templates/chrony.conf.erb` with the following:

   ```erb
   # Managed by Chef Infra. Local changes are overwritten on the next run.
   <% @servers.each do |server| -%>
   server <%= server %> iburst
   <% end -%>
   driftfile /var/lib/chrony/drift
   makestep 1.0 3
   rtcsync
   ```

The recipe uses built-in resources, so you don't call `apt`, `dnf`, `sysctl`, or `visudo` yourself:

- The [package](/client/latest/resources/bundled/package/) resource selects the platform's package manager.
  It doesn't map package names, so where a package name differs between distributions, set it in the recipe.
- `platform_family?('debian')` handles the difference in the `chrony` service name and configuration file path.
- The [template](/client/latest/resources/bundled/template/) resource restarts `chrony` only when the file content changes.
- The [sysctl](/client/latest/resources/bundled/sysctl/) resource sets the value now and persists it in `/etc/sysctl.d/`.
- The [sudo](/client/latest/resources/bundled/sudo/) resource writes `/etc/sudoers.d/ops` and checks it with `visudo`.
- The [timezone](/client/latest/resources/bundled/timezone/) resource sets the system time zone.

## Test the cookbook on each distribution

Test Kitchen converges the cookbook in a container for each distribution and then runs Chef InSpec tests against it.
For Chef Infra Client 19, Chef Test Kitchen Enterprise supports the [Dokken driver](/workstation/latest/tools/kitchen/run/).

1. Replace `kitchen.yml` with the following.
   Replace `<CHEF_VERSION>` with the Chef Infra Client 19 version you run on your servers:

   ```yaml
   ---
   driver:
     name: dokken
     privileged: true
     chef_version: <CHEF_VERSION>

   provisioner:
     name: dokken

   transport:
     name: dokken

   verifier:
     name: inspec

   platforms:
     - name: ubuntu-24.04
       driver:
         image: dokken/ubuntu-24.04
         pid_one_command: /bin/systemd
     - name: rockylinux-9
       driver:
         image: dokken/rockylinux-9
         pid_one_command: /usr/lib/systemd/systemd

   suites:
     - name: default
       verifier:
         inspec_tests:
           - test/integration/default
   ```

1. Replace `test/integration/default/default_test.rb` with tests for the baseline:

   ```ruby
   chrony_service = os.debian? ? 'chrony' : 'chronyd'

   describe package('chrony') do
     it { should be_installed }
   end

   describe service(chrony_service) do
     it { should be_enabled }
     it { should be_running }
   end

   describe kernel_parameter('vm.swappiness') do
     its('value') { should eq 10 }
   end

   describe file('/etc/sudoers.d/ops') do
     its('content') { should match(/^%ops ALL=\(ALL\) ALL$/) }
   end
   ```

1. Lint the cookbook, then converge and verify it on both distributions:

   ```shell
   cookstyle .
   kitchen test
   ```

   `kitchen test` creates, converges, verifies, and destroys each container.
   During development, run `kitchen converge` twice.
   When the cookbook is idempotent, the second run reports that no resources were updated.

Containers share the host kernel, so a kernel parameter can behave differently in a container than on a virtual machine.
Before you roll out kernel settings, converge the cookbook on a test server for each distribution.

## Roll out the cookbook

Use a Policyfile to lock the cookbook versions that every server in a group runs.
The generated `Policyfile.rb` already sets the run-list to `base_linux::default`.

1. Lock the policy and its dependencies:

   ```shell
   chef install
   ```

1. Push the locked policy to a small policy group first:

   ```shell
   chef push staging
   ```

   With Chef 360 Platform, store the policy in DSM instead.
   See the [Declarative State Management overview](/360/latest/understand/dsm/).

1. Bootstrap each staging server into that policy group:

   ```shell
   knife bootstrap <ADDRESS> -U <USERNAME> --sudo \
     --chef-license-key <LICENSE_KEY> \
     --policy-name base_linux --policy-group staging
   ```

   Replace:

   - `<ADDRESS>` with the server's IP address or FQDN.
   - `<USERNAME>` with an SSH user that has `sudo` rights.
   - `<LICENSE_KEY>` with your Chef license key.

   See [Bootstrap a node with Chef Infra](/client/latest/install/bootstrap/) for authentication and proxy options.
   On Chef 360 Platform, see [Enroll nodes with a Chef Infra cookbook](/360/latest/use/operators/node_enrollment/cookbook/).

1. Review the results on the [Client Runs](/automate/client_runs/) page in Chef Automate,
   or in the Chef Infra Client output on each server.
1. When the staging servers are healthy, push the same lock file to the production group:

   ```shell
   chef push production
   ```

For servers where you don't install Chef Infra Client, you can apply the same cookbook over SSH with
[Agentless Mode](/client/latest/features/agentless/).

## Keep servers converged

A single Chef Infra Client run sets the baseline, but it doesn't stop someone from changing a server afterward.
Add a [chef_client_systemd_timer](/client/latest/resources/bundled/chef_client_systemd_timer/) resource to the recipe
so that Chef Infra Client runs on a schedule and corrects drift:

```ruby
chef_client_systemd_timer 'chef-client' do
  interval '30min'
  splay '5min'
  accept_chef_license true
end
```

The `splay` property adds a random delay so your servers don't all contact Chef Infra Server or DSM at the same time.
The resource runs `/opt/chef/bin/chef-client` by default.
If `command -v chef-client` returns a different path on your servers, set the `chef_binary_path` property to that path.

## Plan for production

- Keep the cookbook, Policyfile, and tests in version control, and require review for every change.
- Run `cookstyle` and `kitchen test` in your CI pipeline for each distribution you run.
- Move a policy through policy groups such as `staging` and `production` instead of changing production directly.
- The first run on a server already in service changes everything that differs from the cookbook.
  Run `chef-client --why-run` on a representative server to see what would change before you assign the policy.
- Put environment-specific values, such as NTP servers, in attributes and override them in the Policyfile instead of editing the recipe.

## Related resources

- [Chef Infrastructure Management overview](/solutions/infra_management/)
- [Chef Compliance solution](/solutions/compliance/)
- [Chef Infra Client resources](/client/latest/resources/)
- [Policyfiles](/client/latest/policy/policyfile/)
- [Test Kitchen](/workstation/latest/tools/kitchen/)
