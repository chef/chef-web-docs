+++
title = "The Chef way of managing a small fleet"
description = "Manage a small fleet of Linux servers with Chef 360 Platform: write a cookbook and a Policyfile, publish it to Chef Declarative State Management (DSM), roll it out across policy groups with Chef Courier, and keep compliance evidence from every run."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/small_fleet"
  parent = "overview/solutions/compliance"
  title = "Managing a small fleet"
  weight = 16
+++

A fleet of five to a hundred servers is small enough to manage by logging in and making changes by hand.
Over time, those manual changes leave servers configured differently from each other, with no record of who changed what or why.
They also leave you without a way to show an auditor how a setting is enforced.

Chef replaces manual changes with code that you review, version, and release.
On this page, you write a cookbook that sets a baseline for every server and lock it into a Policyfile.
You then publish that policy directly to Chef Declarative State Management (DSM) in Chef 360 Platform, assign servers to policy groups (canary and fleet), automate recurring runs on a schedule with Chef Courier, and keep the compliance results from every run as evidence.

## What managing a small fleet covers

Managing a fleet with Chef involves four concerns.
Plan each one before you enroll the first server.

| Concern | What you're asking | How Chef handles it |
| --- | --- | --- |
| **Configuration** | What state should every server be in? | A cookbook, with attributes for the values that differ between fleets |
| **Release** | Which exact version of that configuration is running where? | A Policyfile, locked to a revision ID and published to DSM in Chef 360 Platform |
| **Delivery** | How does a release reach every server, and how often is it reapplied? | DSM policy groups (`canary` and `fleet`) and scheduled Chef Courier jobs |
| **Evidence** | Can you prove the configuration is in place? | The Compliance Phase, which runs a Chef InSpec profile at the end of every Chef Infra Client run |

### Chef Declarative State Management in Chef 360 Platform

Chef 360 Platform includes **Chef Declarative State Management (DSM)** as the replacement for Chef Infra Server.

DSM acts as the central repository for configuration data in Chef 360 Platform.
It does the Chef Infra Server job: storing cookbooks, Policyfiles, policy groups, roles, environments, data bags, and client credentials.

With DSM in Chef 360 Platform:

- You publish policies directly from Chef Workstation using `chef push <policy_group>`.
- Nodes authenticate against DSM using standard Chef Infra Client credentials.
- Chef 360 Platform manages policy groups, so you assign nodes to groups like `canary` and `fleet` from the UI or CLI.
- You don't need manual tarball archives or external storage buckets to deliver configuration data.
- Nodes synchronize cookbooks directly from DSM over HTTPS during each Chef Infra Client run.

## What you'll build

A cookbook named `fleet_baseline` that sets, on every server:

- The login banner in `/etc/issue.net`.
- An SSH configuration file that turns off root login and password authentication.
- An `ops` group, and a sudoers file that grants administrative access only to that group.

The cookbook also delivers a Chef InSpec profile that checks those settings.
The Policyfile turns on the Compliance Phase, so every Chef Infra Client run ends with a compliance report.

By the end, you'll publish your policy to DSM, assign a canary server and fleet servers to separate policy groups, and create a Chef Courier job that triggers Chef Infra Client across the fleet on a schedule.

## Before you begin

You need:

