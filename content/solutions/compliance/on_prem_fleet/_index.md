+++
title = "The Chef way of managing an on-prem fleet"
description = "Configure, update, and keep servers in your own data centers in a known state with Chef: write the desired state as code, converge nodes on a schedule, correct drift, and roll changes out in controlled waves."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/on_prem_fleet"
  parent = "overview/solutions/compliance"
  title = "The Chef way of managing an on-prem fleet"
  weight = 17
+++


Servers in your own data centers drift as admins change them by hand.
A package gets upgraded on one host and not another.
A setting is changed during an incident and never changed back.
A server that was built from a runbook two years ago no longer matches the one built last week.
Fixing this by logging in to each server doesn't scale, and a runbook only describes what someone meant to do, not what's true now.

You need one consistent way to configure, update, and keep servers in a known state.
Chef does this by letting you describe the state you want as code, and by running an agent on every server that makes the server match that description, again and again.
The agent changes only what has drifted, so running it on a schedule is safe and a hand-made change doesn't survive for long.

## Who should read this

**If you're accountable for the outcome**, such as an infrastructure, operations, or platform owner, read this section and [How Chef manages a fleet](#how-chef-manages-a-fleet).
You'll learn what Chef gives you for an on-premises estate, what it doesn't, and which parts of the platform you run yourself.

**If you run the servers**, work through the rest of the page.
It builds a small cookbook, converges a node, shows a manual change being corrected, and then explains how that scales to a fleet of nodes, how to roll out changes safely, and how to migrate if you run [Chef Infra Server](/server/) today.
If you haven't used Chef before, you don't need to read anything else first.

### What you get

- **Consistency.** Every server of a given type is built from the same code, so two servers can't quietly diverge.
- **Drift correction.** A change made by hand is reverted at the next run, and the run reports what it changed.
- **Controlled change.** A change to the code is tested on a workstation, promoted through groups of nodes, and rolled out in waves.
- **A record.** Each run reports which resources it updated, and Chef Automate collects those reports across nodes.

### What you don't get

Chef converges the resources you describe.
It doesn't discover what's wrong with a server you haven't described, and it doesn't replace your change process, your backups, or your monitoring.
A node is in a known state only for the resources you wrote code for, and only as of its last successful run.

## How Chef manages a fleet

Four ideas make up the Chef way.
Each one maps to a piece of the platform.

| Idea | What it means | Chef piece |
| --- | --- | --- |
| Describe the state you want | You write what a server should look like, not the steps to get there. A `package` resource says a package should be installed, and Chef works out how. | [Chef Infra](/client/latest/) cookbooks, recipes, and resources |
| Converge, don't script | An agent on each node compares the node with the code and changes only what doesn't match. Running it twice changes nothing the second time. | [Chef Infra Client](/client/latest/) |
| Keep the code in one place | Nodes ask a central service for the cookbooks and policy that apply to them. | Chef Declarative State Management (DSM) in [Chef 360 Platform](/360/latest/), or Chef Infra Server |
| Test before you ship, and roll out in waves | You test on your workstation first, then promote the same code through groups of nodes. | [Chef Workstation](/workstation/latest/), policy groups, and [Chef Courier](/360/latest/understand/courier/) jobs |

A node pulls its configuration.
Chef Infra Client contacts the central service on a schedule, downloads the cookbooks that apply, and, only if the node doesn't match what the cookbook says, makes the change.
Most of the work happens on the nodes, not on the central service.

Choose the central service that fits your situation:

