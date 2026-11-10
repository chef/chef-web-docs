+++
title = "Cisco IOS"

[menu.premium_content]
  identifier = "premium_content/network_infrastructure/cisco_ios"
  parent = "premium_content/network_infrastructure"
  title = "Cisco IOS"
  weight = 10
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for Cisco IOS define secure configuration requirements for IOS 12 and IOS 15 devices.
Chef Premium Content provides these requirements as Chef InSpec audit profiles, without remediation content.

## What the benchmarks check

The requirements cover the following areas in the Cisco IOS 15 benchmark at v4.0.0:

- **Management plane:** AAA, session timeouts, and SNMP
- **Control plane:** The hostname, unused services such as BOOTP, logging, and NTP authentication
- **Data plane:** Source routing, interface access groups, and routing protocol authentication

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Cisco IOS 12` | v4.0.0 | --- | Audit Only |
| `CIS Cisco IOS 15` | v4.0.0 | --- | Audit Only |

See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

Each benchmark ships as two Chef InSpec profiles, one for each CIS profile level:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| IOS release | `12`, `15` |

```text
cis-ciscoios<ios-release>-<level>-v4.0.0
```

For example, the CIS Level 1 profile for Cisco IOS 15 is `cis-ciscoios15-level1-v4.0.0`.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments, and is more likely to affect how the device behaves.

## What you can do with this content

### Audit

Run the audit profile with [Chef InSpec](/inspec/latest/) to assess a device against the benchmark and report which requirements pass and which fail.
The profiles check the device's running configuration and the output of IOS commands, using resources from the `inspec-cisco` dependency.

### Detect drift

A device that passed an audit doesn't stay compliant on its own, because configuration changes and software upgrades can move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence.

## Remediation

Cisco IOS 12 and Cisco IOS 15 are audit only.
You can assess devices and act on the findings, but matching remediation content isn't available, so plan to correct failed requirements with your own tooling.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Network / infrastructure coverage](/premium_content/network_infrastructure/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
