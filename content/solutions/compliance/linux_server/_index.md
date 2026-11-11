+++
title = "The Chef way of Linux server compliance"
description = "Keep Linux servers consistent across distributions with Chef Infra Client, then verify packages, users, services, and files with Chef InSpec."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/linux_server"
  parent = "overview/solutions/compliance"
  title = "Linux server compliance"
  weight = 7
+++

Linux servers across several distributions need the same packages, users, services, and files.
Hand-configuration produces snowflake servers: each host drifts a little further from the others,
and checking them by hand doesn't scale.

Use Chef Infra Client to describe the configuration you want and converge each server to it.
Use Chef InSpec to check that the required state is present and report what fails.
The same recipe and profile can cover multiple distributions when the package and service names
match; where they differ, account for those differences in your cookbook.

## Choose a Linux distribution

If you don't already have a platform standard, use **Ubuntu Server 24.04 LTS** for this walkthrough.
Chef lists Ubuntu 24.04 as validated and supported for Chef Infra Client.
Canonical lists standard security maintenance through May 2029 and Ubuntu Pro coverage through
May 2034. Canonical also lists CIS and DISA STIG coverage for 24.04 as achieved.

Ubuntu Server 26.04 LTS is a good choice if you want the newest LTS release and a longer standard
support window, through May 2031. Its CIS and DISA STIG coverage is listed as planned, so use 24.04
if established coverage for those standards matters to your example.

Choose a RHEL-compatible distribution such as Rocky Linux when it matches your organization's
platform standard. Chef lists Rocky Linux 9 as supported but untested, and the Rocky Linux project
lists security support through May 31, 2032. Test your cookbook on the exact distributions and
versions you run.

| Distribution | Choose it when |
| --- | --- |
| Ubuntu Server 24.04 LTS | You want a broadly validated starting point with established CIS and DISA STIG coverage. |
| Ubuntu Server 26.04 LTS | You want the latest LTS and a longer standard support window, and can validate your compliance content. |
| Rocky Linux 9 | Your organization standardizes on a RHEL-compatible distribution and you can test Chef's untested support tier. |

Support and compliance status change. Check the
[Chef supported platforms](/platforms/),
[Ubuntu release cycle](https://ubuntu.com/about/release-cycle),
and [Rocky Linux release notes](https://docs.rockylinux.org/9/release_notes/)
before choosing a production platform.

## What you'll build

You'll create a cookbook that keeps four things consistent on each Linux server:

- The `nginx` package is installed.
- A `deploy` user exists with a home directory and a Bash shell.
- The `nginx` service is enabled and running.
- A managed file exists with defined content, owner, and permissions.

Then you'll write a Chef InSpec profile that checks those same requirements.
This example demonstrates configuration consistency; it isn't a complete CIS Benchmark or DISA STIG.

{{< note >}}

**Where the details come from.**
Chef Infra Client's [package](/client/19/resources/bundled/package/),
[user](/client/19/resources/bundled/user/),
[service](/client/19/resources/bundled/service/),
and [file](/client/19/resources/bundled/file/) resources define the desired state.
The [Chef InSpec resource reference](/inspec/latest/resources/) documents the checks.
The example output and configuration are illustrative; adapt them to your own standards.

{{< /note >}}

## Before you begin

You need:

- **Chef Workstation**, which includes Chef Infra Client and Chef InSpec.
  Run `chef --version` and `inspec version` to confirm they're available.
- **A disposable Linux server** to test on, with network access to its package repositories.
- **Administrative access** on the server to install packages, create users, and manage services.
- **SSH access** to the server if you run Chef InSpec from a separate workstation.

Test on a non-production server first.
The example creates a login-capable `deploy` user; adapt its shell, access, and authentication
to your organization's requirements before using a recipe in production.

## Step 1: Create a cookbook

Generate a Chef Infra repository and go to its example cookbook:

```shell
chef generate repo linux-compliance
cd linux-compliance/cookbooks/example
```

Replace `recipes/default.rb` with the following recipe:

```ruby
package 'nginx'

user 'deploy' do
  comment 'Managed by Chef Infra'
  home '/home/deploy'
  manage_home true
  shell '/bin/bash'
end

file '/etc/profile.d/chef-baseline.sh' do
  content "export CHEF_BASELINE='managed'\n"
  owner 'root'
  group 'root'
  mode '0644'
end

service 'nginx' do
  action [:enable, :start]
end
```

The `package` resource selects a package provider for the platform, so the recipe doesn't need
separate `apt`, `dnf`, or `zypper` commands.
Provider selection doesn't make different package names equivalent: if a distribution uses a
different name for a package or service, map that name in your cookbook.

The file resource writes the same content and permissions on every server.
The service resource enables NGINX at boot and starts it now.
On the next run, Chef Infra Client checks the current state and changes only what doesn't match.

## Step 2: Converge a test server

From the cookbook directory, run the recipe locally on the test server:

```shell
chef-client --local-mode --override-runlist example
```

The run installs NGINX, creates or updates the `deploy` account, writes the managed file, and
starts and enables the service.
Run the command again: when the server already matches the recipe, Chef Infra Client makes no
changes.

## Step 3: Write the compliance checks

Create a Chef InSpec profile in the repository root:

```shell
cd ../..
inspec init profile linux-server-baseline
```

In `linux-server-baseline/inspec.yml`, set the `supports` section to:

```yaml
supports:
  - platform-family: linux
```

Replace the generated example control with `linux-server-baseline/controls/linux.rb`:

```ruby
control 'linux-server-01' do
  impact 'high'
  title 'Required server configuration is present'
  desc 'Linux servers must have the managed package, account, service, and file.'
  tag 'linux', 'configuration'

  describe package('nginx') do
    it { should be_installed }
  end

  describe user('deploy') do
    it { should exist }
    its('shell') { should eq '/bin/bash' }
  end

  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/profile.d/chef-baseline.sh') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should include "CHEF_BASELINE='managed'" }
  end
end
```

The `supports` entry lets Chef InSpec run the profile against Linux targets.
The control checks the package, account, service, and file independently, so the report identifies
which part of the desired state is missing.

## Step 4: Run the assessment

Check the profile before running it:

```shell
inspec check linux-server-baseline
```

To assess the server from your workstation over SSH, replace the placeholders with your SSH
username and server address:

```shell
inspec exec linux-server-baseline \
  --target ssh://<USER>@<SERVER> \
  --sudo
```

Chef InSpec reports a pass or failure for each assertion.
If an assertion fails, compare the result with your intended standard, converge the server with
Chef Infra Client, and run the profile again.

## Apply the pattern across your fleet

Keep the cookbook and profile in version control.
Test cookbook changes on each supported distribution you run, especially where package names,
service names, file locations, or account policies differ.
Roll changes out in stages, then run the InSpec profile to confirm each group of servers matches
the baseline.

For ongoing assessments of Chef-managed nodes, add the profile to the
[Chef Infra Client Compliance Phase](/client/latest/features/chef_compliance_phase/)
and review results in [Chef Automate](/automate/).
Use a CIS or DISA STIG profile when you need to assess a published benchmark; this custom profile
checks only the four requirements in this walkthrough.
