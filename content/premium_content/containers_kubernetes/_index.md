+++
title = "Containers"
aliases = ["/solutions/compliance/containers_kubernetes/"]

[menu.premium_content]
  identifier = "premium_content/containers_kubernetes"
  parent = "premium_content"
  title = "Containers"
  weight = 70
+++

Chef Premium Content has current coverage for **1 container benchmark**,
with every audit version and remediation version currently available.
See [benchmark coverage](/premium_content/#benchmark-coverage) for how audit and
remediation coverage are tracked, and the
[Compliance solution overview](/solutions/compliance/) for what each does.

## Browse by platform

Platform pages describe what the benchmarks cover, which profiles ship, and what
remediation is available:

| Platform | Benchmarks |
| --- | --- |
| [Docker](/premium_content/containers_kubernetes/docker/) | CIS |

## All container benchmarks

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Docker` | v2.1.0 | — | Audit Only |

For what each coverage term means, see
[how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables).

## Inspect container platforms directly

For requirements that the benchmarks above don't cover,
Chef InSpec provides resource packs you can use to write your own controls:

- [Kubernetes resource pack](/inspec/resource_packs/k8s/) ---
  inspect pods, containers, deployments, DaemonSets, CronJobs, namespaces, nodes,
  ConfigMaps, network policies, and RBAC cluster roles
- [Docker resource pack](/inspec/resource_packs/docker/) ---
  inspect containers, images, services, and plugins
- [Podman resource pack](/inspec/resource_packs/podman/) ---
  inspect containers, images, networks, volumes, and pods

Chef doesn't publish a prebuilt compliance benchmark for Podman.

A resource pack isn't a benchmark and doesn't assess anything on its own.
It provides the resources you use to write your own controls.

## Related

- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
