+++
title = "The Chef way of Kubernetes config management"
description = "Configure the Linux nodes that run Kubernetes with Chef: write the node settings and the kubelet configuration as code, converge nodes on a schedule, correct drift, and roll changes out one node pool at a time."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/kubernetes_config"
  parent = "overview/solutions/infra_management"
  title = "Kubernetes config management"
  weight = 10
+++

<!-- cspell:ignore dropin uncordon daemonsets -->

A Kubernetes cluster is only as consistent as the machines under it.
Every node needs the right kernel settings, the right container runtime settings, and the right kubelet configuration.
When those are set by hand, two nodes in the same pool end up different.
A setting is changed during an incident and never changed back.
A node that was built last year doesn't match the one you built last week, and the difference only shows up as a pod that behaves oddly on one node.

You need one reviewed definition of what a node should look like, and a way to keep every node matching it.
Chef does this by letting you describe the node's configuration as code, and by running an agent, Chef Infra Client, on each node that makes the node match that code, again and again.
The agent changes only what has drifted, so a hand-made change doesn't survive for long, and every change is reported.

This page covers the node layer: the Linux hosts that run the kubelet and the container runtime.
It's honest about the rest: Chef doesn't manage Kubernetes objects such as Deployments or Helm charts.
See [Where Chef fits](#where-chef-fits).

## Who this page is for

**If you're accountable for the outcome**, such as a platform or infrastructure owner, read this section and [Where Chef fits](#where-chef-fits).
You'll learn what Chef gives you for the machines under a cluster, what it doesn't, and where the risks are when you change a running cluster.

**If you run the cluster nodes**, work through the rest of the page.
It builds a small cookbook that sets a kernel parameter and writes a kubelet configuration file, converges a node, shows a manual change being corrected, sets different values for different node pools, and tests the result.
If you haven't used Chef before, you don't need to read anything else first.

{{< note >}}

In this page, a node is a machine that runs Kubernetes workloads, and it's also a node that Chef Infra Client manages.
They're the same machine, so the page uses the one word.

{{< /note >}}

### What you get

- **Consistency across a pool.** Every node in a pool is built from the same code, so two nodes can't quietly diverge.
- **Drift correction.** A change made by hand is reverted at the next run, and the run reports what it changed.
- **Different values where you need them.** Node pools can differ, such as a higher pod limit for large machines, without copying the cookbook.
- **Controlled change.** A change is tested on a workstation, promoted through groups of nodes, and rolled out a group at a time.
- **A record.** Each run reports which resources it changed, so you can see when a node's configuration changed.

### What you don't get

Chef Infra Client configures the machine.
It doesn't create the cluster, join nodes to it, or manage Kubernetes API objects.
It doesn't cordon, drain, or reschedule anything, so you plan those steps yourself.
A node is in a known state only for the settings you wrote code for, and only as of its last successful run.

## Where Chef fits

Kubernetes configuration spans several layers.
Chef covers the first one, and the rest of the Chef platform helps you check the cluster.

| Layer | What it means | Chef piece | On this page |
| --- | --- | --- | --- |
| Cluster nodes | The Linux hosts: kernel parameters, packages, and the files the kubelet and the container runtime read | [Chef Infra Client](/client/latest/) resources such as `sysctl`, `template`, and `service` | Yes |
| Cluster and workload objects | Deployments, ConfigMaps, network policies, Helm charts, and cluster add-ons | Not a Chef Infra Client feature. Use Kubernetes tooling | No |
| Cluster assessment | Checking that a running cluster meets your requirements | [Chef InSpec](/inspec/latest/) and the [Kubernetes resource pack](/inspec/resource_packs/k8s/) | See [Containers / Kubernetes compliance](/solutions/compliance/containers_kubernetes/) |
| Chef 360 Platform | The Chef platform, which runs on Kubernetes | [Chef 360 Platform](/360/latest/) | See [Chef 360 runs on Kubernetes](#chef-360-runs-on-kubernetes) |

Chef doesn't ship resources for kubectl, kubeadm, Helm, or Kubernetes API objects, so this page doesn't use any.
For the cluster and workload layers, keep using the Kubernetes tools you already use, and use Chef to keep the nodes under them consistent.

The pieces that make up the Chef way for the node layer:

| Idea | What it means | Chef piece |
| --- | --- | --- |
| Describe the state you want | You write what a node should look like, not the steps to get there. A `sysctl` resource says a kernel parameter should have a value, and Chef works out how. | Chef Infra cookbooks, recipes, and resources |
| Converge, don't script | An agent on each node compares the node with the code and changes only what doesn't match. Running it twice changes nothing the second time. | Chef Infra Client |
| Keep the code in one place | Nodes ask a central service for the cookbooks and policy that apply to them. | Chef Declarative State Management (DSM) in [Chef 360 Platform](/360/latest/), the direct replacement for Chef Infra Server |
| Test before you ship, and roll out in groups | You test on a workstation first, then promote the same code through groups of nodes. | [Chef Workstation](/workstation/latest/) and [Policyfiles](/policyfile/) |

## What you'll build

A Chef Infra cookbook, `k8s_node_baseline`, that does two things on a Kubernetes node:

- Turns on IPv4 forwarding with the `sysctl` resource. The Kubernetes documentation notes that the Linux kernel doesn't forward IPv4 packets between interfaces by default, and that some cluster networking implementations expect the administrator to turn it on.
- Writes a kubelet configuration drop-in file that sets the cgroup driver, the pod limit, and the eviction thresholds.

It's a small stand-in for real work: the same pattern applies to any other kernel parameter, kernel module, or configuration file that your container runtime or network plugin documents.
You'll run it on a Linux test machine, change the file by hand, and watch Chef correct it.
Then the page shows how the same cookbook serves different node pools and how it reaches many nodes.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/install/) on the machine where you write and test code.
  It includes the `chef` and `chef-client` commands and the testing tools.
- A Linux test machine, such as a disposable virtual machine or container, where you can run commands as `root`.
  The `sysctl` resource is for Linux, and the example writes files under `/etc`, so don't run it on a node that's part of a real cluster.
- A Progress Chef license, for bootstrapping nodes and for commercial downloads.
  Chef Infra Client might ask you to accept the license terms the first time you run it.

The output on this page comes from Chef Infra Client 18.10 running on an Ubuntu 24.04 container.
Output from a later release might differ slightly.

## Write the cookbook

To create a cookbook that describes your node configuration, follow these steps:

1. Create a repository and a cookbook inside it:

   ```shell
   chef generate repo chef-repo
   cd chef-repo
   chef generate cookbook cookbooks/k8s_node_baseline
   ```

   The cookbook contains a `recipes/default.rb` for your recipe, a `metadata.rb`, a `Policyfile.rb`, a `kitchen.yml` for testing, and a `test` directory.
   See [cookbooks](/client/latest/cookbooks/) for what each part is for.

1. Create `cookbooks/k8s_node_baseline/attributes/default.rb`:

   ```ruby
   default['k8s_node_baseline']['kubelet_dropin_dir'] = '/etc/kubernetes/kubelet.conf.d'
   default['k8s_node_baseline']['cgroup_driver'] = 'systemd'
   default['k8s_node_baseline']['max_pods'] = 110

   # Set every threshold. Setting only one resets the others to zero.
   default['k8s_node_baseline']['eviction_hard'] = {
     'memory.available' => '100Mi',
     'nodefs.available' => '10%',
     'nodefs.inodesFree' => '5%',
     'imagefs.available' => '15%',
     'imagefs.inodesFree' => '5%',
   }

   # Restart the kubelet when its configuration changes.
   default['k8s_node_baseline']['restart_kubelet'] = false
   ```

   An attribute holds a value that changes between nodes or node pools, so the recipe doesn't have to.
   The comment about thresholds comes from the Kubernetes documentation: if you change one `evictionHard` value and don't set the others, the others don't keep their defaults.
   The `restart_kubelet` attribute is off by default, because restarting the kubelet on a running node needs planning.
   See [Roll changes out safely](#roll-changes-out-safely).

1. Create `cookbooks/k8s_node_baseline/templates/kubelet-dropin.conf.erb`:

   ```erb
   # Managed by Chef. Local edits are replaced on the next Chef Infra Client run.
   apiVersion: kubelet.config.k8s.io/v1beta1
   kind: KubeletConfiguration
   cgroupDriver: <%= @cgroup_driver %>
   maxPods: <%= @max_pods %>
   evictionHard:
   <% @eviction_hard.each do |name, value| -%>
     <%= name %>: "<%= value %>"
   <% end -%>
   ```

   This is a kubelet configuration drop-in file.
   The Kubernetes documentation describes a drop-in directory that the kubelet reads in alphanumeric order, and says a drop-in file's name must end in `.conf` and that it must include `apiVersion` and `kind`.
   Using a drop-in means Chef owns one small file and doesn't overwrite the kubelet's main configuration file.
   The kubelet reads the directory only if you start it with `--config-dir`, so check how your nodes start the kubelet.
   Kubernetes lets you choose the cgroup driver, and says that the kubelet and the container runtime must use the same one.
   See [Where the settings come from](#where-the-settings-come-from).

1. Replace `cookbooks/k8s_node_baseline/recipes/default.rb` with:

   ```ruby
   settings = node['k8s_node_baseline']

   sysctl 'net.ipv4.ip_forward' do
     value 1
   end

   directory settings['kubelet_dropin_dir'] do
     recursive true
     mode '0755'
   end

   template "#{settings['kubelet_dropin_dir']}/99-chef.conf" do
     source 'kubelet-dropin.conf.erb'
     mode '0644'
     variables(
       cgroup_driver: settings['cgroup_driver'],
       max_pods: settings['max_pods'],
       eviction_hard: settings['eviction_hard']
     )
     notifies :restart, 'service[kubelet]', :delayed if settings['restart_kubelet']
   end

   service 'kubelet' do
     action :nothing
   end
   ```

   Each block is a [resource](/client/latest/resources/bundled/).
   [`sysctl`](/client/latest/resources/bundled/sysctl/) sets a kernel parameter and writes it to a file in the `sysctl.d` directory.
   [`directory`](/client/latest/resources/bundled/directory/) and [`template`](/client/latest/resources/bundled/template/) state what should exist and what it should contain.
   The [`service`](/client/latest/resources/bundled/service/) resource does nothing on its own (`action :nothing`).
   It exists so that the template can ask for a restart when you've turned `restart_kubelet` on.
   The resources state what should be true and don't say how to do it, because Chef Infra Client works that out for the platform it's running on.

### Where the settings come from

The values in the cookbook come from the Kubernetes documentation, not from Chef, so check them against the Kubernetes version you run:

- [Container runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/) covers IPv4 forwarding, the `cgroupDriver` option, and the `SystemdCgroup` setting for containerd.
- [Set kubelet parameters with a configuration file](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/) covers the configuration file, the `--config-dir` drop-in directory, and the `evictionHard` behavior.

The Kubernetes documentation says the configuration file is the recommended way to set kubelet parameters, because it simplifies node deployment and configuration management.
That's the property Chef builds on: the settings are in a file, so Chef can own the file.

Your container runtime has its own configuration file, such as containerd's `/etc/containerd/config.toml`.
If you set the kubelet's cgroup driver, set the runtime's to match.
You can manage that file with the `template` or `file` resource in the same way.
This page doesn't show it, because the file's contents depend on the runtime and its version.

## Converge a node and correct drift

To see Chef Infra Client apply the cookbook and then undo a manual change, follow these steps on your Linux test machine:

1. Run the recipe in local mode, which runs a lightweight Chef Infra Server on the machine for the length of the run:

   ```shell
   chef-client -z -o 'recipe[k8s_node_baseline]'
   ```

   Accept the license prompt if you see one.
   On a new node, each resource is created:

   ```text
   Converging 4 resources
   Recipe: k8s_node_baseline::default
     * sysctl[net.ipv4.ip_forward] action apply
       * file[/etc/sysctl.d/99-chef-net.ipv4.ip_forward.conf] action create
         - create new file /etc/sysctl.d/99-chef-net.ipv4.ip_forward.conf
       * execute[Load sysctl values] action run
         - execute sysctl -p
     * directory[/etc/kubernetes/kubelet.conf.d] action create
       - create new directory /etc/kubernetes/kubelet.conf.d
       - change mode from '' to '0755'
     * template[/etc/kubernetes/kubelet.conf.d/99-chef.conf] action create
       - create new file /etc/kubernetes/kubelet.conf.d/99-chef.conf
       - update content in file /etc/kubernetes/kubelet.conf.d/99-chef.conf from none to fe452c
       - change mode from '' to '0644'
     * service[kubelet] action nothing (skipped due to action :nothing)
   Infra Phase complete, 5/7 resources updated in 00 seconds
   ```

   The file now looks like this:

   ```yaml
   # Managed by Chef. Local edits are replaced on the next Chef Infra Client run.
   apiVersion: kubelet.config.k8s.io/v1beta1
   kind: KubeletConfiguration
   cgroupDriver: systemd
   maxPods: 110
   evictionHard:
     memory.available: "100Mi"
     nodefs.available: "10%"
     nodefs.inodesFree: "5%"
     imagefs.available: "15%"
     imagefs.inodesFree: "5%"
   ```

1. Run it again.
   Nothing has drifted, so nothing changes, and the `directory` and `template` resources report `(up to date)`.
   This is idempotence, and it's why you can run Chef on a schedule without worrying about what it will do to a node that's already correct.

1. Make a change by hand, as an administrator might during an incident:

   ```shell
   sed -i 's/maxPods: 110/maxPods: 500/' /etc/kubernetes/kubelet.conf.d/99-chef.conf
   ```

1. Run the recipe again:

   ```shell
   chef-client -z -o 'recipe[k8s_node_baseline]'
   ```

   Chef Infra Client finds the difference, reverts it, and shows exactly what it changed:

   ```text
   * template[/etc/kubernetes/kubelet.conf.d/99-chef.conf] action create
     - update content in file /etc/kubernetes/kubelet.conf.d/99-chef.conf from e7d5ee to fe452c
       @@ -2,7 +2,7 @@
        apiVersion: kubelet.config.k8s.io/v1beta1
        kind: KubeletConfiguration
        cgroupDriver: systemd
       -maxPods: 500
       +maxPods: 110
        evictionHard:
          memory.available: "100Mi"
   ```

   The directory and the kernel parameter were already correct, so only the template changed.

The output here is from a test run, trimmed, with paths and timings shortened.
Your checksums and timings differ.

{{< warning >}}

Chef changes the file on disk.
It doesn't make the kubelet reload the file.
On a real node, a corrected file takes effect when the kubelet next starts, so decide how that restart happens before you rely on drift correction.
See [Roll changes out safely](#roll-changes-out-safely).

{{< /warning >}}

For the full sequence of steps in a run, see [the Chef Infra Client run](/client/latest/#the-chef-infra-client-run).

## Use different settings for different node pools

Clusters usually have more than one kind of node: small and large machines, or nodes for different workloads.
Keep the logic in the cookbook the same, and change only the attributes.

For example, to give a pool of large nodes a higher pod limit, set the attribute for that pool.
This first-boot JSON file sets it for one run:

```json
{
  "k8s_node_baseline": {
    "max_pods": 250
  }
}
```

```shell
chef-client -z -o 'recipe[k8s_node_baseline]' -j pool.json
```

The template changes from `maxPods: 110` to `maxPods: 250`, and nothing else changes:

```text
-maxPods: 110
+maxPods: 250
```

For a fleet, set the attribute in a Policyfile for the pool instead of a JSON file.
A Policyfile locks a run list and cookbook versions into one versioned revision, and it can carry attributes:

```ruby
name 'k8s-large-nodes'
default_source :supermarket
run_list 'k8s_node_baseline::default'
cookbook 'k8s_node_baseline', path: 'cookbooks/k8s_node_baseline'
default['k8s_node_baseline']['max_pods'] = 250
```

Running `chef install` in the repository evaluates this file and writes `Policyfile.lock.json`, which records the run list, the cookbook, and the attribute.
See [Policyfiles](/policyfile/) for the full syntax.

## Test before you ship

A cookbook that changes nodes needs testing before it runs on them.
Chef Workstation includes the tools for that, so a change can be checked on your workstation or in a disposable machine first.

| Tool | What it checks |
| --- | --- |
| Cookstyle | Style and common mistakes in your Chef Infra code |
| [ChefSpec](/workstation/latest/tools/chefspec/) | What a recipe would do, without running it on a system |
| [Test Kitchen](/workstation/latest/tools/kitchen/) | Whether the cookbook converges on a real, throwaway machine, and whether the result passes your tests |
| [Chef InSpec](/inspec/latest/) | Whether the finished system meets requirements |

Here's a ChefSpec test for this cookbook.
Create `cookbooks/k8s_node_baseline/spec/unit/recipes/default_spec.rb`:

```ruby
require 'chefspec'

describe 'k8s_node_baseline::default' do
  platform 'ubuntu'

  it 'enables IPv4 forwarding' do
    expect(chef_run).to apply_sysctl('net.ipv4.ip_forward').with(value: '1')
  end

  it 'writes the kubelet drop-in with the systemd cgroup driver' do
    expect(chef_run).to render_file('/etc/kubernetes/kubelet.conf.d/99-chef.conf')
      .with_content(/cgroupDriver: systemd/)
  end

  it 'does not restart the kubelet by default' do
    template = chef_run.template('/etc/kubernetes/kubelet.conf.d/99-chef.conf')
    expect(template).not_to notify('service[kubelet]').to(:restart)
  end

  context 'when restart_kubelet is true' do
    override_attributes['k8s_node_baseline'] = { 'restart_kubelet' => true }

    it 'restarts the kubelet after the drop-in changes' do
      template = chef_run.template('/etc/kubernetes/kubelet.conf.d/99-chef.conf')
      expect(template).to notify('service[kubelet]').to(:restart).delayed
    end
  end
end
```

Run it from the cookbook directory:

```shell
chef exec rspec spec
```

```text
....

4 examples, 0 failures
```

ChefSpec runs the recipe in memory, so you can run this test on a laptop, even though the `sysctl` resource is for Linux.
It checks that the restart notification is declared, but it doesn't restart a kubelet.
Use Test Kitchen to converge the cookbook on a Linux machine before you roll it out.
The `kitchen.yml` that `chef generate cookbook` creates is the starting point.

## Roll changes out safely

Changing node configuration on a running cluster carries more risk than changing a stateless server, because the node is running other people's workloads.
Chef gives you ways to control which nodes change and when.
The decisions about the workloads on those nodes are yours.

**Promote through policy groups.**
A Policyfile locks a run list and cookbook versions together into one versioned revision.
A policy group binds a set of nodes to a specific revision.
Use one policy group for each node pool, or a small group of nodes to try a change first, and promote the same revision to the next group when it's healthy.
Nodes in the later groups don't see the change until you promote it.
Chef Workstation's `chef push` uploads a revision to a policy group:

```shell
chef install
chef push canary Policyfile.lock.json
```

See [Policyfiles](/policyfile/) and [policy groups in DSM](/360/latest/use/operators/dsm_operations/#policy-groups).

**Decide how the kubelet picks up a change.**
The kubelet loads its configuration when it starts.
You have two options, and the right one depends on the change:

- **Leave `restart_kubelet` off** and restart the kubelet as a separate, planned step, such as in a maintenance window.
- **Turn `restart_kubelet` on** for a node pool where a kubelet restart is acceptable.
  The `template` then asks the `service` resource to restart the kubelet at the end of the run, but only when the file changed.

**Plan for workloads on the node.**
The Kubernetes documentation describes how to drain a node before maintenance: `kubectl drain --ignore-daemonsets <node name>` evicts the pods, and `kubectl uncordon <node name>` lets the node take pods again.
It also describes using PodDisruptionBudgets for applications that need to stay available.
See [safely drain a node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/).
Chef doesn't run these commands for you, so do them in your own runbook or tooling around the change.

**Don't edit a node's cgroup driver in place.**
The Kubernetes documentation calls changing the cgroup driver of a node that has already joined a cluster a sensitive operation, because it can cause errors when the kubelet re-creates the sandbox for pods that exist.
It recommends replacing the node with one that has the updated configuration when you have automation that makes that practical.
Treat a cgroup driver change as a node replacement, and use this cookbook to configure the new node.

## Run Chef on a schedule

A node stays in a known state only if Chef runs regularly.
The `chef_client_systemd_timer` resource sets up Chef Infra Client to run as a systemd timer, which is how you manage the schedule with Chef itself:

```ruby
chef_client_systemd_timer 'Run Chef Infra Client every hour' do
  interval '1hr'
end
```

By default, the timer runs every 30 minutes with a 5-minute random delay (`splay`), so Chef Infra Client runs on your nodes don't all start at the same time.
See [`chef_client_systemd_timer`](/client/latest/resources/bundled/chef_client_systemd_timer/) for every property, and [`chef_client_cron`](/client/latest/resources/bundled/chef_client_cron/) for the cron equivalent.

This snippet is from the resource reference and isn't part of the tested example.

Pick an interval that matches how fast you need drift corrected.
If `restart_kubelet` is on for a pool, remember that a configuration change can restart the kubelet at any run, so check that the schedule suits that pool.

## Bring nodes under management

A node is any machine Chef manages.
Nodes that run Kubernetes enroll the same way as any other Linux node, and they get their cookbooks and policy from the same central service.

| Method | How it works |
| --- | --- |
| `knife bootstrap` | Installs Chef Infra Client on a node over SSH and registers it. Add `--policy-name` and `--policy-group` to apply a policy on the first run. See [bootstrap a node](/client/latest/install/bootstrap/). |
| Chef 360 enrollment | Enroll nodes into Node Management with a self-enrollment key or script, a cookbook, or a CSV file. See [node enrollment](/360/latest/use/operators/node_enrollment/). |
| First-boot scripts | Install Chef Infra Client with user data or another post-deployment script when a machine is created. See [unattended bootstrapping](/client/latest/install/bootstrap/#unattended-bootstrapping). |

The central service is Chef Declarative State Management (DSM) in Chef 360 Platform, which is the direct replacement for Chef Infra Server.
All of the capabilities of Chef Infra Server are available in DSM.
If you run Chef Infra Server today, see [Migrate from Chef Infra Server](/360/latest/migrate/on_prem_to_self_managed/).

## See the state of your nodes

After each run, Chef Infra Client reports a summary of what it did.
Chef Automate collects those reports and shows the status of your nodes and their Chef Infra Client runs.
See [client runs](/automate/client_runs/).
In Chef 360 Platform, the Nodes page shows each node's enrollment level and health, and Chef Courier keeps the history of every job run.

Configuration and compliance answer different questions.
Chef Infra Client makes the node match your code.
Chef InSpec checks that the result, and the cluster above it, meets a requirement.
The [Containers / Kubernetes compliance](/solutions/compliance/containers_kubernetes/) page lists the Kubernetes benchmarks that Chef Compliance covers.

## Chef 360 runs on Kubernetes

Chef 360 Platform Server runs as a set of containers on Kubernetes.
It runs in one of three ways: Progress hosts it (SaaS), you run it on a cluster that Chef provisions (embedded cluster), or you run it on a cluster you manage (bring your own Kubernetes).
See [deployment models](/360/latest/chef_360_product/deployment_models/).

If you bring your own Kubernetes, the cluster and the machines under it are yours to manage, and this page applies to them.
With the embedded cluster, Chef manages the Kubernetes platform for you, so this page is for clusters that you manage.
See the [BYOK requirements](/360/latest/get_started/on_prem/byok/kubernetes_requirements/).

## What the documentation doesn't say

This page sticks to what the Chef documentation states and what the example proved.
A few things that people often assume aren't covered, so confirm them before you rely on them:

- **Kubernetes resources.** Chef Infra Client has no resources for Kubernetes API objects, kubeadm, kubectl, or Helm.
- **Cluster bootstrapping.** The Chef documentation doesn't describe creating or joining a cluster. Use your cluster tooling for that.
- **Safe node maintenance.** The Chef documentation doesn't describe cordoning or draining a node. The Kubernetes documentation does, and the steps are yours to run.
- **Community cookbooks.** Supermarket has cookbooks with Kubernetes in the name, but the `kubernetes` cookbook is marked deprecated. Review any community cookbook before you use it.
- **Other Kubernetes versions.** The settings in the example come from the Kubernetes documentation at the time of writing. Check them for the version you run.
- **Chef Habitat.** The Chef Habitat release notes list the Kubernetes exporter as removed, so don't plan around it.

## Where to start

If you're new to Chef, start with the example on this page, and then read [the Chef Infra Client run](/client/latest/#the-chef-infra-client-run).
Before you scale up:

- Pick the settings that must be identical on every node, and put them in a cookbook.
- Keep values that differ between node pools in attributes, not in recipes, and test every branch.
- Give each node pool its own policy group, and try every change on a small group first.
- Decide how the kubelet restarts after a change, and write down how you drain nodes.
- Run Chef on a schedule, and use Chef Automate to watch the run reports.
- Check the cluster itself with Chef InSpec.

## Related documentation

- [Chef Infra Client](/client/latest/)
- [Chef Workstation](/workstation/latest/)
- [Chef 360 Platform](/360/latest/)
- [Declarative State Management](/360/latest/understand/dsm/)
- [Policyfiles](/policyfile/)
- [Containers / Kubernetes compliance](/solutions/compliance/containers_kubernetes/)
- [Kubernetes documentation: Container runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
- [Kubernetes documentation: Set kubelet parameters with a configuration file](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/)
