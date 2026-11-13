+++
title = "The Chef way of virtual machine compliance"
description = "Assess virtual machines with Chef InSpec: check the guest operating system, the VM's configuration in the platform that hosts it, and the templates you clone from, then scale the assessment across on-premises and cloud VMs."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/vm_compliance"
  parent = "overview/solutions/compliance"
  title = "VM compliance"
  weight = 12
+++

Most of a modern fleet runs as virtual machines, and most of those VMs are clones.
A setting that's wrong in a template is wrong in every VM built from it, a VM built from last year's image starts life out of compliance, and a VM created during an incident can run for months without anyone assessing it.

Checking VMs one at a time doesn't keep up with how quickly they're created.
The steps below write a Chef InSpec profile for requirements that are specific to VMs, run it against a VM together with a published operating system benchmark, check the template before it's cloned, and then scale the same assessment across on-premises and cloud VMs.

## What VM compliance covers

A VM is assessed at three layers.
Each layer answers a different question and uses a different target, so plan them separately.

| Layer | What you're asking | How Chef assesses it | Target |
| --- | --- | --- | --- |
| **Guest operating system** | Is the operating system inside the VM configured to its benchmark? | CIS Benchmark and DISA STIG profiles for the operating system, plus your own controls | The VM, over SSH or WinRM, or locally through the Compliance Phase |
| **VM configuration in the platform** | Is the VM itself built correctly, with an approved image, approved extensions, and expected disks and network? | Resource packs that read the platform's API | The cloud account or subscription |
| **Hypervisor host** | Is the host the VMs run on configured to its benchmark? | Published virtualization benchmark content, where covered | The host |

