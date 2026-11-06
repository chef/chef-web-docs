+++
title = "Docker"

[menu.premium_content]
  identifier = "premium_content/containers_kubernetes/docker"
  parent = "premium_content/containers_kubernetes"
  title = "Docker"
  weight = 10
+++

Docker hosts run many containers on a shared kernel, so a weak daemon or host setting can affect every workload on the system.

Chef Premium Content covers Docker against the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks), so you can assess Docker without writing and maintaining that content yourself.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Docker` | v2.1.0 | --- | Audit Only |

See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

The benchmark ships as one Chef InSpec profile, `cis-docker-benchmark`, at benchmark v2.1.0.

## What you can do with this content

### Audit

Run the audit profile with [Chef InSpec](/inspec/latest/) to assess Docker against the benchmark and report which requirements pass and which fail.

### Detect drift

A Docker host that passed an audit doesn't stay compliant on its own, because upgrades and configuration changes can move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence.

## Remediation

CIS Docker is audit only.
You can assess Docker and act on the findings, but matching remediation content isn't available, so plan to correct failed requirements with your own tooling.

## Write your own Docker checks

For checks that the benchmark doesn't cover, you can write your own controls with the [Docker resource pack](/inspec/resource_packs/docker/).
A resource pack isn't a benchmark and doesn't assess anything on its own.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Containers coverage](/premium_content/containers_kubernetes/)
- [Docker resource pack](/inspec/resource_packs/docker/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