| If you | Then |
| --- | --- |
| Run Chef Infra Server today | Plan a move to DSM in Chef 360 Platform. See [Migrate from Chef Infra Server](#migrate-from-chef-infra-server). |
| Are building a new on-premises estate | Use Chef 360 Platform, and decide whether you want Chef to manage its Kubernetes (embedded cluster) or you manage it (bring your own Kubernetes). See [Choose where the platform runs](#choose-where-the-platform-runs). |
| Have servers you can reach over SSH but don't want an agent on | Use Agentless Mode for Linux nodes. See [Nodes without an agent](#nodes-without-an-agent). |

The cookbooks, recipes, and resources in the example are the same whichever central service you use.

## What you'll build

A Chef Infra cookbook that does two things on a node:

- Creates a configuration directory.
- Manages one configuration file, so a hand edit to the file is reverted at the next run.

You'll run it on one node, change the file by hand, and watch Chef correct it.
Then you see how the same cookbook reaches many nodes.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/install/) on the machine where you write and test code.
  It includes the `chef` and `chef-client` commands and the testing tools.
- A test node or a scratch directory.
  The example runs in your workstation's local mode and writes to a temporary directory, so it doesn't change the system.
- A Progress Chef license, for bootstrapping nodes and for commercial downloads.
  Chef Infra Client might ask you to accept the license terms the first time you run it.

{{< note >}}

Chef Infra Client 19 and Chef Workstation 26 are the current releases.
To bootstrap a node with Chef Infra Client 19 or later, you need Chef Workstation 26 or later.
The output shown here comes from Chef Infra Client 18.10, so output from 19 might differ slightly.

{{< /note >}}

## Write the cookbook

To create a cookbook and a recipe that describes the state you want, follow these steps:

1. Create a repository and a cookbook inside it:

   ```shell
   chef generate repo chef-repo
   cd chef-repo
   chef generate cookbook cookbooks/onprem_baseline
   ```

   The cookbook contains a `recipes/default.rb` for your recipe, a `metadata.rb`, a `Policyfile.rb`, a `kitchen.yml` for testing, and a `test` directory.
   See [cookbooks](/client/latest/cookbooks/) for what each part is for.

1. Create `cookbooks/onprem_baseline/attributes/default.rb`:

   ```ruby
   default['onprem_baseline']['config_dir'] = '/etc/onprem-baseline'
   ```

   An attribute holds a value that changes between nodes or environments, so the recipe doesn't have to.

1. Replace `cookbooks/onprem_baseline/recipes/default.rb` with:

   ```ruby
   directory node['onprem_baseline']['config_dir'] do
     mode '0755'
     recursive true
   end

   file "#{node['onprem_baseline']['config_dir']}/ssh-policy.conf" do
     content <<~CONF
       # Managed by Chef. Local edits are replaced on the next Chef Infra Client run.
       PermitRootLogin no
       MaxAuthTries 3
     CONF
     mode '0644'
   end
   ```

   Each block is a [resource](/client/latest/resources/bundled/).
   `directory` and `file` state what should exist and how.
   They don't say how to create it, because Chef Infra Client works that out for the platform it's running on.
   Other resources follow the same pattern, such as [`package`](/client/latest/resources/bundled/package/), [`service`](/client/latest/resources/bundled/service/), [`template`](/client/latest/resources/bundled/template/), and [`user`](/client/latest/resources/bundled/user/).

## Converge a node and correct drift

To see Chef Infra Client apply the cookbook and then undo a manual change, follow these steps:

1. Create `attrs.json` in the repository, so the example writes to a temporary directory instead of `/etc`:

   ```json
   {
     "onprem_baseline": {
       "config_dir": "/tmp/onprem-baseline-demo"
     }
   }
   ```

   On a real node, leave the default and don't use this file.

1. Run the recipe in local mode, which runs a lightweight Chef Infra Server on your workstation for the length of the run:

   ```shell
   chef-client -z -o 'recipe[onprem_baseline]' -j attrs.json
   ```

   Accept the license prompt if you see one.
   On a new node, both resources are created:

   ```text
   Converging 2 resources
   Recipe: onprem_baseline::default
     * directory[/tmp/onprem-baseline-demo] action create
       - create new directory /tmp/onprem-baseline-demo
       - change mode from '' to '0755'
     * file[/tmp/onprem-baseline-demo/ssh-policy.conf] action create
       - create new file /tmp/onprem-baseline-demo/ssh-policy.conf
       - update content in file /tmp/onprem-baseline-demo/ssh-policy.conf from none to 10dbaf
       - change mode from '' to '0644'
   Infra Phase complete, 2/2 resources updated in 06 seconds
   ```

1. Run it again.
   Nothing has drifted, so nothing changes:

   ```text
   * directory[/tmp/onprem-baseline-demo] action create (up to date)
   * file[/tmp/onprem-baseline-demo/ssh-policy.conf] action create (up to date)
   Infra Phase complete, 0/2 resources updated in 03 seconds
   ```

   This is idempotence, and it's why you can run Chef on a schedule without worrying about what it will do to a node that's already correct.

1. Make a change by hand, as an admin might during an incident:

   ```shell
   sed -i.bak 's/PermitRootLogin no/PermitRootLogin yes/' /tmp/onprem-baseline-demo/ssh-policy.conf
   ```

1. Run the recipe again:

   ```shell
   chef-client -z -o 'recipe[onprem_baseline]' -j attrs.json
   ```

   Chef Infra Client finds the difference, reverts it, and shows exactly what it changed:

   ```text
   * directory[/tmp/onprem-baseline-demo] action create (up to date)
   * file[/tmp/onprem-baseline-demo/ssh-policy.conf] action create
     - update content in file /tmp/onprem-baseline-demo/ssh-policy.conf from f8dd13 to 10dbaf
       @@ -1,4 +1,4 @@
        # Managed by Chef. Local edits are replaced on the next Chef Infra Client run.
       -PermitRootLogin yes
       +PermitRootLogin no
        MaxAuthTries 3
   Infra Phase complete, 1/2 resources updated in 03 seconds
   ```

   The directory was already correct, so only one of the two resources changed.
   Run it once more, and it returns to `0/2 resources updated`.

The output here is from a test run, trimmed, with paths shortened.
Your checksums and timings differ.

The same loop, run on a schedule on every node, is how Chef keeps a fleet in a known state.
Reading the run output is how you see what changed on which node.

For the full sequence of steps in a run, from getting configuration data through converging to the Compliance Phase, see [the Chef Infra Client run](/client/latest/#the-chef-infra-client-run).

## Test before you ship

A cookbook that changes servers needs testing before it runs on them.
Chef Workstation includes the tools for that, so a change can be checked on your workstation or in a disposable virtual machine first.

| Tool | What it checks |
| --- | --- |
| Cookstyle | Style and common mistakes in your Chef Infra code |
| ChefSpec | What a recipe would do, without running it on a system |
| Test Kitchen | Whether the cookbook converges on a real, throwaway machine, and whether the result passes your tests |
| [Chef InSpec](/inspec/latest/) | Whether the finished system meets requirements, such as a security baseline |

The `kitchen.yml` that `chef generate cookbook` creates is the starting point for Test Kitchen.
See [Chef Workstation](/workstation/latest/) and [Test Kitchen](/workstation/latest/tools/kitchen/) for how to run them.

## Run Chef on a schedule

A node stays in a known state only if Chef runs regularly.
The `chef_client_systemd_timer` resource sets up Chef Infra Client to run as a systemd timer, which is how you manage the schedule with Chef itself:

```ruby
chef_client_systemd_timer 'Run Chef Infra Client every hour' do
  interval '1hr'
end
```

By default, the timer runs every 30 minutes with a 5-minute random delay (`splay`), so the Chef Infra Client runs on your nodes don't all start at the same time.
The resource runs as `root` by default, and it has related resources for other schedulers, including [`chef_client_cron`](/client/latest/resources/bundled/chef_client_cron/).
See [`chef_client_systemd_timer`](/client/latest/resources/bundled/chef_client_systemd_timer/) for every property.

This snippet is from the resource reference and isn't part of the tested example.

Pick an interval that matches how fast you need drift corrected and how much load your central service handles.
An interval that's too short wastes capacity, and one that's too long leaves a hand-made change in place longer.

## Choose where the platform runs

Nodes need somewhere to get their cookbooks and policy.
For an on-premises estate, Chef 360 Platform can run in your own infrastructure, and it also includes job orchestration and node management.

| Deployment model | Who runs the platform | Best for |
| --- | --- | --- |
| Embedded cluster | You run Chef 360 Platform Server, and Chef provisions and manages the Kubernetes environment for it | A quicker setup with fewer cluster tasks. The docs recommend it when you want the fastest self-managed path. |
| Bring your own Kubernetes (BYOK) | You run Chef 360 Platform Server on a Kubernetes cluster you manage | Teams that already run Kubernetes, or that need tighter control over networking and security |
| SaaS | Progress hosts and operates the platform | Teams that don't want to run any platform infrastructure. It also manages nodes in your data centers, if they meet the connectivity requirements. |

Chef 360 Platform has four core areas.
Node Management enrolls nodes and tracks their identity, status, and installed skills.
Chef Courier runs ad hoc or scheduled jobs across nodes.
Declarative State Management (DSM) stores the cookbooks, policies, and node metadata that nodes retrieve, and it's the part that replaces Chef Infra Server.
Platform services provide identity, access, and the web interface.

Installing and running Chef 360 Platform requires the right product entitlement.
See [deployment models](/360/latest/chef_360_product/deployment_models/) to compare the options, and check the [system requirements](/360/latest/reference/system_requirements/) before you install.
For the install steps, see [embedded cluster](/360/latest/get_started/on_prem/embedded/connected_installation/) and [bring your own Kubernetes](/360/latest/get_started/on_prem/byok/kubernetes_requirements/).

### DSM compared with Chef Infra Server

Chef 360 Platform replaces Chef Infra Server, and DSM is the part that does the Chef Infra Server job.
It's a central repository for cookbooks, policies, and node metadata that nodes managed by Chef Infra Client retrieve their configuration from.
Here's how they compare:

- **The same workflow.** You connect Chef Workstation and `knife` to DSM with a `chef_server_url`, and Chef Infra Client reads its configuration from DSM. See [connect to DSM](/360/latest/use/operators/dsm_operations/connect_to_dsm/).
- **The same kinds of objects.** DSM manages cookbooks, roles, environments, data bags, clients, nodes, Policyfiles, and policy groups. See [DSM operations](/360/latest/use/operators/dsm_operations/).
- **Organizations and access control.** One DSM can hold many organizations, and access is controlled by groups, users, and per-object permissions. See [DSM role-based access control](/360/latest/use/administrators/organizations/dsm_organizations/).
- **A migration path.** You can import Chef Infra Server data into DSM. See [Migrate from Chef Infra Server](#migrate-from-chef-infra-server).

Keep two cautions in mind.
Unsupported objects can leave an import only partly successful.
Also, DSM users, organizations, and nodes are separate from the Chef 360 Platform users, organizations, and Node Management nodes that have similar names.
Test your own cookbooks and workflows against DSM before you retire Chef Infra Server, and ask your Chef account team about anything you depend on.

## Bring nodes under management

A node is any server Chef manages.
How you enroll it depends on the central service.

**With Chef Infra Server**, `knife bootstrap` installs Chef Infra Client on a node over SSH or WinRM and registers it:

```shell
knife bootstrap <ADDRESS> -U <USERNAME> --sudo --chef-license-key <LICENSE>
```

Replace the placeholders with the node's address, an account that can use sudo, and your Chef license ID.
By default the first run has an empty run list, so add `--run-list`, or a policy with `--policy-name` and `--policy-group`, to apply code on the first run.
Bootstrapping is validatorless by default, which means each node gets its own key instead of sharing one.
For nodes that can't reach the internet, a custom bootstrap template can point at an internal artifact store.
See [bootstrap a node](/client/latest/install/bootstrap/) and [`knife bootstrap`](/workstation/latest/tools/knife/knife_bootstrap/).

**With Chef 360 Platform**, you enroll nodes into Node Management in one of four ways:

| Method | How it works |
| --- | --- |
| Self-enrollment script | You generate a self-enrollment key and run the generated script on the node. The node enrolls itself, so Chef 360 doesn't need credentials for it. |
| Cookbook-based enrollment | You use the same key to generate a Chef Infra cookbook that enrolls nodes through their existing Chef Infra Client runs. |
| Single-node enrollment | Chef 360 connects to one node over SSH or WinRM with the credentials you give it. |
| Bulk enrollment | You upload a CSV file of nodes and credentials, and Chef 360 enrolls each one. |

A node cohort sets the skills and settings that every node in it receives.
It can restrict membership by IP range, CIDR block, or MAC address, and it can require an administrator to approve each node before enrollment completes.
Tags let you roll a change out to development and staging before production.
See [node enrollment](/360/latest/use/operators/node_enrollment/) and [node management](/360/latest/use/operators/node_management/).

### Nodes without an agent

Agentless Mode runs Chef Infra Client against a node over SSH, without installing Chef Infra Client on the node.
That suits remote systems and edge devices, and servers where you can't or don't want an agent.
You describe each target in a `target_credentials` file and run:

```shell
chef-client -t <TARGET_NAME>
```

Every resource in the cookbook must support Agentless Mode, and Agentless Mode supports Linux nodes.
See [Agentless Mode](/client/latest/features/agentless/) for the supported resources and how to schedule runs.

## Roll changes out in controlled waves

Changing one cookbook can change every node that runs it.
Chef gives you two ways to limit the blast radius.

**Promote through policy groups.**
A Policyfile locks a run list and cookbook versions together into one versioned revision.
A policy group, such as `dev`, `stage`, or `prod`, binds a set of nodes to a specific revision.
You test a new revision in `dev`, then promote the same revision to the next group.
Nodes in `prod` don't see the change until you promote it.
See [Policyfiles](/policyfile/) and [policy groups in DSM](/360/latest/use/operators/dsm_operations/#policy-groups).

**Run jobs in batches.**
Chef Courier runs a job, such as applying an update or restarting a service, across selected nodes.
A job defines the target nodes, the steps, a schedule, and execution rules, including how many nodes run at once (`batchSize`), what must succeed before it continues (`successCriteria`), and whether it retries a failed step.
You can validate a job with a dry run before you submit it, and each run's results are recorded and can be reviewed.

```json
"batchSize": { "type": "number", "value": 1 },
"successCriteria": [
  { "numRuns": { "type": "percent", "value": 100 }, "status": "success" }
]
```

This fragment comes from the job template reference.
It sets a batch size of one node and requires 100 percent of runs to succeed.
See [job execution](/360/latest/use/operators/job_execution/) for the full format.

Use both together: promote cookbook changes through policy groups, and use Courier for coordinated, one-time work such as a package update that needs ordering.

## Keep software updated

Updating a package is a resource like any other.
The `package` resource installs a package or pins it to a version, and you promote a version change through your policy groups the same way you promote any other change.

Chef Infra Client itself needs updating too.
Chef Infra Client 19.x is the current long-term support release.
To install a specific version on a new node, use `knife bootstrap` with `--bootstrap-version`.
Plan the move to 19, and check the [supported versions](/versions/) page for the current list.

## See the state of the fleet

After each run, Chef Infra Client reports a summary of what it did.
Chef Automate collects those reports and shows the status of your nodes and their Chef Infra Client runs.
See [client runs](/automate/client_runs/).

The Compliance Phase adds a security check to every run.
When you turn it on, Chef Infra Client runs Chef InSpec profiles after it converges and reports the results with the run:

```ruby
default['audit']['compliance_phase'] = true
```

You also set which profiles to run, with the `node['audit']['profiles']` attribute.

That's a recipe or attribute change, so it rolls out through the same policy groups as any other change.
See [the Compliance Phase](/client/latest/features/chef_compliance_phase/) and [Chef Compliance](/solutions/compliance/) for what to check and how to read the results.
Convergence and compliance answer different questions: convergence makes the node match your code, and compliance checks that the result meets a requirement.

In Chef 360 Platform, the Nodes page shows each node's enrollment level and health, and Courier keeps the history of every job run.

## Migrate from Chef Infra Server

If you run Chef Infra Server, you can import its data into DSM in Chef 360 Platform instead of rebuilding.
The import brings across organizations, users, cookbooks, policies, roles, environments, data bags, and nodes.

The process in outline:

1. Clean up stale data on Chef Infra Server first, such as unused Policyfile revisions and nodes that haven't checked in for 60 days or more.
1. Export the data with the `knife-ec-backup` tool, and compress the backup.
1. Upload the backup with the `chef-import-cli` tool, and monitor the import until it finishes.
1. Verify the organizations, nodes, cookbooks, roles, environments, and data bags in DSM.
1. Redirect nodes by updating DNS, or by setting `chef_server_url` in `/etc/chef/client.rb` on each node, so they check in with Chef 360 Platform at their next run.

Before you start, check these prerequisites: Chef Infra Server 12 or later, Chef 360 Platform 1.6.1 or later, and administrative access to the server you're exporting from.
You can keep a second knife profile for the old server, so you can switch back if the import fails.
See [Migrate from Chef Infra Server](/360/latest/migrate/on_prem_to_self_managed/) for the commands and the troubleshooting steps.
If you use Chef 360 SaaS instead, the process is different, so follow [Migrate to DSM in Chef SaaS](/360/latest/migrate/on_prem_to_saas/).

## Run in restricted networks

On-premises estates often have limited internet access.
Plan for these points:

- Nodes that can't reach the internet need a different source for the Chef Infra Client package.
  Use a custom `knife bootstrap` template that points to your own artifact store.
- For Chef Automate, see [air-gapped installation](/automate/airgapped_installation/).
- For Chef 360 Platform, you can upgrade in an air-gapped environment.
- Check the system requirements for the ports that nodes must open.
  For Chef 360 SaaS, nodes need outbound access on ports 443 and 31050.

## Where to start

If you're new to Chef, start with the cookbook example, and then read [the Chef Infra Client run](/client/latest/#the-chef-infra-client-run).
If you run an estate today, look at [Choose where the platform runs](#choose-where-the-platform-runs) and, if you use Chef Infra Server, [Migrate from Chef Infra Server](#migrate-from-chef-infra-server).
Before you scale up:

- Give every node an owner and an environment, and put nodes into policy groups or cohorts that match.
- Keep values that change between environments in attributes, not in recipes.
- Test every cookbook change in Test Kitchen before it reaches a policy group.
- Decide how fast drift must be corrected, and set the run interval to match.
- Turn on the Compliance Phase for the nodes that have a security baseline to meet.

## Related documentation

- [Chef Infra Client](/client/latest/)
- [Chef Workstation](/workstation/latest/)
- [Chef 360 Platform](/360/latest/)
- [Declarative State Management](/360/latest/understand/dsm/)
- [Connect to DSM](/360/latest/use/operators/dsm_operations/connect_to_dsm/)
- [Supported versions](/versions/)
- [Chef platform overview](/platform_overview/)
- [Chef Compliance overview](/solutions/compliance/)