The second and third layers are covered in [Check the VM's configuration in the platform](#check-the-vms-configuration-in-the-platform) and [Assess hypervisor hosts](#assess-hypervisor-hosts).

## What you'll build

A Chef InSpec profile with three controls that assert:

- The VM runs as a guest on a virtualization platform your organization approves.
- VMware guests run `open-vm-tools`, so the platform can report guest state, shut the guest down cleanly, and quiesce it for snapshots.
- The clone regenerated its machine ID rather than retaining the template ID.

These are requirements a general operating system benchmark doesn't check, because they only make sense on a VM.
You'll run this profile in the same command as a published benchmark, so one run covers both.

By the end you'll be able to run that profile against a VM, use the same profile to check a template before it's cloned, and schedule the assessment so new VMs are assessed as they're created.

## Before you begin

You need:

- **Chef InSpec**, from [Chef Workstation](/workstation/latest/) or a [standalone install](/inspec/latest/install/).
  Run `inspec version` to confirm it's available.
- **A Linux VM to assess**, on any hypervisor or cloud, that you can reach over SSH with an account that can escalate with `sudo`.
  For Windows VMs, the same steps apply over WinRM---see [Run the assessment against a VM](#run-the-assessment-against-a-vm).
- **The template's machine ID**, if you clone VMs from a template.
  Read it on the template with `cat /etc/machine-id`.
  A correctly sealed template has an empty file, so every clone generates its own ID on first boot---`vm-03` catches clones of templates that weren't sealed.

You don't need to install anything on the VM or the hypervisor.
Chef InSpec connects to the guest and reads what it needs.

## Create a profile

Generate a profile:

```shell
inspec init profile vm-guest-baseline
```

```text
─────────────────────────── InSpec Code Generator ───────────────────────────

Creating new profile at ./vm-guest-baseline
 • Creating file README.md
 • Creating directory ./vm-guest-baseline/controls
 • Creating file controls/example.rb
 • Creating file inspec.yml
```

Replace `vm-guest-baseline/inspec.yml` with:

```yaml
name: vm-guest-baseline
title: Virtual machine guest baseline
maintainer: Example Organization, Inc.
copyright: Example Organization, Inc.
copyright_email: compliance@example.com
license: Apache-2.0
summary: Verify that Linux virtual machines run on an approved platform and were provisioned correctly from a template
version: 0.1.0
supports:
  - platform-family: linux
inputs:
  - name: approved_hypervisors
    description: Virtualization platforms that virtual machines in scope may run on
    type: Array
    value:
      - vmware
      - kvm
      - hyper-v
  - name: template_machine_id
    description: Machine ID recorded on the template that VMs are cloned from
    type: String
    value: 5f1a7c3e9b2d4e6f8a0b1c2d3e4f5a6b
```

The `inputs` hold the values that differ between organizations: which platforms you approve, and which template you clone from.
Keeping them out of the controls means you don't edit the controls when those values change.
Override them at run time with `--input`, or keep them in an input file for each environment.
See [Chef InSpec inputs](/inspec/latest/profiles/inputs/).

`supports` limits the profile to Linux, as in [Create a profile in SSH compliance](/solutions/compliance/ssh_baseline/#create-a-profile).

## Write the controls

Delete `controls/example.rb` and create `controls/vm.rb`:

```ruby
control 'vm-01' do
  impact 'high'
  title 'Run only on an approved virtualization platform'
  desc 'Virtual machines in scope must run as guests on a hypervisor the organization has approved.'
  desc 'rationale', 'A VM on an unapproved platform sits outside the controls, backups, and monitoring built for approved ones.'
  tag 'vm'

  describe virtualization do
    its('role') { should cmp 'guest' }
    its('system') { should be_in input('approved_hypervisors') }
  end
end

control 'vm-02' do
  impact 'medium'
  title 'Install guest tools on VMware virtual machines'
  desc 'VMware guests must run open-vm-tools so the platform can report guest state, shut the guest down cleanly, and quiesce it for snapshots.'
  tag 'vm', 'vmware'

  only_if('This control applies to VMware guests only.') do
    virtualization.system == 'vmware'
  end

  describe package('open-vm-tools') do
    it { should be_installed }
  end

  describe processes('vmtoolsd') do
    it { should exist }
  end
end

control 'vm-03' do
  impact 'high'
  title 'Regenerate the machine ID from the template'
  desc 'A VM cloned from a template must have a valid machine ID that differs from the template ID, confirming the template was sealed.'
  desc 'rationale', 'A clone that retains the template machine ID indicates an unsealed template, causing duplicate identifiers across clones in logging, monitoring, and DHCP.'
  tag 'vm', 'template'

  describe file('/etc/machine-id') do
    its('content') { should match(/\A\h{32}\s*\z/) }
    its('content') { should_not match(/\A#{input('template_machine_id')}/) }
  end
end
```

What's specific to VMs here:

`describe virtualization`
: The [`virtualization` resource](/inspec/latest/resources/core/virtualization/) reports the platform the target runs on as `system`, such as `vmware`, `kvm`, or `hyper-v`, and whether the target is a `guest` or a `host` as `role`.
  On a physical machine both are empty, so `vm-01` fails, which is the right result for a profile meant only for VMs.

`only_if`
: Runs the control only when the condition is true, and reports it as skipped otherwise, with the message you supply.
  `vm-02` uses it so the VMware requirement doesn't fail on KVM or Hyper-V guests.
  Use the same pattern for requirements specific to any one platform.

`processes('vmtoolsd')`
: Checks the guest tools daemon by process name rather than by service name, because the service unit is named differently across distributions.

`input('template_machine_id')`
: Reads the value from `inspec.yml`, or from `--input` at run time.
  `vm-03` uses it to catch clones of unsealed templates that kept the template's ID, and the format check catches clones where the ID was never generated at all.

For the parts of a control that aren't specific to VMs (`impact`, `desc`, `tag`, and `cmp`), see [Write the controls in SSH compliance](/solutions/compliance/ssh_baseline/#write-the-controls).

## Validate the profile

```shell
inspec check vm-guest-baseline
```

```text
Location :   vm-guest-baseline
Profile :    vm-guest-baseline
Controls :   3
Timestamp :  2026-11-04T15:31:43+05:30
Valid :      true

No errors, warnings, or offenses
```

## Run the assessment against a VM

Run the profile against a VM over SSH:

```shell
inspec exec vm-guest-baseline \
  --target ssh://admin@app01.example.com \
  --key-files ~/.ssh/id_rsa \
  --sudo
```

For a Windows VM, use a `winrm://` target instead of `ssh://`, as described in the [Chef InSpec CLI reference](/inspec/latest/reference/cli/), and write the platform-specific controls against Windows resources.
`virtualization` reports `hyper-v`, `vmware`, `kvm`, `virtualbox`, and `xen` guests on Windows.

### Run it with the operating system benchmark

The profile above checks what's specific to VMs.
The guest operating system still needs its own benchmark.
`inspec exec` accepts more than one profile, so pass both and assess the VM in a single run:

```shell
inspec exec vm-guest-baseline path/to/os-benchmark-profile \
  --target ssh://admin@app01.example.com \
  --key-files ~/.ssh/id_rsa \
  --sudo \
  --reporter cli json:app01-results.json
```

Get the operating system benchmark profile for your distribution from the [Chef Automate Profiles page](/automate/profiles/), and confirm the benchmark version you need is covered in [Operating Systems](/premium_content/operating_systems/).
Each profile reports its own results, so a reviewer can tell a VM-specific finding from a benchmark finding.

## Read the results

A run against a VMware VM that was cloned from a template without regenerating its machine ID, and that doesn't have guest tools installed:

```text
Profile:   Virtual machine guest baseline (vm-guest-baseline)
Version:   0.1.0
Target:    ssh://admin@app01.example.com:22

  ✔  vm-01: Run only on an approved virtualization platform
     ✔  Virtualization Detection role is expected to cmp == "guest"
     ✔  Virtualization Detection system is expected to be in "vmware", "kvm", and "hyper-v"
  ×  vm-02: Install guest tools on VMware virtual machines (2 failed)
     ×  System Package open-vm-tools is expected to be installed
     expected that `System Package open-vm-tools` is installed
     ×  Processes vmtoolsd is expected to exist
     expected Processes vmtoolsd to exist
  ×  vm-03: Regenerate the machine ID from the template (1 failed)
     ✔  File /etc/machine-id content is expected to match /\A\h{32}\s*\z/
     ×  File /etc/machine-id content is expected not to match /\A5f1a7c3e9b2d4e6f8a0b1c2d3e4f5a6b/


Profile Summary: 1 successful control, 2 control failures, 0 controls skipped
Test Summary: 3 successful, 3 failures, 0 skipped
```

`vm-03` is the finding to act on first.
The machine ID is well-formed but matches the template's, indicating that the template wasn't sealed before cloning.
Fixing it on one VM doesn't fix the next clone---fix the template, as described in [Check the template before you clone it](#check-the-template-before-you-clone-it).

On a KVM or Hyper-V guest, `vm-02` reports as skipped with the `only_if` message, not as a pass.

For exit codes, keeping results as evidence, and recording an accepted exception as a waiver, the steps are the same as for any profile:

- [Check the exit code](/solutions/compliance/ssh_baseline/#check-the-exit-code)
- [Keep the results](/solutions/compliance/ssh_baseline/#keep-the-results)
- [Waive an exception you've accepted](/solutions/compliance/ssh_baseline/#waive-an-exception-youve-accepted)

## Check the template before you clone it

Every finding in a template is copied into every VM built from it.
The cheapest place to catch a finding is the template, before you publish it, because you fix it once.

Use [Test Kitchen](/workstation/latest/tools/kitchen/) to build a VM from the template, run your profiles against it, and destroy it.
Configure the InSpec verifier in `kitchen.yml` to run the same profiles you run in production:

```yaml
verifier:
  name: inspec

suites:
  - name: template
    verifier:
      inspec_tests:
        - path: ../vm-guest-baseline
        - path: ../os-benchmark-profile
```

Then build, verify, and destroy the test instance:

```shell
kitchen test template
```

Two things to account for when you verify a template this way:

- **Test Kitchen tests a clone, not the template.**
  The instance it builds boots from the template like any other clone, so `vm-03` tells you whether the template was sealed: a clone that comes up with a new machine ID passes, and one that comes up with the template's ID fails.
- **Use the same driver your clones use.**
  A template verified on a different hypervisor reports a different `virtualization.system`, so `vm-01` and `vm-02` don't test what your clones will see.
  Test Kitchen has drivers for VMware vCenter, Hyper-V, and cloud providers; see [Chef and VMware](/client/latest/integrations/vmware/#test-kitchen) for the VMware drivers.

## Assess VMs across your fleet

Running a profile by hand answers a question once.
Running it on a schedule is what catches a VM that drifts, or one nobody knew was created.
How you schedule it depends on where the VMs run and whether Chef Infra Client manages them.

| Where the VMs run | Managed by Chef Infra Client | Not managed by Chef Infra Client |
| --- | --- | --- |
| On-premises hypervisor, such as vSphere, Hyper-V, or KVM | [Compliance Phase](/client/latest/features/chef_compliance_phase/) | Add the VMs as manual nodes with [node credentials](/automate/node_credentials/), then create a [scan job](/automate/scan_jobs/) |
| AWS EC2 | Compliance Phase | AWS EC2 node manager in [node integrations](/automate/node_integrations/#add-an-aws-ec2-node-manager), then a scan job |
| Azure | Compliance Phase | Azure VM node manager in [node integrations](/automate/node_integrations/#azure-vm-scanning-with-chef-automate), then a scan job |
| Google Cloud | Compliance Phase | Add the VMs as manual nodes with node credentials, then create a scan job |
| Hybrid, with VMs across on-premises and cloud | Compliance Phase, configured the same way on every platform | Enroll the VMs in [Chef 360 Platform](/360/latest/use/operators/node_enrollment/), then run compliance scans as [Chef Courier jobs](/360/latest/use/operators/job_execution/) |

For a fleet that spans locations, the Compliance Phase is the one approach that works the same everywhere, because each VM assesses itself and doesn't depend on a node manager for its platform.

### Cloud VMs are discovered for you

The AWS EC2 and Azure VM node managers query the account for instances, so you don't add those VMs by hand.
The [GCP node manager](/automate/node_integrations/#google-cloud-platform-account-scanning-with-chef-automate) is different: it adds the project as a single node so you can scan the account's configuration, and it doesn't discover Compute Engine VMs.
Add Google Cloud VMs as manual nodes, or manage them with Chef Infra Client.
When a scheduled scan job runs, Chef Automate queries the provider for the current list of instances, so VMs created since the last run are included and terminated ones aren't.
Filter the scan job by region or tag to scope it, for example, to assess only instances tagged as production.

Each node manager also offers a way to scan without SSH or WinRM credentials: AWS Systems Manager for EC2 instances, and Azure RunCommand for Azure VMs.
Both require the instances to reach Chef Automate.
See [node integrations](/automate/node_integrations/) for the permissions each needs.

### On-premises VMs need an inventory

Chef Automate doesn't have a node manager for on-premises hypervisors, so VMs that aren't managed by Chef Infra Client are added as manual nodes.
Tag them when you add them, by environment, cluster, or owner.
Scan jobs can then select them by tag instead of by name.
If VMs are created and destroyed often, managing them with Chef Infra Client and the Compliance Phase avoids maintaining that list, because each VM assesses itself on every Chef Infra Client run.

### Hybrid fleets need one approach everywhere

When VMs run on-premises and in more than one cloud, using a different discovery method for each location leaves gaps where they meet, for example, servers extended into a cloud provider's management plane that no Chef Automate node manager discovers.
Treat those as on-premises VMs, and choose an approach that doesn't depend on where a VM runs:

- **The Compliance Phase**, for VMs managed by Chef Infra Client.
  Every VM runs the same profiles on every Chef Infra Client run, wherever it is.
- **Chef 360 Platform**, for VMs that aren't.
  [Node enrollment](/360/latest/use/operators/node_enrollment/) installs the Node Management agent on each VM, through bulk, cookbook-based, single-node, or self enrollment, and [Chef Courier](/360/latest/use/operators/job_execution/) runs Chef InSpec scans on enrolled nodes as scheduled or one-time jobs.
  The Chef InSpec interpreter requires Chef InSpec on the node; see the [Chef 360 SaaS system requirements](/360/saas/system_requirements/).

Report results from every source into [compliance reporting](/automate/reports/), where you can filter by platform, profile, and control.

## Check the VM's configuration in the platform

Some requirements are about the VM, not the operating system inside it: which image it was launched from, which extensions are installed, or which security groups it's in.
The guest can't answer those.
The platform's API can.

The cloud resource packs read that configuration.
This control checks that an EC2 instance was launched from an approved image and has no IAM role attached:

```ruby
control 'vm-aws-01' do
  impact 'high'
  title 'Launch production instances from an approved image'
  tag 'vm', 'aws'

  describe aws_ec2_instance(name: 'app01') do
    it { should be_running }
    its('image_id') { should be_in input('approved_ami_ids') }
    it { should_not have_roles }
  end
end
```

And this one checks that an Azure VM runs only approved extensions:

```ruby
control 'vm-azure-01' do
  impact 'medium'
  title 'Install only approved VM extensions'
  tag 'vm', 'azure'

  describe azure_virtual_machine(resource_group: 'production', name: 'app01') do
    it { should have_only_approved_extensions(input('approved_extensions')) }
  end
end
```

These controls run against the cloud account, not the VM, so they belong in a separate profile from `vm-guest-baseline`.
For setting up a cloud profile, credentials, and permissions, see [The Chef way of AWS compliance](/solutions/compliance/aws_foundations/), and for the other cloud resource packs, see [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/#available-resource-packs).
The resource references list every property and matcher: [`aws_ec2_instance`](/inspec/resource_packs/aws/aws_ec2_instance/) and [`azure_virtual_machine`](/inspec/resource_packs/azure/azure_virtual_machine/).

## Assess hypervisor hosts

The hypervisor is part of the compliance boundary for every VM it runs.
Check the [Virtualization](/premium_content/virtualization/) coverage table to see which hypervisor benchmarks Chef publishes content for, and whether that coverage is audit, remediation, or both.

There's no supported Chef InSpec resource pack for hypervisor APIs such as vSphere.
The `inspec-vmware` resource pack mentioned in [Chef and VMware](/client/latest/integrations/vmware/#chef-inspec) was an incubation project and is archived, so don't plan new work around it.

## Fix what fails

For the guest operating system, [compliance remediation](/solutions/compliance/#compliance-remediation) content corrects the configuration behind failing benchmark controls on VMs managed by Chef Infra Client.
Check remediation coverage for your benchmark first; it's narrower than audit coverage.

For VM-specific findings, fix the source rather than each VM:

- **A finding on every clone** is a template finding.
  Fix the template, reverify it with [Test Kitchen](#check-the-template-before-you-clone-it), then rebuild or remediate the existing clones.
- **A finding on one VM** is drift.
  Fix it with Chef Infra Client, so the fix is reapplied if it drifts again, and reassess to confirm the control passes.
- **A finding you've accepted**, such as a legacy VM on an unapproved platform that's scheduled for migration, is a waiver with a justification and an expiration date, not an ignored failure.

## Where to go next

**Turn it on for the fleet.**
Enable the [Compliance Phase](/client/latest/features/chef_compliance_phase/) on managed VMs, and create recurring [scan jobs](/automate/scan_jobs/) for cloud VMs and VMs that Chef Infra Client doesn't manage.

**Find the benchmark for each guest.**
Use the [Operating Systems](/premium_content/operating_systems/) coverage table to match each guest operating system and version to its benchmark.

**Prepare for an assessment.**
See [Prepare for a compliance assessment](/solutions/compliance/#prepare-for-a-compliance-assessment) for filtering, exporting, and accounting for every failing control.

## Related

- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
- [The Chef way of AWS compliance](/solutions/compliance/aws_foundations/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Virtualization benchmark coverage](/premium_content/virtualization/)
- [Chef Automate node integrations](/automate/node_integrations/)
- [Chef InSpec `virtualization` resource](/inspec/latest/resources/core/virtualization/)
- [Chef InSpec inputs](/inspec/latest/profiles/inputs/)