- **Chef Workstation**, from [Chef Downloads](https://www.chef.io/downloads).
  Run `chef --version` to confirm it's installed.
- **A Chef 360 Platform tenant with DSM enabled.**
  Ensure your Chef Workstation `.chef/config.rb` file is configured with your DSM organization URL:

  ```ruby
  chef_server_url 'https://<CHEF_360_HOST>/organizations/<ORG_NAME>'
  client_key      '/path/to/user.pem'
  node_name       'your_username'
  ```

- **Linux servers enrolled in Chef 360 Platform** that meet the
  [Chef 360 Platform node requirements](/360/saas/system_requirements/).
  Chef Courier skills and DSM node management run on x86_64 Linux and on Windows Server 2019 and later.
- **Chef Infra Client on each server.**
  Nodes enrolled in DSM authenticate with client keys managed by DSM.
  Chef Infra Client 19 may also need a license key, depending on where you downloaded it---see [Apply a license in Chef Infra Client](/client/latest/license/).
- **A Git repository** for the cookbook and Policyfile.

## Create a cookbook

Generate a cookbook:

```shell
chef generate cookbook fleet_baseline
```

```text
Generating cookbook fleet_baseline
- Ensuring correct cookbook content
- Committing cookbook files to git

Your cookbook is ready. Type `cd fleet_baseline` to enter it.
```

Use underscores in cookbook names, not hyphens.
The generator warns that hyphens can cause problems with custom resources.

The generator creates a `Policyfile.rb`, a `kitchen.yml`, a default recipe, and a Git repository for the cookbook.
Update `maintainer` and `maintainer_email` in `metadata.rb` before you continue.
[Cookstyle](/workstation/cookstyle/) reports the generator's default values as an offense.

## Write the recipe

Create `fleet_baseline/attributes/default.rb`:

```ruby
default['fleet_baseline']['banner'] = "Authorized use only. Activity on this system is monitored and logged.\n"
default['fleet_baseline']['admin_group'] = 'ops'
default['fleet_baseline']['profile_dir'] = '/var/chef/compliance/fleet-baseline'
```

Replace `fleet_baseline/recipes/default.rb` with:

```ruby
admin_group = node['fleet_baseline']['admin_group']
ssh_service = platform_family?('debian') ? 'ssh' : 'sshd'

file '/etc/issue.net' do
  content node['fleet_baseline']['banner']
  owner 'root'
  group 'root'
  mode '0644'
end

directory '/etc/ssh/sshd_config.d' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

file '/etc/ssh/sshd_config.d/01-fleet-baseline.conf' do
  content <<~CONF
    PermitRootLogin no
    PasswordAuthentication no
    Banner /etc/issue.net
  CONF
  owner 'root'
  group 'root'
  mode '0600'
  notifies :restart, "service[#{ssh_service}]", :delayed
end

service ssh_service do
  action :nothing
  only_if { ::File.exist?('/usr/sbin/sshd') }
end

group admin_group

directory '/etc/sudoers.d' do
  owner 'root'
  group 'root'
  mode '0750'
end

file "/etc/sudoers.d/#{admin_group}" do
  content "%#{admin_group} ALL=(ALL) ALL\n"
  owner 'root'
  group 'root'
  mode '0440'
end

remote_directory node['fleet_baseline']['profile_dir'] do
  source 'fleet-baseline-profile'
  owner 'root'
  group 'root'
  mode '0750'
  files_mode '0640'
  purge true
end
```

The `01-` prefix makes sshd read this file first, because sshd uses the first value it finds for a setting and cloud images can ship drop-ins such as `50-cloud-init.conf`.
Distributions that don't already include the drop-in directory need `Include /etc/ssh/sshd_config.d/*.conf` in `/etc/ssh/sshd_config`.

What each part does:

`file` and `directory`
: Declare the content, owner, group, and mode a file or directory must have.
  Chef Infra Client compares that declaration with the server on every run and changes only what's different.
  If someone edits `/etc/sudoers.d/ops` by hand, the next run puts it back.

`notifies :restart, ... :delayed`
: Restarts the SSH service once, at the end of the run, and only if the SSH configuration file changed.
  `ssh_service` resolves to `ssh` on Debian and Ubuntu and to `sshd` on Red Hat Enterprise Linux and its derivatives.
  The `only_if` guard skips the restart on a server that doesn't have the SSH server installed.

`group admin_group`
: Creates the group if it doesn't exist.
  Add members through your identity provider or with a separate `user` resource, so the cookbook defines who has access and the group membership defines who that is.

`remote_directory`
: Copies the Chef InSpec profile from the cookbook's `files/default/fleet-baseline-profile` directory to the server.
  `purge true` removes files from the server that you've removed from the cookbook, so a deleted control doesn't keep running.

Attributes hold the values a different fleet might change, such as the banner text or the group name.
Override them in the Policyfile in [Define the policy](#define-the-policy) rather than editing the recipe.

## Add the compliance profile

The profile checks the same settings the recipe enforces.
It runs after the recipe, in the same Chef Infra Client run, so each run reports whether the configuration it applied is actually in place.

Create `fleet_baseline/files/default/fleet-baseline-profile/inspec.yml`:

```yaml
name: fleet-baseline
title: Small fleet baseline
maintainer: Example Organization, Inc.
copyright: Example Organization, Inc.
copyright_email: compliance@example.com
license: Apache-2.0
summary: Verify the settings the fleet_baseline cookbook enforces on every node
version: 0.1.0
supports:
  - platform-family: linux
inputs:
  - name: admin_group
    description: Group whose members can escalate with sudo
    type: String
    value: ops
```

Create `fleet_baseline/files/default/fleet-baseline-profile/controls/fleet.rb`:

```ruby
control 'fleet-01' do
  impact 'medium'
  title 'Show the login banner'
  desc 'Every node must show the approved banner before login.'
  tag 'fleet', 'banner'

  describe file('/etc/issue.net') do
    it { should be_file }
    its('content') { should match(/Authorized use only/) }
    its('mode') { should cmp '0644' }
  end
end

control 'fleet-02' do
  impact 'high'
  title 'Turn off root and password SSH logins'
  desc 'SSH must refuse root logins and password authentication.'
  tag 'fleet', 'ssh'

  describe file('/etc/ssh/sshd_config.d/01-fleet-baseline.conf') do
    its('content') { should match(/^PermitRootLogin no$/) }
    its('content') { should match(/^PasswordAuthentication no$/) }
    its('mode') { should cmp '0600' }
  end
end

control 'fleet-03' do
  impact 'high'
  title 'Define sudo access for the admin group'
  desc 'Administrative access must come from one group so that access reviews have one place to look.'
  tag 'fleet', 'access'

  describe group(input('admin_group')) do
    it { should exist }
  end

  describe file("/etc/sudoers.d/#{input('admin_group')}") do
    its('content') { should cmp "%#{input('admin_group')} ALL=(ALL) ALL\n" }
    its('mode') { should cmp '0440' }
    its('owner') { should cmp 'root' }
  end
end
```

This profile checks your own baseline.
To assess servers against a published benchmark as well, add the benchmark profile to `node['audit']['profiles']` in the next section.
See [Operating Systems](/premium_content/operating_systems/) for the benchmarks Chef covers.

## Define the policy

The Policyfile names the run list, pins every cookbook, and sets the attributes for this fleet.
Replace `fleet_baseline/Policyfile.rb` with:

```ruby
name 'fleet_baseline'

default_source :supermarket

run_list 'fleet_baseline::default'

cookbook 'fleet_baseline', path: '.'

default['audit']['compliance_phase'] = true
default['audit']['profiles']['fleet-baseline'] = {
  'path' => '/var/chef/compliance/fleet-baseline',
}
default['audit']['reporter'] = %w(cli json-file)
default['audit']['json_file']['location'] = '/var/chef/compliance/report.json'
```

The `audit` attributes configure the [Compliance Phase](/client/latest/features/chef_compliance_phase/):

`compliance_phase`
: Runs Chef InSpec at the end of every Chef Infra Client run.

`profiles`
: Runs the profile the recipe copied to `/var/chef/compliance/fleet-baseline`.

`reporter`
: Prints results in the Chef Infra Client output with `cli`, and writes the full report to the `json_file` location with `json-file`.
  If you report to Chef Automate, see the [Compliance Phase reporters](/client/latest/features/chef_compliance_phase/#reporters).

Lint the cookbook, then lock the policy:

```shell
cd fleet_baseline
cookstyle .
chef install
```

```text
5 files inspected, no offenses detected
Building policy fleet_baseline
Expanded run list: recipe[fleet_baseline::default]
Caching Cookbooks...
Installing fleet_baseline >= 0.0.0 from path

Lockfile written to /path/to/fleet_baseline/Policyfile.lock.json
Policy revision id: de198f7d30756baeaebf34062927b88402451ae51a94edfbcbd6428c6c4366d2
```

`chef install` resolves every cookbook and records the exact version and content of each one in `Policyfile.lock.json`.
The policy revision ID identifies that exact set.
Any change to a cookbook, an attribute, or the run list produces a new revision ID, so the ID tells you precisely what a server ran.

Commit `Policyfile.rb` and `Policyfile.lock.json` together.
After you change the cookbook or the Policyfile, run `chef update` to recompute the lock.
See [Policyfile](/client/latest/policy/policyfile/) for every setting.

## Test the policy before you release it

Test Kitchen builds a test server, applies the policy, runs the profile against it, and destroys it.
The `kitchen.yml` that `chef generate cookbook` created already uses the policy.
Point its verifier at the profile in the cookbook:

```yaml
suites:
  - name: default
    verifier:
      inspec_tests:
        - path: files/default/fleet-baseline-profile
```

Keep only the platforms your fleet runs in the `platforms` list, then run:

```shell
kitchen test
```

Run `kitchen test` in your CI pipeline on every pull request, so a change reaches the release step only after the policy converges and the profile passes.
See [Test Kitchen](/workstation/latest/tools/kitchen/) for drivers and other options.

## Publish the policy to DSM

In Chef 360 Platform, DSM uses **policy groups** to bind nodes to a specific revision of a Policyfile.
For a small fleet, define two policy groups:

- `canary`: for a designated test server where you verify new releases first.
- `fleet`: for the rest of your servers.

Publish the locked policy to the `canary` policy group in DSM:

```shell
chef push canary
```

```text
Deploying Policyfile 'fleet_baseline' to policy group 'canary' in DSM
Uploaded fleet_baseline (0.1.0)
Policy revision id: de198f7d30756baeaebf34062927b88402451ae51a94edfbcbd6428c6c4366d2
Policyfile 'fleet_baseline' successfully published to 'canary'
```

`chef push` uploads the cookbooks and policy revision directly to DSM over HTTPS.
In the Chef 360 Platform UI, go to **DSM** > **Policyfiles** to view the policy, its revision ID, run list, and cookbook dependencies.
In **DSM** > **Policy Groups**, you can view the `canary` group and the nodes assigned to it.

## Converge the canary node

Assign your canary server to the `canary` policy group in DSM:

1. In the Chef 360 Platform UI, go to **DSM** > **Nodes**.
1. Locate your canary server, select the three dots in the **Actions** column, and select **Update Policy Group**.
1. Select **canary**, and select **Update Node Policy Group**.

Run Chef Infra Client on the canary server over SSH or with a one-time command:

```shell
chef-client
```

Chef Infra Client contacts DSM, receives the `fleet_baseline` policy assigned to `canary`, synchronizes the cookbook, and applies the configuration:

```text
Chef Infra Client, version 18.11.11
Using Policyfile 'fleet_baseline' at revision 'de198f7d30756baeaebf34062927b88402451ae51a94edfbcbd6428c6c4366d2'
Resolving cookbooks for run list: ["fleet_baseline::default@0.1.0"]
Synchronizing cookbooks:
  - fleet_baseline (0.1.0)
Installing Cookbook Gems:
Compiling Cookbooks...
Converging 5 resources
...
Infra Phase complete, 10/12 resources updated in 00 seconds
Compliance report:
 * Small fleet baseline
      Show the login banner
         + File /etc/issue.net is expected to be file
         + File /etc/issue.net content is expected to match /Authorized use only/
         + File /etc/issue.net mode is expected to cmp == "0644"
      Turn off root and password SSH logins
         + File /etc/ssh/sshd_config.d/01-fleet-baseline.conf content is expected to match /^PermitRootLogin no$/
         + File /etc/ssh/sshd_config.d/01-fleet-baseline.conf content is expected to match /^PasswordAuthentication no$/
         + File /etc/ssh/sshd_config.d/01-fleet-baseline.conf mode is expected to cmp == "0600"
      Define sudo access for the admin group
         + Group ops is expected to exist
         + File /etc/sudoers.d/ops content is expected to cmp == "%ops ALL=(ALL) ALL\n"
         + File /etc/sudoers.d/ops mode is expected to cmp == "0440"
         + File /etc/sudoers.d/ops owner is expected to cmp == "root"
```

Run Chef Infra Client a second time on the canary node:

```text
Infra Phase complete, 0/10 resources updated in 00 seconds
```

Zero resources updated on the second run confirms the policy is idempotent.

{{< note >}}

Before you apply the policy, confirm that you can log in to the server as a non-root user with an SSH key, and that this user can use `sudo`.
The policy turns off root and password logins when the SSH service restarts at the end of the run.

{{< /note >}}

Once the canary converges and passes all compliance controls, promote the policy to the rest of the fleet by publishing it to the `fleet` policy group:

```shell
chef push fleet
```

All servers assigned to the `fleet` policy group will receive this revision on their next Chef Infra Client run.

## Automate runs with Chef Courier

Use [Chef Courier](/360/latest/use/operators/job_execution/) in Chef 360 Platform to schedule Chef Infra Client runs across all enrolled nodes.
This ensures every node runs Chef periodically to detect and correct configuration drift.

Create `fleet-baseline-job.json`:

```json
{
  "name": "fleet-baseline-converge",
  "description": "Trigger Chef Infra Client runs against DSM every four hours",
  "scheduleRule": "RRULE:FREQ=HOURLY;INTERVAL=4",
  "exceptionRules": [],
  "target": {
    "executionType": "sequential",
    "groups": [
      {
        "timeoutSeconds": 600,
        "batchSize": { "type": "number", "value": 1 },
        "distributionMethod": "batching",
        "successCriteria": [
          { "numRuns": { "type": "percent", "value": 100 }, "status": "success" }
        ],
        "nodeListType": "nodes",
        "nodeIdentifiers": ["<CANARY_NODE_ID>"]
      },
      {
        "timeoutSeconds": 1800,
        "batchSize": { "type": "percent", "value": 25 },
        "distributionMethod": "rolling",
        "successCriteria": [
          { "numRuns": { "type": "percent", "value": 100 }, "status": "success" }
        ],
        "nodeListType": "nodes",
        "nodeIdentifiers": ["<NODE_ID_1>", "<NODE_ID_2>", "<NODE_ID_3>"]
      }
    ]
  },
  "actions": {
    "accessMode": "agent",
    "steps": [
      {
        "name": "run-chef-client",
        "interpreter": {
          "skill": { "minVersion": "1.0.0", "maxVersion": "1.9.99" },
          "name": "chef-platform/shell-interpreter"
        },
        "command": {
          "linux": [
            "/opt/chef/bin/chef-client --chef-license accept-silent"
          ],
          "windows": [
            "chef-client --chef-license accept-silent"
          ]
        },
        "inputs": {},
        "expectedInputs": {},
        "outputFieldRules": {},
        "retryCount": 1,
        "failureBehavior": {
          "action": "retryThenFail",
          "retryBackoffStrategy": { "type": "linear", "delaySeconds": 15, "arguments": [] }
        },
        "limits": { "timeoutSeconds": 300 },
        "conditions": []
      }
    ]
  }
}
```

{{< note >}}

`--chef-license accept-silent` accepts the Chef license on behalf of your organization.
Confirm that your organization has agreed to the license terms before you schedule this job.

{{< /note >}}

Replace `<CANARY_NODE_ID>` and `<NODE_ID_1>`, `<NODE_ID_2>`, `<NODE_ID_3>` with your enrolled server node IDs.

How this job coordinates delivery:

`scheduleRule`
: Runs the job every four hours (`RRULE:FREQ=HOURLY;INTERVAL=4`), so any unauthorized manual change is detected and reverted within four hours.

`target.executionType: sequential`
: Targets the canary node group first.
  If the canary run fails, Courier aborts the execution before reaching the rest of the fleet.

`batchSize` and `distributionMethod: rolling`
: Rolls out to 25% of the remaining fleet at a time, starting each new server as the previous one finishes.

`run-chef-client`
: Executes Chef Infra Client on the node.
  Because the node is enrolled in DSM, `client.rb` is already configured with the DSM endpoint and client key.
  Chef Infra Client connects to DSM, downloads the revision for its policy group, and runs the Compliance Phase.

Submit the job:

```shell
chef-courier-cli scheduler jobs add-job --body-file fleet-baseline-job.json --profile <COURIER_OPERATOR_PROFILE_NAME>
```

Chef Courier returns a job ID that you can use to monitor execution status and download logs.
See [Create a Courier job with the CLI](/360/latest/use/operators/job_execution/).

## Change the fleet safely

Every change follows a predictable path through DSM:

1. Update the cookbook or Policyfile in a Git branch, and test with `kitchen test`.
1. After review and merge, run `chef update` to lock the new revision ID.
1. Deploy to the canary policy group in DSM:

   ```shell
   chef push canary
   ```

1. Trigger the Courier job or run `chef-client` on the canary node to verify the change.
1. Promote the policy to the fleet policy group in DSM:

   ```shell
   chef push fleet
   ```

   All fleet nodes converge on the new revision during their next scheduled run.

To roll back, push the previous revision lock back to DSM:

```shell
chef push fleet Policyfile.lock.json.previous
```

Rolling back reapplies the previous policy.
It doesn't undo changes the newer policy made that the previous policy doesn't manage.
For example, if the new release added a package and you roll back, the package stays installed until a policy removes it.
Plan reversible changes with an explicit `action :remove` in a later release.

## Correct drift

Drift is any change made on a server outside a release.
Each scheduled run of Chef Infra Client corrects it.

In this run, someone had set `PermitRootLogin yes` in the SSH configuration file and changed the mode of the sudoers file.
Chef Infra Client corrected both and left everything else alone:

```text
  * file[/etc/issue.net] action create (up to date)
  * file[/etc/ssh/sshd_config.d/01-fleet-baseline.conf] action create
    - update content in file /etc/ssh/sshd_config.d/01-fleet-baseline.conf from e7be8a to 18e8b3
  * service[ssh] action nothing (skipped due to action :nothing)
  * file[/etc/sudoers.d/ops] action create
    - change mode from '0644' to '0440'
  * service[ssh] action restart (skipped due to only_if)
Infra Phase complete, 2/11 resources updated in 00 seconds
```

The restart is skipped here because the test container doesn't have the SSH server installed.
On a server with `/usr/sbin/sshd`, the changed SSH configuration file triggers a restart at the end of the run.

Correcting drift isn't the same as explaining it.
If the same resource is updated on the same server run after run, something on that server is changing it back---a script, another tool, or a person.
Find it and remove it, rather than letting Chef and that process overwrite each other.

## Fix what fails

When a Chef Courier job reports a failure, check which step failed:

- **Chef Infra Client failed to converge.**
  A recipe resource encountered an error (such as a missing package or syntax error).
  Read the run output from the Courier job run, fix the cookbook, and publish a new revision to `canary`.
- **A compliance control failed but Chef Infra Client converged.**
  The setting the recipe applied isn't what the profile expects, or another process altered it after the recipe ran.
  Read `/var/chef/compliance/report.json` on the server or in Chef Automate.
  If a failure is accepted, such as a legacy server that needs password logins until a dated migration, record it as a waiver with an expiration date, as described in [Waive an exception you've accepted](/solutions/compliance/ssh_baseline/#waive-an-exception-youve-accepted).

To stop the run on any failed control, add `audit-enforcer` as the last reporter in the Policyfile.
Chef Infra Client then raises an error, which stops the Courier job and prevents an invalid release from moving past the canary.

## Where to go next

**Add a published benchmark.**
Add an operating system benchmark profile to `node['audit']['profiles']` so every run also assesses the server against CIS or DISA STIG requirements.
See [Operating Systems](/premium_content/operating_systems/) for coverage.

**Collect compliance results in one place.**
Configure the Chef Automate reporter so results from every server appear in [compliance reporting](/automate/reports/).
With the Automate Connector in Chef 360 Platform, DSM forwards Chef Infra Client run reports directly to Chef Automate.

**Prepare for an assessment.**
See [Prepare for a compliance assessment](/solutions/compliance/#prepare-for-a-compliance-assessment) for filtering, exporting, and accounting for every failing control.

## Related

- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
- [The Chef way of virtual machine compliance](/solutions/compliance/vm_compliance/)
- [The Chef way of configuring web servers and middleware](/solutions/compliance/web_servers_middleware/)
- [Manage nodes and configuration data in DSM](/360/latest/dsm/)
- [Policyfile](/client/latest/policy/policyfile/)
- [Compliance Phase](/client/latest/features/chef_compliance_phase/)
- [Chef 360 Platform node enrollment](/360/latest/use/operators/node_enrollment/)
- [Courier job template reference](/360/latest/use/operators/job_execution/job_template/)
- [Supported versions](/versions/)
