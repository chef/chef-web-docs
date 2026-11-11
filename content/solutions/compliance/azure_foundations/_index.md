+++
title = "The Chef way of Azure compliance"
description = "Audit an Azure subscription against a security baseline with Chef InSpec and the Azure resource pack: check storage accounts and network security groups."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/azure_foundations"
  parent = "overview/solutions/compliance"
  title = "Azure compliance"
  weight = 6
+++

A storage account that allows anonymous blob access, a storage account that still accepts plain HTTP,
or a network security group that opens SSH or RDP to the internet can sit in an Azure subscription for months
before anyone notices.
Nothing in the Azure portal tells you these violate your baseline,
and checking by hand doesn't scale past a handful of subscriptions.

The steps below write a Chef InSpec profile with the **Azure resource pack**,
run it against an Azure subscription, and read what comes back.
It uses the same pattern as
[The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/),
applied to a cloud subscription instead of a host.
If you haven't written a Chef InSpec profile before, start there first.

## What you'll build

A Chef InSpec profile with three controls that assert:

- No storage account allows anonymous public access to blobs.
- Every storage account accepts HTTPS traffic only.
- No network security group allows SSH (22) or RDP (3389) from the internet.

By the end you'll be able to run that profile against an Azure subscription,
get a pass or fail result for each control,
save the results as a JSON file you can keep as evidence,
and record an approved exception so it doesn't show up as a failure.

