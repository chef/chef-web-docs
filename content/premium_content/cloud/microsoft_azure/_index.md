+++
title = "Microsoft Azure"

[menu.premium_content]
  identifier = "premium_content/cloud/microsoft_azure"
  parent = "premium_content/cloud"
  title = "Microsoft Azure"
  weight = 10
+++

The CIS Azure Foundations Benchmark from the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) defines secure configuration requirements for an Azure environment.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.
This content assesses your environment through the Azure APIs, rather than the configuration of a single host.

## What the benchmarks check

The requirements cover the following areas at v1.1.0:

- **Identity and access:** Multi-factor authentication, application consent, and custom roles
- **Security Center:** Default monitoring policies and security contact notifications
- **Storage accounts:** Secure transfer, shared access signatures, and storage logging
- **Database services:** SQL Server auditing, data encryption, and PostgreSQL logging
- **Logging and monitoring:** Activity Log retention and alerts
- **Networking:** RDP, SSH, and SQL access from the internet, and Network Watcher
- **Virtual machines:** Disk encryption and endpoint protection
- **Other security:** Key and secret expiration, recoverable key vaults, and resource locks
- **App Service:** TLS and runtime versions for web applications

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Microsoft Azure Foundations` | v1.0.0, v1.1.0 | v1.1.0 | Partial Audit + Remediation |

See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

The profiles available depend on the benchmark version:

| Benchmark version | Chef InSpec profiles |
| --- | --- |
| v1.0.0 | `cis-azure-foundations` |
| v1.1.0 | `cis-azure-foundations-level1-v1.1.0`, `cis-azure-foundations-level2-v1.1.0` |

Benchmark v1.0.0 ships as one profile with no separate levels.
For benchmark v1.1.0, choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments, and might affect how services behave.

## What you can do with this content

### Audit

Run the audit profile with [Chef InSpec](/inspec/latest/) to assess your Azure environment against the benchmark and report which requirements pass and which fail.
The profiles depend on the Chef InSpec Azure resources, so see the [Azure resource pack](/inspec/resource_packs/azure/) for what they inspect.

### Harden

Remediation content is available for benchmark v1.1.0, so you can correct the settings behind a failed requirement rather than writing the fix yourself.

### Detect drift

An Azure environment that passed an audit doesn't stay compliant on its own, because portal changes and new deployments can move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence.

## Remediation

Remediation content is delivered as a [Chef Infra cookbook](/client/latest/cookbooks/) that corrects the settings behind a failed benchmark requirement.

Some controls need values that only you can provide, which you set as environment variables before you run the cookbook.
These include your security contact details, storage account details, SQL Server settings, and log and key retention settings.
The cookbook's README lists the variable for each control, for example `AZURE_SECURITY_CONTACT_EMAIL` for controls 2.16 through 2.19.

Check the version table before you plan a hardening rollout, because remediation and audit versions don't fully line up:

- **Benchmark v1.1.0** has matching audit and remediation content.
- **Benchmark v1.0.0** is audit only.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Cloud coverage](/premium_content/cloud/)
- [Azure resource pack](/inspec/resource_packs/azure/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
