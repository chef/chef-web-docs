+++
title = "The Chef way of small fleet configuration management"
description = "Keep a small Linux fleet consistent with one tested Chef Infra policy: run Chef Infra Client in local mode, distribute the same policy archive to each server, and schedule recurring convergence."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/small_fleet_config"
  parent = "overview/solutions/infra_management"
  title = "Small fleet configuration management"
  weight = 5
+++

Managing a few Linux servers by hand makes it easy for packages, files, and services to drift apart.
With Chef Infra, you define a baseline once, test it, and apply the same versioned policy to each server.

This guide uses Chef Infra Client in local mode, so each server converges from a policy archive without a central Chef service.
Choose this approach when you can distribute the archive yourself and don't need centralized node inventory or run reporting.
For central policy management and visibility, use [Chef 360 Platform Declarative State Management (DSM)](/360/latest/understand/dsm/).

This example targets Chef Infra Client 19 on a supported Linux distribution that uses systemd.
It doesn't set a maximum fleet size; choose a central service when distributing policies and tracking runs by hand no longer fits your needs.

## Choose how to manage the fleet

Choose the management approach based on whether you need centralized policy distribution and reporting:

| Approach | Use it when | Trade-off |
| --- | --- | --- |
| Chef Infra Client in local mode | You can distribute a tested policy archive to each Linux server and don't need centralized run reporting. This guide uses this approach. | You manage policy distribution and collect run results from each server. |
| Chef 360 Platform DSM | You want a central place to manage node enrollment, policies, and run visibility. | Your organization needs access to Chef 360 Platform. |
| Agentless Mode | You want to configure Linux nodes over SSH without installing Chef Infra Client. | This guide doesn't cover recurring local-mode runs or Windows nodes. See [Agentless Mode](/client/latest/features/agentless/). |
| Chef Infra Server | You already have a legacy deployment that you need to maintain. | Chef Infra Server is deprecated and reaches end of life on November 30, 2026. Choose Chef 360 Platform for new central deployments. |

## What you'll build

You'll create a `small_fleet_base` cookbook that manages a marker file and schedules Chef Infra Client to reapply the policy every 30 minutes.
You'll export the locked policy, copy the same archive to a test server, verify the first run, and then repeat the rollout for the rest of the fleet.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/) 26 or later to create and export the cookbook policy.
- A [Chef license key](/licensing/license_key/) to install the commercial Chef Infra Client package.
- Chef Infra Client 19 installed on each target server.
- A Linux distribution and version listed in [Chef Infra Client supported platforms](/client/latest/overview/platforms/).
- A test server that uses systemd, plus an SSH account with `sudo` access.
- A way to copy the policy archive to each server, such as `scp` or your existing deployment pipeline.

The commands use these placeholders:

- `<SSH_USER>`: An SSH user with `sudo` access on the server.
- `<HOST>`: The server's IP address or fully qualified domain name.

## Create the cookbook

Start with a small baseline that writes a file and installs a timer for recurring convergence:

1. Generate a cookbook:

   ```shell
   chef generate cookbook small_fleet_base
   cd small_fleet_base
   ```

1. Replace `recipes/default.rb` with the following recipe:

   ```ruby
   directory '/etc/chef-small-fleet' do
     owner 'root'
     group 'root'
     mode '0755'
   end

   file '/etc/chef-small-fleet/managed-by-chef' do
     content "Managed by Chef Infra.\n"
     owner 'root'
     group 'root'
     mode '0644'
   end

   systemd_unit 'chef-local-converge.service' do
     content <<~UNIT
       [Unit]
       Description=Converge the local Chef Infra policy

       [Service]
       Type=oneshot
       WorkingDirectory=/var/chef/policy/current
       ExecStart=/opt/chef/bin/chef-client --local-mode --chef-license accept
     UNIT
     action :create
   end

   systemd_unit 'chef-local-converge.timer' do
     content <<~UNIT
       [Unit]
       Description=Run the local Chef Infra policy every 30 minutes

       [Timer]
       OnBootSec=15min
       OnUnitActiveSec=30min
       RandomizedDelaySec=5min
       Persistent=true

       [Install]
       WantedBy=timers.target
     UNIT
     action [:create, :enable, :start]
   end
   ```

   The timer reruns the policy from `/var/chef/policy/current`.
   Chef Infra Client corrects changes to the settings managed by the cookbook; it doesn't manage settings you haven't described.

