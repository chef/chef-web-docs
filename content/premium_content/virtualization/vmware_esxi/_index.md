+++
title = "VMware ESXi"

[menu.premium_content]
  identifier = "premium_content/virtualization/vmware_esxi"
  parent = "premium_content/virtualization"
  title = "VMware ESXi"
  weight = 10
+++

VMware ESXi hosts run the virtual machines that many other workloads depend on, so a weak host or VM setting can affect everything above it.

Chef Premium Content covers VMware ESXi against the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks).
Audit content for ESXi works differently from most Chef Premium Content, because it ships as scan cookbooks that you run from a Chef Infra Client node.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS VMware ESXi 6.5` | --- | v1.0.0 | Remediation Only |
| `CIS VMware ESXi 7.0` | v1.3.0 | --- | Audit Only |
| `CIS VMware ESXi 8.0` | v1.1.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available scan cookbooks

Each audit version ships as one cookbook that contains its own Chef InSpec profiles.
The cookbooks don't have level variants, and what they scan depends on the benchmark:

| Benchmark | Cookbook | Scans |
| --- | --- | --- |
| `CIS VMware ESXi 7.0` | `cis_vmware_esxi_7_0_scan_v1.3.0` | ESXi hosts, VMs, and distributed networks |
| `CIS VMware ESXi 8.0` | `cis_vmware_esxi_8_0_scan_v1.1.0` | ESXi hosts and VMs |

The cookbooks have the following requirements:

- The ESXi 7.0 cookbook requires Chef Infra Client 15.0 or later.
- The ESXi 8.0 cookbook requires Chef Infra Client 18.0 or later.
- Both cookbooks require `rbvmomi` version 2.2.0.

## What you can do with this content

### Audit

The cookbook runs on a Chef Infra Client node, which acts as the scanner.
It connects to each vCenter Server you configure, finds the ESXi hosts and VMs, and scans them in batches.

To configure the scan, create a `vmware_scan_config.yaml` file in your Chef configuration directory, which is usually `/etc/chef` on Linux and `c:\chef` on Windows.
The file uses the following settings:

| Setting | Purpose |
| --- | --- |
| `credentials` | Named sets of vCenter Server usernames and passwords |
| `servers` | The vCenter Server systems to scan, and the credential set for each |
| `minimum_rescan_seconds` | How long to wait before scanning the same object again |
| `vm_batch_size`, `host_batch_size`, `network_batch_size` | How many objects of each type to scan in a Chef Infra Client run |
| `waiverfiles` | Optional paths to [Chef InSpec waiver files](/inspec/latest/configure/waivers/) for VMs, hosts, and networks |

The file holds credentials, so restrict who can read it.

### Report results

The cookbook sends each report through Chef Infra Server to the data collector, so the node needs a Chef Infra Server connection.
See [Chef Automate data collection](/automate/data_collection/) to set up data collection, and [compliance reporting in Chef Automate](/automate/reports/) to view the results.

### Detect drift

An ESXi host or VM that passed an audit doesn't stay compliant on its own.
Upgrades and manual changes in vCenter Server can all move it away from its approved state.
Each Chef Infra Client run scans the next batch, so scheduled runs repeat the assessment across your environment and show how results change over time.

## Remediation

ESXi 7.0 and ESXi 8.0 are audit only.
You can assess those systems and act on the findings, but matching remediation content isn't available.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Virtualization coverage](/premium_content/virtualization/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef Infra cookbooks](/client/latest/cookbooks/)
- [Compliance reporting in Chef Automate](/automate/reports/)