[Extend the profile to more of the subscription](#extend-the-profile-to-more-of-the-subscription)
then adds two more storage account checks to the same profile,
using the same pattern you'd follow for any other Azure service.

{{< note >}}

**Where the details come from.**
Resource names, properties, matchers, and required roles on this page come from the
[Azure resource pack reference](/inspec/resource_packs/azure/).
The generated `inspec.yml` comes from the Chef InSpec `inspec init profile --platform azure` template.
Exit codes come from the [Chef InSpec CLI reference](/inspec/latest/reference/cli/).
Assessment results shown for a run against a live Azure subscription are illustrative and
are labeled where they appear.

{{< /note >}}

## Before you begin

You need:

- **Chef InSpec**, from [Chef Workstation](/workstation/latest/) or a
  [standalone install](/inspec/latest/install/).
  Run `inspec version` to confirm it's available.
- **An Azure subscription** to assess.
- **A service principal** with at least the **Reader** role on that subscription.
  Chef InSpec authenticates to Azure as a service principal, not as your user account.
- **The Azure CLI**, if you want to create the service principal from the command line.
  You can also create one in the Azure portal.

You don't need to install anything in the subscription.
Chef InSpec connects to the Azure Resource Manager API and reads what it needs.

### Roles each resource requires

The Azure resource pack reference lists the minimum role each resource needs on the subscription:

| Resource | Minimum role documented for it |
| --- | --- |
| [`azure_storage_accounts`](/inspec/resource_packs/azure/azure_storage_accounts/) | Reader |
| [`azure_storage_account`](/inspec/resource_packs/azure/azure_storage_account/) | Reader |
| [`azure_network_security_groups`](/inspec/resource_packs/azure/azure_network_security_groups/) | Reader |
| [`azure_network_security_group`](/inspec/resource_packs/azure/azure_network_security_group/) | Reader |

Some resources in the pack need more than Reader.
For example, [`azure_key_vault`](/inspec/resource_packs/azure/azure_key_vault/) documents the
**Contributor** role.
Check the reference page for each resource you add before you grant access.

A missing permission surfaces as an Azure API error on the control that needed it,
not as a failing assertion.
Grant read access before you interpret any result as a finding.

## Get the Azure resource pack

Checking a host uses Chef InSpec's core resources.
Checking Azure objects---a storage account, a network security group, a key vault---needs
the [Azure resource pack](/inspec/resource_packs/azure/), a separately
distributed set of resources for Azure.

The Azure pack covers virtual machines and disks, storage accounts, networking,
SQL and other databases, Key Vault, AKS, policy, monitoring, Microsoft Defender for Cloud,
and Microsoft Entra ID objects.
See the pack's own documentation for the full resource list with properties
and matchers for each one.

A resource pack isn't a benchmark and doesn't assess anything on its own.
It gives you the resources to write controls with;
the controls themselves are content you own and maintain.
For Chef's published Azure benchmark content, see
[supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms).

`inspec init profile --platform azure` declares the pack as a dependency; Step 2 fetches it.

## Step 1: Create a profile

Generate a profile pre-configured for Azure:

```shell
inspec init profile --platform azure azure-baseline
```

The generator creates `README.md`, `inspec.yml`, a `controls/` directory with an example control,
and a `libraries/` directory.

Two entries in the generated `azure-baseline/inspec.yml` are what make this an Azure profile:

```yaml
depends:
  - name: inspec-azure
    url: https://github.com/inspec/inspec-azure/archive/main.tar.gz
supports:
  - platform: azure
```

`depends` brings the `azure_*` resources into scope for your controls.
`supports` restricts the profile to Azure targets, so running it against a Linux host skips it
instead of reporting failures that mean nothing.
Both are described in the [profile dependencies reference](/inspec/latest/profiles/depends/)
and the [profile platforms reference](/inspec/latest/profiles/platforms/).

Describe what the profile is for in the same file, leaving `depends` and `supports` in place:

```yaml
name: azure-baseline
title: Azure subscription security baseline
maintainer: Example Organization, Inc.
copyright: Example Organization, Inc.
copyright_email: compliance@example.com
license: Apache-2.0
summary: Verify Azure storage account and network security group configuration against organization requirements
version: 0.1.0
```

For every field you can set here, see
[the inspec.yml reference](/inspec/latest/profiles/inspec_yml/).

## Step 2: Vendor the dependency

Declaring the pack isn't the same as having it.
The pack is fetched over the network, so pull it down before you rely on the profile:

```shell
inspec vendor azure-baseline
```

This writes a `vendor/` directory holding the pack and an `inspec.lock` file recording
exactly what was fetched, including a `sha256` for the archive.

The dependency URL points at `main`, so its contents change over time.
The `sha256` in `inspec.lock` pins the archive this profile resolved against;
commit `inspec.lock` with the profile and your runs stay reproducible until you
re-vendor on purpose with `inspec vendor --overwrite`.

## Step 3: Set credentials

Create a service principal with the Reader role on the subscription you want to assess.
With the Azure CLI:

```shell
az ad sp create-for-rbac --name inspec-audit --role Reader --scopes /subscriptions/<SUBSCRIPTION_ID>
```

Replace `<SUBSCRIPTION_ID>` with the ID of the subscription.
The command prints an `appId`, a `password`, and a `tenant`.
Chef InSpec calls these the client ID, the client secret, and the tenant ID.
Microsoft's
[service principal documentation](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal)
covers the same steps in the Azure portal.

Provide the service principal to Chef InSpec as environment variables:

```shell
export AZURE_SUBSCRIPTION_ID=<SUBSCRIPTION_ID>
export AZURE_CLIENT_ID=<CLIENT_ID>
export AZURE_CLIENT_SECRET=<CLIENT_SECRET>
export AZURE_TENANT_ID=<TENANT_ID>
```

As an alternative, put the same values in `~/.azure/credentials`,
with one section for each subscription:

```ini
[<SUBSCRIPTION_ID>]
client_id = "<CLIENT_ID>"
client_secret = "<CLIENT_SECRET>"
tenant_id = "<TENANT_ID>"
```

{{< warning >}}

Keep credentials out of the profile.
Nothing in `inspec.yml` or `controls/` should contain a client secret,
and none of those files should be committed with one.
Credentials belong in your environment or in `~/.azure/credentials`,
both of which stay outside the profile directory.

{{< /warning >}}

Confirm Chef InSpec can load the Azure transport:

```shell
inspec detect -t azure://
```

The platform details report `azure` as the platform name.
Treat this as confirmation that the Azure transport loaded,
and use the first run of the profile to confirm that your credentials work.

## Step 4: Write the controls

Delete the generated example control and create `controls/azure.rb`:

```ruby
control 'azure-01' do
  impact 'critical'
  title 'Storage accounts must not allow anonymous blob access'
  desc 'A storage account that allows public blob access lets anyone on the internet read containers set to public.'
  tag 'azure', 'storage'

  azure_storage_accounts.ids.each do |id|
    describe azure_storage_account(resource_id: id) do
      its('properties.allowBlobPublicAccess') { should cmp false }
    end
  end
end

control 'azure-02' do
  impact 'high'
  title 'Storage accounts must accept HTTPS traffic only'
  desc 'Secure transfer required rejects requests to the storage account over plain HTTP.'
  tag 'azure', 'storage'

  azure_storage_accounts.ids.each do |id|
    describe azure_storage_account(resource_id: id) do
      its('properties.supportsHttpsTrafficOnly') { should cmp true }
    end
  end
end

control 'azure-03' do
  impact 'high'
  title 'Network security groups must not allow SSH or RDP from the internet'
  desc 'SSH (22) and RDP (3389) open to the internet let anyone attempt a login.'
  tag 'azure', 'network'

  azure_network_security_groups.ids.each do |id|
    describe azure_network_security_group(resource_id: id) do
      it { should_not allow_ssh_from_internet }
      it { should_not allow_rdp_from_internet }
    end
  end
end
```

Each part of a control does a specific job:

`control 'azure-01'`
: The identifier that follows this check through every report.
  Keep it stable---if you renumber controls later, you lose the ability to compare
  this month's results against last month's.

`impact`
: How serious a failure is.
  Accepts `none`, `low`, `medium`, `high`, and `critical`, or a float from `0.0` to `1.0`.

`azure_storage_accounts`, `azure_network_security_groups`
: Plural resources from the Azure pack that list every matching object in the
  subscription, so a control checks the whole subscription instead of one account you
  have to name in advance.
  Each singular resource---`azure_storage_account`, `azure_network_security_group`---then
  inspects one object by its resource ID.

`its('properties.allowBlobPublicAccess')`
: Any property in the Azure Resource Manager response is available with its key names
  separated by dots.
  The [Azure storage account REST reference](https://learn.microsoft.com/en-us/rest/api/storagerp/storage-accounts/get-properties)
  lists every property you can test this way.

`should_not allow_ssh_from_internet`
: A matcher specific to the Azure pack's `azure_network_security_group` resource---this
  kind of target-specific matcher is exactly what a resource pack provides that core
  resources can't.

See the [Azure resource pack documentation](/inspec/resource_packs/azure/)
for the full set of Azure resources, and
[the controls reference](/inspec/latest/profiles/controls/) for control syntax.

Two details decide how much these controls actually cover:

**`cmp false` fails when the property is missing.**
Storage accounts created before Azure introduced the `allowBlobPublicAccess` setting
may not return it at all.
`azure-01` reports those accounts as failures, which is the safe result:
set the property explicitly and the control passes.

**`allow_ssh_from_internet` and `allow_rdp_from_internet` don't account for rule priority.**
The resource reference states that these matchers analyze security rules and default security
rules for unrestricted access without comparing the priorities of conflicting rules.
A network security group with a higher-priority deny rule in front of an internet-facing allow rule
still fails `azure-03`.
Where you need priority-aware results, use the `allow_in` matcher described in the
[`azure_network_security_group` reference](/inspec/resource_packs/azure/azure_network_security_group/).

## Step 5: Validate the profile

Before running the profile against a real subscription, check that it's well-formed:

```shell
inspec check azure-baseline
```

The output reports `Controls : 3` and `Valid : true` when Chef InSpec parsed all three controls.
A Ruby syntax error, an undeclared input, or a dependency you haven't vendored surfaces
here rather than part way through a run against production.

## Step 6: Run the assessment

The target is the Azure subscription, not a machine, so there's nothing to connect to
over SSH:

```shell
inspec exec azure-baseline -t azure://
```

If `~/.azure/credentials` holds more than one subscription,
name the one to assess in the target:

```shell
inspec exec azure-baseline -t azure://<SUBSCRIPTION_ID>
```

Against a different subscription, change the target or credentials and repeat the same
command---the profile doesn't change for each subscription.

If the credentials are missing or the service principal can't sign in,
the run stops with an Azure authentication error instead of reporting failed controls.
Resolve that before reading anything into a result.

## Step 7: Read the results

A run against a subscription with a public storage account and an open network security group
looks like this.
This output is illustrative:

```text
Profile:   Azure subscription security baseline (azure-baseline)
Version:   0.1.0
Target:    azure://<SUBSCRIPTION_ID>

  ×  azure-01: Storage accounts must not allow anonymous blob access
     ×  'examplepublicdata' Storage Account properties.allowBlobPublicAccess is expected to cmp == false

  ✔  azure-02: Storage accounts must accept HTTPS traffic only

  ×  azure-03: Network security groups must not allow SSH or RDP from the internet
     ×  'jumpbox-nsg' Network Security Group is expected not to allow ssh from internet


Profile Summary: 1 successful control, 2 control failures, 0 controls skipped
Test Summary: 2 successful, 2 failures, 0 skipped
```

Read it the same way as any Chef InSpec run:
`×` is a failure, `✔` is a pass, and each failure names the control, the
object checked, and what was expected.
Because `azure_storage_accounts` and `azure_network_security_groups` iterate every object in
the subscription, a single control can report multiple failures, one for each
storage account or network security group that doesn't meet the requirement.

### Exit codes

`inspec exec` sets an exit code describing the outcome, which is what a pipeline acts on:

| Exit code | Meaning |
| --- | --- |
| `0` | Normal exit, all tests passed |
| `1` | Usage or general error |
| `100` | Normal exit, at least one test failed |
| `101` | Normal exit, at least one test skipped but none failed |
| `172` | Chef license not accepted |

An authentication failure isn't a finding.
Treat any exit code other than `0`, `100`, or `101` as a broken run, not as evidence.
The complete list of codes is in the
[Chef InSpec CLI reference](/inspec/latest/reference/cli/).

### Keep the results

For evidence, write a structured file at the same time:

```shell
inspec exec azure-baseline -t azure:// --reporter cli json:results.json
```

The JSON includes each control's ID, its impact as a number, and the status
of every test, so you can feed it into a ticketing system or keep it as a
dated record.
Only one reporter can write to standard output at a time.
Other formats are in the [reporters reference](/inspec/latest/configure/reporters/).

## Step 8: Fix a finding and reassess

The storage account finding above is a configuration change in Azure, not in the
profile.
[Prevent anonymous read access](https://learn.microsoft.com/en-us/azure/storage/blobs/anonymous-read-access-prevent)
on the storage account, then run the same profile again:

```shell
inspec exec azure-baseline -t azure://
```

```text
  ✔  azure-01: Storage accounts must not allow anonymous blob access
  ✔  azure-02: Storage accounts must accept HTTPS traffic only
  ×  azure-03: Network security groups must not allow SSH or RDP from the internet


Profile Summary: 2 successful controls, 1 control failure, 0 controls skipped
```

Running the profile again is what demonstrates the fix worked.
The first run found the gap, the second run is the evidence that it's closed,
and both are dated.

{{< note >}}

Correct Azure findings with Azure tooling.
Nothing in the Azure resource pack changes a configuration---it reads the Azure APIs and
reports what it finds---and Chef's remediation cookbooks cover operating system and
platform benchmarks, not cloud provider APIs.
See [compliance remediation](/solutions/compliance/#compliance-remediation) for what
remediation content covers.

{{< /note >}}

## Step 9: Waive an exception you've accepted

Some findings are accepted rather than fixed---for example, a network security
group intentionally open for a documented reason.
Create `waivers.yml`:

```yaml
azure-03:
  justification: "Approved exception CHG-5214; jump box requires direct SSH access during the migration window."
  expiration_date: 2027-06-30
  run: false
```

Apply it:

```shell
inspec exec azure-baseline -t azure:// --waiver-file waivers.yml
```

The control reports as skipped and carries your justification into the
report, the same way a waiver works for any Chef InSpec profile.
See [the waivers reference](/inspec/latest/configure/waivers/) for the full
file format, and
[Step 7 of SSH compliance](/solutions/compliance/ssh_baseline/#step-7-waive-an-exception-youve-accepted)
for another worked example.

## Extend the profile to more of the subscription

The three controls above check one thing for each requirement.
Adding more follows the same shape: list objects with the plural resource,
assert against each one with the singular resource.

Storage accounts are a useful example because exposure isn't only about anonymous access.
Add these controls to `controls/azure.rb`:

```ruby
control 'azure-04' do
  impact 'high'
  title 'Storage accounts must require TLS 1.2 or later'
  desc 'Older TLS versions have known weaknesses and should be rejected by the service.'
  tag 'azure', 'storage'

  azure_storage_accounts.ids.each do |id|
    describe azure_storage_account(resource_id: id) do
      its('properties.minimumTlsVersion') { should cmp 'TLS1_2' }
    end
  end
end

control 'azure-05' do
  impact 'medium'
  title 'Storage account access keys must be rotated within 90 days'
  desc 'Long-lived access keys increase the window in which a leaked key remains useful.'
  tag 'azure', 'storage'

  azure_storage_accounts.ids.each do |id|
    describe azure_storage_account(resource_id: id) do
      it { should have_recently_generated_access_key }
    end
  end
end
```

`have_recently_generated_access_key` is a matcher from the
[`azure_storage_account` reference](/inspec/resource_packs/azure/azure_storage_account/)
that tests whether an access key was generated within the last 90 days.
`azure-04` compares against the exact value Azure returns, so an account that has never had
a minimum TLS version set fails it, as well as one set to an older version.

Re-run `inspec check` after adding controls.
`Controls : 5` confirms both were parsed.

A storage account that fails `azure-04` needs its
[minimum TLS version](https://learn.microsoft.com/en-us/azure/storage/common/transport-layer-security-configure-minimum-version)
set to TLS 1.2.
One that fails `azure-05` needs its access keys rotated.

The same approach works for the rest of the subscription.
Every resource in the [Azure resource pack](/inspec/resource_packs/azure/) lists its
properties and matchers, and the ones you need depend on which requirements you're
assessing.

## Run it on a schedule with Chef Automate

Running the profile by hand answers the question for today.
Because subscriptions change constantly, the useful version of this assessment runs again
without anybody remembering to run it.

Chef Automate assesses an Azure subscription through an Azure API node manager, which creates
a node reference for each subscription your service principal can see:

1. In Chef Automate, on the **Settings** tab, go to the **Node Integrations** page and add
   an Azure API node manager with the client ID, client secret, and tenant ID of your service principal.
   Optionally, limit it to one subscription ID.
   The [node integrations documentation](/automate/node_integrations/) covers the setup.
1. Upload the profile from the [Chef Automate Profiles page](/automate/profiles/).
1. Create a [scan job](/automate/scan_jobs/) that runs the profile against the Azure API node
   manager, and set it to recur.
   Scan jobs accept `azure-api` subscriptions as a target, which is the same subscription-level
   target as `-t azure://`.
1. Review results in [compliance reporting](/automate/reports/), filtered by profile and
   control.

A scheduled cloud scan queries the provider each time it runs, so storage accounts and network
security groups added since the last scan are picked up without editing the profile.

The two execution paths differ in where results land, not in what gets checked.
A direct `inspec exec` run prints to your terminal and writes whatever file your
`--reporter` names; a scan job stores results in Chef Automate, with history for each run.

The [Compliance Phase](/client/latest/features/chef_compliance_phase/) is the third
execution path, and it isn't the right one here---it runs profiles during a Chef Infra Client
run on a node, and an Azure subscription has no node to run on.
Use scan jobs for cloud subscriptions, and the Compliance Phase for the virtual machines inside them.

## Where to go next

**Start from a published benchmark instead of your own controls.**
Chef publishes prebuilt audit content built on the CIS Microsoft Azure Foundations
Benchmark---see
[supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms)
to check current coverage before writing your own controls for a
requirement it may already cover.

**Assess the virtual machines as well as the subscription.**
This profile checks the subscription's configuration.
The virtual machines inside it are assessed as hosts---see
[The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
and [Operating Systems](/premium_content/operating_systems/) for the benchmarks Chef
publishes.
Chef Automate can also scan Azure virtual machines through an Azure VM node manager,
described in the [node integrations documentation](/automate/node_integrations/).

**Check other cloud providers or container platforms.**
See [The Chef way of AWS compliance](/solutions/compliance/aws_foundations/),
[The Chef way of GCP compliance](/solutions/compliance/gcp_foundations/),
and [The Chef way of custom compliance checks](/solutions/compliance/extend/)
for the Kubernetes and other resource packs, and how each is added to a profile.

## Related

- [Azure resource pack documentation](/inspec/resource_packs/azure/)
- [Profile dependencies](/inspec/latest/profiles/depends/)
- [Chef InSpec CLI reference](/inspec/latest/reference/cli/)
- [Waivers reference](/inspec/latest/configure/waivers/)
- [Chef Automate node integrations](/automate/node_integrations/)
- [Chef Automate scan jobs](/automate/scan_jobs/)
- [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
- [Cloud benchmark coverage](/premium_content/cloud/)
- [Compliance solution overview](/solutions/compliance/)