## Export the policy

Lock the cookbook and package the policy so every server receives the same version:

1. Create the lock file and export the policy:

   ```shell
   chef install
   chef export Policyfile.rb ./export --force
   tar -czf small_fleet_base.tgz -C export .
   ```

1. Keep `small_fleet_base.tgz` with the matching cookbook revision.
   Promote the same archive through test and production instead of rebuilding it separately for each server.

## Apply the policy to a test server

Install the exported policy in its dedicated directory, then run Chef Infra Client in local mode:

1. Copy the archive to the test server:

   ```shell
   scp small_fleet_base.tgz <SSH_USER>@<HOST>:/tmp/
   ```

1. Extract the archive and run the first convergence:

   ```shell
   ssh <SSH_USER>@<HOST> \
     'sudo install -d -m 0755 /var/chef/policy/current &&
      sudo tar -xzf /tmp/small_fleet_base.tgz -C /var/chef/policy/current &&
      sudo /opt/chef/bin/chef-client --local-mode --chef-license accept'
   ```

   The first run applies the recipe and enables the timer.

## Verify the result

Confirm that the policy created the managed file and scheduled future runs:

```shell
sudo test -f /etc/chef-small-fleet/managed-by-chef
sudo systemctl list-timers chef-local-converge.timer
sudo systemctl start chef-local-converge.service
sudo journalctl -u chef-local-converge.service -n 25 --no-pager
```

The file check exits successfully when the marker exists.
The timer appears in the systemd timer list, and the journal shows the Chef Infra Client run summary.

## Roll out the policy to the fleet

After the test server passes, use the same archive for each remaining server.
Roll out one server at a time so you can check each run before continuing:

1. Copy `small_fleet_base.tgz` to the next server and extract it to `/var/chef/policy/current`, as in the test-server steps.
2. Run Chef Infra Client in local mode and confirm the run summary.
3. Continue to the next server only after the current server converges successfully.

To update the fleet, export a new locked policy and repeat the rollout.
Don't replace the policy files while the scheduled service is running.
Keep the previous archive so you can restore it if a rollout causes an unexpected change.

## Need access to this capability?

You need a Chef license key to install the commercial Chef Infra Client package.
See [Chef license keys](/licensing/license_key/) for license information.

If you need centralized node management, ask your Chef account representative about access to [Chef 360 Platform](/360/latest/).

## Common problems

| Problem | Likely cause | Recommended fix |
| --- | --- | --- |
| The policy run can't find a cookbook. | The archive wasn't extracted into `/var/chef/policy/current`, or the command ran from another directory. | Extract the exported policy into the configured directory and run Chef Infra Client from that directory. |
| The timer is missing. | The initial Chef Infra Client run didn't complete, or the target host doesn't use systemd. | Check the first run's output and confirm the host meets the systemd prerequisite. |
| A manual change remains on the server. | The changed setting isn't described by the cookbook, or the timer hasn't run yet. | Add the setting to the cookbook, export and distribute a new policy, then run convergence. |
| You can't see run results centrally. | Local mode runs the policy on the server without a central reporting service. | Use Chef 360 Platform DSM when you need centralized node and run visibility. |

## Related resources

- [Linux server configuration management](/solutions/infra_management/linux_server/) for a cross-distribution baseline and Test Kitchen workflow.
- [Hybrid fleet configuration management](/solutions/infra_management/hybrid_fleet_config/) for a fleet that spans operating systems and sites.
- [Chef Infra Client installation](/client/latest/install/installer/) for installation options.
- [Policyfiles](/client/latest/policy/policyfile/) for locking and distributing cookbook versions.
- [Chef Infra Client resources](/client/latest/resources/) for resources you can use in cookbooks.
