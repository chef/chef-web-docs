+++
title = "The Chef way of Kubernetes compliance"
description = "Assess a Kubernetes cluster with Chef InSpec: write controls for namespaces, network policies, and workload settings, run them against a live cluster, and handle findings and exceptions."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/kubernetes"
  parent = "overview/solutions/compliance"
  title = "Kubernetes compliance"
  weight = 10
+++

<!-- cspell:ignore sobject sobjects -->

A Kubernetes cluster changes constantly.
Teams create namespaces, deploy workloads, and adjust network and access rules, often through several pipelines at once.
Checking those settings by hand gives you an answer that's out of date by the next deployment, and it doesn't give an auditor evidence they can compare from one assessment to the next.

[Chef InSpec](/inspec/latest/) treats the cluster the way it treats a server: as a target you write controls against.
The [Kubernetes resource pack](/inspec/resource_packs/k8s/) provides resources for namespaces, pods, containers, network policies, and access roles.
You write controls that state your requirements, run them against the cluster through the Kubernetes API, and keep the results.
The same profile runs again on a schedule, so a requirement that stops being met shows up as a failing control, not as a surprise at the next audit.

## Who this page is for

**If you're accountable for the outcome**, such as a compliance, risk, or platform owner, read this section and [What Chef covers for Kubernetes](#what-chef-covers-for-kubernetes).
You'll learn what [Chef Compliance](/solutions/compliance/) gives you for Kubernetes, what it doesn't, and what evidence you can hand to an auditor.

**If you run the cluster or write the checks**, work through the rest of the page.
It builds and runs a small profile against a live cluster, shows how to read the results, and explains how to record an exception.
If you haven't used Chef InSpec before, you don't need to read anything else first, but [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/) explains the profile, run, and results mechanics in more detail.

### What you get

- **A repeatable check.** Requirements are written as controls in a profile, reviewed like code, and run the same way each time.
- **Results you can act on.** Every control reports pass, fail, or skip, with the object that failed and the reason.
- **Evidence.** Results export as JSON, so you can show what was checked, against what, and when.
- **Recorded exceptions.** A failure you've deliberately accepted becomes a [waiver](/inspec/latest/configure/waivers/) with a justification and an expiration date, instead of an unexplained red result.

### What you don't get

Chef InSpec assesses configuration; it doesn't enforce it.
It doesn't replace admission control, block a deployment, scan container images for vulnerabilities, or monitor a cluster at runtime.
A passing assessment describes the cluster at the moment it ran and says nothing about the time between runs.

## What Chef covers for Kubernetes

Chef's coverage for Kubernetes comes from two sources.
Which one you start with depends on whether you need to meet a published benchmark or write requirements of your own.

