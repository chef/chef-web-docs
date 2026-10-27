+++
title = "Containers / Kubernetes"
aliases = ["/solutions/compliance/containers_kubernetes/"]

[menu.premium_content]
  identifier = "premium_content/containers_kubernetes"
  parent = "premium_content"
  title = "Containers / Kubernetes"
  weight = 70
+++

Chef Premium Content has current coverage for **2 containers / kubernetes benchmarks**,
with every audit version and remediation version currently available.
See [benchmark coverage](/premium_content/#benchmark-coverage) for how audit and
remediation coverage are tracked, and the
[Compliance solution overview](/solutions/compliance/) for what each does.

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Docker` | — | v1.1.0 | Remediation Only |
| `CIS Kubernetes` | — | v1.5.0, v1.6.1, v1.12.0 | Remediation Only |

For what each coverage term means, see
[how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables).

## Inspect container platforms directly

Chef doesn't publish prebuilt audit content for the benchmarks above,
but Chef InSpec provides resource packs you can use to write your own controls:

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
- [Build custom compliance checks with Chef InSpec](/solutions/compliance/extend/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