| You need to | Use | Status |
| --- | --- | --- |
| Check your own cluster requirements, such as required network policies or workload settings | The [Kubernetes resource pack](/inspec/resource_packs/k8s/) with Chef InSpec | Available. You write the controls, and this page shows how. |
| Correct configuration to the [CIS Kubernetes Benchmark](https://www.cisecurity.org/cis-benchmarks) | Chef remediation content, part of [Chef Premium Content](/premium_content/) | Available for CIS Kubernetes v1.5.0, v1.6.1, and v1.12.0. Remediation only. |
| Run a prebuilt audit of the CIS Kubernetes Benchmark | Chef audit content | Not currently published. See [Containers / Kubernetes](/premium_content/containers_kubernetes/) for current coverage. |

{{< note >}}

A resource pack isn't a benchmark.
It provides the resources you write controls with and doesn't assess anything on its own.
Audit and remediation content are tracked separately, so check the [coverage table](/premium_content/containers_kubernetes/) before you plan around a specific benchmark version.
Remediation content is part of Chef Premium Content, available to enterprise users.

{{< /note >}}

## What you'll build

A Chef InSpec profile with three controls that check:

- The namespaces you expect exist.
- Each application namespace has at least one network policy.
- One container uses a pinned image tag, not `latest`.

These are illustrative organization-specific requirements.
They aren't a published benchmark and not a complete cluster assessment.
Replace the namespace and workload names with your own, and extend the profile using the resources listed in [Extend the profile](#extend-the-profile).

## Before you begin

You need:

- Chef InSpec 5.22.0 or later, which includes the Kubernetes target plugin, and any required license configuration.
  See the [installation steps](/inspec/latest/install/).
- Network access from the machine that runs Chef InSpec to the cluster's API server.
- A `kubectl`-style configuration at `~/.kube/config`, or a path in the `KUBECONFIG` environment variable, for the cluster you want to assess.
- A test cluster or namespace you can read.
  Assess a non-production cluster first so you know what the expected results are.
- A read-only identity for the assessment.
  The profile only reads objects, so grant it `get` and `list` permission on the resources you check and nothing more.
  Use the identity your organization approves for audit access, and don't run assessments with a cluster-admin credential.

To confirm the configuration points at the cluster you intend, run:

```shell
kubectl config current-context
kubectl get namespaces
```

If you assess more than one cluster, check the context before every run.
A control that passes against the wrong cluster is a false result.

{{< warning >}}

If the credential can't read a resource, a check can look like a missing object.
Don't report a cluster as compliant, or a requirement as violated, until you've confirmed the assessment identity has permission to read what the control inspects.

{{< /warning >}}

## Create the profile

To create a profile that uses the Kubernetes resource pack, follow these steps:

1. Generate the profile:

   ```shell
   inspec init profile k8s-compliance-profile
   ```

1. Replace `k8s-compliance-profile/inspec.yml` with:

   ```yaml
   name: k8s-compliance-profile
   title: Kubernetes cluster baseline
   maintainer: Example Organization
   copyright: Example Organization
   copyright_email: compliance@example.com
   license: Apache-2.0
   summary: Check namespaces, network policies, and workload settings
   version: 0.1.0
   supports:
     platform: k8s
   depends:
     - name: inspec-k8s
       url: https://github.com/inspec/inspec-k8s/archive/main.tar.gz
   inputs:
     - name: namespaces
       description: Application namespaces that must exist and be isolated
       type: Array
       required: true
     - name: workload_namespace
       description: Namespace of the workload to check
       type: String
       required: true
     - name: workload_pod
       description: Name of the pod to check
       type: String
       required: true
     - name: workload_container
       description: Name of the container in that pod to check
       type: String
       required: true
   ```

   `supports: platform: k8s` tells Chef InSpec that the target is a Kubernetes cluster, not a host.
   The dependency points at the `main` branch for brevity.
   For scheduled production runs, pin a reviewed revision rather than a moving branch.
   For dependency options, see [profile dependencies](/inspec/latest/profiles/depends/).

1. Remove the generated example control:

   ```shell
   rm k8s-compliance-profile/controls/example.rb
   ```

1. Create `k8s-compliance-profile/controls/cluster_baseline.rb`:

   ```ruby
   namespaces = input('namespaces')

   control 'k8s-namespaces-exist' do
     impact 0.5
     title 'Application namespaces exist'
     desc 'Workloads must run in the namespaces the organization has defined.'

     describe k8s_namespaces do
       it { should exist }
       namespaces.each do |ns|
         its('names') { should include ns }
       end
     end
   end

   namespaces.each do |ns|
     control "k8s-network-policy-#{ns}" do
       impact 0.7
       title "Namespace #{ns} has a network policy"
       desc 'Pods in a namespace with no network policy accept traffic from any source.'

       describe k8s_network_policies(namespace: ns) do
         it { should exist }
       end
     end
   end

   control 'k8s-workload-pinned-image' do
     impact 0.5
     title 'Workload image uses a pinned tag'
     desc 'The latest tag changes without notice, so the running image cannot be traced to a reviewed build.'

     describe k8s_container(namespace: input('workload_namespace'),
                            pod_name: input('workload_pod'),
                            name: input('workload_container')) do
       it { should exist }
       its('image') { should_not match(/:latest$/) }
     end
   end
   ```

   The first two controls use documented properties of [`k8s_namespaces`](/inspec/resource_packs/k8s/k8s_namespaces/) and [`k8s_network_policies`](/inspec/resource_packs/k8s/k8s_network_policies/).
   The third uses the `image` property of [`k8s_container`](/inspec/resource_packs/k8s/k8s_container/).
   The same resource also exposes `securityContext`, `resource`, and probe settings, which you can use to extend the check.
   Keep control IDs stable so you can compare results over time and apply waivers.
   Choose impact values that match your organization's risk model.

1. Create `k8s-compliance-profile/inputs.yml`:

   ```yaml
   namespaces:
     - payments
     - orders
   workload_namespace: payments
   workload_pod: <pod-name>
   workload_container: <container-name>
   ```

   Replace the values with namespaces, a pod, and a container from your test cluster.
   Keep credentials out of this file.
   Use separate input files for clusters or environments with different requirements.
   See [inputs](/inspec/latest/profiles/inputs/).

## Validate and run the assessment

To check the profile and run it against the cluster, follow these steps:

1. Download the resource pack dependency into the profile, then validate the profile structure and control syntax:

   ```shell
   inspec vendor k8s-compliance-profile
   inspec check k8s-compliance-profile
   ```

   A profile that depends on a URL must be vendored before `inspec check` reports it as valid.
   Validation doesn't confirm cluster access or that the controls produce correct results.

1. Run the profile with the cluster as the target:

   ```shell
   mkdir -p results
   inspec exec k8s-compliance-profile -t k8s:// \
     --input-file k8s-compliance-profile/inputs.yml \
     --reporter cli json:results/k8s-compliance.json
   ```

   The target is the cluster, not a machine, so there's nothing to connect to over SSH.
   Chef InSpec uses your `KUBECONFIG` or `~/.kube/config` to find the cluster, and the CLI reporter prints results while the JSON reporter writes the same assessment to a file.
   Use a unique results path for each cluster and run so later assessments don't overwrite earlier evidence.

1. Review the results:

   | Outcome | Interpretation |
   | --- | --- |
   | Passed | The collected values met the check |
   | Failed | A check wasn't met. Confirm the assessment identity can read the object before you conclude the cluster violates the requirement. |
   | Skipped | The check wasn't evaluated. A skip isn't evidence of compliance. |
   | Waived | An approved exception changes how a failure is handled. It doesn't show the requirement is met. |

   The following output is from a test cluster where the `payments` namespace has a network policy, the `orders` namespace doesn't, and the `web` pod runs `nginx:latest`.
   Your object names and results differ.

   ```text
   ✔  k8s-namespaces-exist: Application namespaces exist
      ✔  k8s_namespaces is expected to exist
      ✔  k8s_namespaces names is expected to include "payments"
      ✔  k8s_namespaces names is expected to include "orders"
   ✔  k8s-network-policy-payments: Namespace payments has a network policy
      ✔  k8s_network_policies is expected to exist
   ×  k8s-network-policy-orders: Namespace orders has a network policy
      ×  k8s_network_policies is expected to exist
      expected k8s_network_policies to exist
   ×  k8s-workload-pinned-image: Workload image uses a pinned tag (1 failed)
      ✔  payments/web is expected to exist
      ×  payments/web image is expected not to match /:latest$/
      expected "nginx:latest" not to match /:latest$/

   Profile Summary: 2 successful controls, 2 control failures, 0 controls skipped
   Test Summary: 5 successful, 2 failures, 0 skipped
   ```

   The `inspec-k8s` profile also appears in the output with `No tests executed`.
   It's the resource pack dependency, which provides resources and no controls.
For result formats and CLI options, see [reporters](/inspec/latest/configure/reporters/) and the [CLI reference](/inspec/latest/reference/cli/).

If the run can't connect, first confirm that `kubectl get namespaces` works with the same `KUBECONFIG` and context.
The Kubernetes target comes from the [train-kubernetes](https://github.com/inspec/train-kubernetes) plugin, which is included with Chef InSpec 5.22.0 and later.
On earlier versions, see the plugin's [installation and troubleshooting notes](https://github.com/inspec/train-kubernetes#installation).

## Fix a finding and reassess

When a control fails, correct the cluster through the process your team already uses, not by editing the profile.
For the failed network-policy control, that means adding a policy to the namespace through your normal deployment pipeline.

Then run the same profile again with the same inputs and keep both results:

```shell
inspec exec k8s-compliance-profile -t k8s:// \
  --input-file k8s-compliance-profile/inputs.yml \
  --reporter cli json:results/k8s-compliance-after-fix.json
```

The network policy control that failed before now passes, and the pair of files is your evidence that the gap existed and was closed.
The pinned image control still fails until the workload is redeployed with a pinned tag, which is also a correct result.
[Step 6 of SSH compliance](/solutions/compliance/ssh_baseline/#step-6-fix-the-finding-and-reassess) shows the same fix-and-reassess loop on a single control.

For requirements covered by the CIS Kubernetes Benchmark, Chef remediation content is delivered as [Chef Infra](/client/latest/) cookbooks.
Check [Containers / Kubernetes](/premium_content/containers_kubernetes/) for the benchmark versions covered, and test remediation content with [Chef Workstation](/workstation/latest/) before you apply it to production systems.

## Record an approved exception

Use a waiver for a reviewed, time-bound exception rather than changing a control so one namespace passes.
To waive the network policy check for a namespace you're retiring, follow these steps:

1. Create `k8s-compliance-profile/waivers.yml`:

   ```yaml
   k8s-network-policy-orders:
     run: false
     justification: >-
       Exception SEC-2210. The orders namespace is decommissioned by the
       end of the quarter. Approved by the platform security owner.
     expiration_date: 2027-03-31
   ```

   Replace the control ID, reference, approver, and expiration date with the approved exception, and choose a future date.

1. Run the assessment with the waiver:

   ```shell
   inspec exec k8s-compliance-profile -t k8s:// \
     --input-file k8s-compliance-profile/inputs.yml \
     --waiver-file k8s-compliance-profile/waivers.yml \
     --reporter cli json:results/k8s-compliance-waived.json
   ```

   `run: false` skips the control.
   An expired waiver no longer applies, and the check determines the result again.

{{< warning >}}

Chef InSpec applies a waiver by control ID.
Because this profile creates one network policy control for each namespace, the ID names the namespace.
Don't reuse a waiver file for a different cluster without checking that its control IDs still describe the exception you approved.

{{< /warning >}}

Report waived controls separately from controls that meet the requirement.
For supported fields, see [waivers](/inspec/latest/configure/waivers/).

## Run it on a schedule and keep the evidence

A single run is a snapshot.
To detect drift, run the same profile on a schedule and compare results:

| Change between runs | Interpretation |
| --- | --- |
| Passed to failed, same profile and inputs | A new finding or drift |
| Failed to passed, same profile and inputs | A correction |
| Failed in consecutive runs | A persistent finding |
| Changed profile, inputs, or cluster | A scope change that needs separate interpretation |
| A waiver granted or expired | An exception change |

With each run, store the Chef InSpec version, the profile version and the revision of the resource pack, the inputs, the cluster you targeted, and the time of the run, along with the JSON results.
The JSON report records the profile and its results, so keep the other items alongside it.
Keep failed runs as well as passing ones, and keep credentials out of the stored evidence.

Run the profile on a schedule from your pipeline or another approved scheduler, using a read-only kubeconfig stored in your secret store.
[Chef Automate](/automate/) scan jobs don't currently list a Kubernetes cluster among the [targets they scan](/automate/scan_jobs/), so the examples on this page run Chef InSpec directly.
If you need cluster results in Chef Automate [compliance reporting](/automate/reports/), confirm the integration with Chef support before you design around it.

## Extend the profile

The Kubernetes resource pack includes resources for the following objects.
Each has a singular and a plural form, such as `k8s_pod` and `k8s_pods`.

| Area | Resources |
| --- | --- |
| Workloads | `k8s_pod`, `k8s_container`, `k8s_deployment`, `k8s_daemon_set`, `k8s_job`, `k8s_cronjob` |
| Isolation and namespaces | `k8s_namespace`, `k8s_network_policy` |
| Access | `k8s_rbac_cluster_role` |
| Configuration and nodes | `k8s_config_map`, `k8s_node`, `k8s_exec_file` |
| Anything else | `k8sobject`, `k8sobjects`, `k8s_api_resources` |

Use `k8sobject` or `k8sobjects` for resource types the pack doesn't have a dedicated resource for.
Use `k8s_exec_file` to check file permissions and ownership inside a running Linux container.

To assert a container's `securityContext`, use the plural resource and filter on the key.
The keys are symbols, as in the [`k8s_containers` examples](/inspec/resource_packs/k8s/k8s_containers/):

```ruby
describe k8s_containers(namespace: 'payments').where { securityContext && securityContext[:privileged] == true } do
  it { should_not exist }
end
```

Good next controls include requiring resource limits on workloads, restricting which cluster roles grant broad permissions, and checking node settings.
For the resource reference, see the [Kubernetes resource pack](/inspec/resource_packs/k8s/).
To learn how the pack plugs into a profile in general, and how other resource packs work, see [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/).

Before you expand from one cluster to a fleet of them:

- Give every cluster an owner and an environment tier.
- Keep policy values in inputs and stable requirements in controls.
- Select cluster-specific waivers explicitly.
- Report which clusters you assessed, which you couldn't reach, and which you excluded, so a coverage figure always has a denominator.

## Related documentation

- [Kubernetes resource pack](/inspec/resource_packs/k8s/)
- [Containers / Kubernetes coverage](/premium_content/containers_kubernetes/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
- [Profiles](/inspec/latest/profiles/)
- [Compliance reporting](/automate/reports/)
- [Compliance overview](/solutions/compliance/)
