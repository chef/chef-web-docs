+++
title = "Build custom compliance checks with Chef InSpec"

[menu.overview]
  identifier = "overview/solutions/compliance/extend"
  parent = "overview/solutions/compliance"
  title = "Build custom checks"
  weight = 100
+++

Chef publishes prebuilt audit and remediation content for a wide range of
compliance benchmarks.
When your requirement falls outside that content ---
a technology with no published benchmark,
or a control specific to your organization ---
you can write your own checks with Chef InSpec.

This page explains what you build those checks from,
and how custom checks relate to the benchmark coverage in the rest of this section.

## Choose between prebuilt content and custom checks

Both approaches produce Chef InSpec controls that run and report the same way.
They differ in who writes and maintains the content.

| | Use prebuilt benchmark content | Write custom checks |
| --- | --- | --- |
| **Fits when** | Your requirement maps to a published benchmark Chef covers | No published benchmark covers your requirement, or the requirement is specific to your organization |
| **Content comes from** | Chef, built on CIS Benchmarks and DISA STIGs | You |
| **Maintenance** | Chef updates content as benchmarks are revised | You maintain it as your requirements change |
| **Starting point** | [Supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms) | Chef InSpec resources, described below |

The two work together.
Many teams run prebuilt benchmark content for their baseline
and add custom checks for requirements the benchmark doesn't address.

## Resources and resource packs

A **resource** is the building block of a Chef InSpec control.
Each resource knows how to inspect one kind of thing ---
a file, a package, a running service, a database query, or a cloud API object ---
and exposes properties you write expectations against.

Chef InSpec includes a large set of **core resources** covering operating systems,
databases, web servers, and host networking.
Core resources are available in every profile without any extra setup.

A **resource pack** is a separately distributed set of resources for a specific technology.
You add a resource pack to a profile as a dependency,
and its resources then become available to your controls.

### Resource packs aren't benchmarks

A resource pack gives you the means to inspect a technology.
It doesn't assess anything on its own,
and it makes no assertion that any benchmark, control,
or regulatory requirement is satisfied.

The availability of a resource pack for a technology
**doesn't indicate that Chef publishes benchmark coverage for it**,
and the absence of a pack doesn't indicate that a technology can't be assessed.
These are independent:

- Some technologies have prebuilt benchmark content and no resource pack.
  Operating systems are the largest example, and they rely on core resources.
- Some technologies have a resource pack and no prebuilt benchmark content.
- Some have both.

To see what Chef covers with prebuilt content, use
[supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms).
Treat that catalog, not this page, as the statement of benchmark coverage.

## Available resource packs

| Resource pack | What you can inspect |
| --- | --- |
| [AWS](/inspec/resource_packs/aws/) | EC2, IAM, RDS, Lambda, VPC and networking, CloudFront, CloudWatch, SSM, WAF, and API Gateway |
| [Azure](/inspec/resource_packs/azure/) | Virtual machines, SQL, networking, Key Vault, policy and resource groups, Active Directory, and MySQL |
| [GCP](/inspec/resource_packs/gcp/) | Compute Engine, Cloud SQL, Cloud Storage, GKE, IAM, KMS, Logging, Pub/Sub, and Vertex AI |
| [Kubernetes](/inspec/resource_packs/k8s/) | Pods, containers, deployments, DaemonSets, CronJobs, namespaces, nodes, ConfigMaps, network policies, and RBAC cluster roles |
| [Docker](/inspec/resource_packs/docker/) | Containers, images, services, and plugins |
| [Podman](/inspec/resource_packs/podman/) | Containers, images, networks, volumes, and pods |
| [MongoDB](/inspec/resource_packs/mongodb/) | MongoDB configuration, and queries against a running instance |
| [Elasticsearch](/inspec/resource_packs/elasticsearch/) | Elasticsearch configuration |
| [RabbitMQ](/inspec/resource_packs/rabbitmq/) | RabbitMQ configuration |
| [Habitat](/inspec/resource_packs/habitat/) | Habitat packages and services |

Each pack's documentation lists the individual resources it provides,
with the properties and matchers available on each.

Pack depth varies.
Some packs cover a technology broadly,
and others provide a small number of resources for specific configuration.
Check the pack's documentation for the resources you need
before you plan work around it.

## Use a resource pack in a profile

To use a resource pack, add it as a dependency in your profile's `inspec.yml`,
then write controls against the resources it provides.
Each pack's documentation gives the exact dependency entry to use.

As of Chef InSpec 7, some packs are distributed as separate Ruby gems.
The Docker resource pack, for example, is distributed as `inspec-docker-resources`.

Resource packs that inspect a remote API, such as the cloud packs,
need credentials for the account or subscription you're assessing.
The pack's documentation describes what it expects.

For profile structure, dependencies, and authoring syntax, see the
[Chef InSpec documentation](/inspec/latest/).

## Core resources

Core resources cover operating systems, databases, web servers, and host networking,
and they're what most prebuilt benchmark content is built on.
If you're writing checks for a server, a desktop, a web server,
or a relational database, start with core resources rather than a pack.

For the full list, see the
[Chef InSpec resource documentation](/inspec/latest/resources/).

## What to know before you start

- **Custom checks are content you own.**
  Controls you write are maintained by you, not by Chef,
  and aren't covered by Chef's benchmark content updates.
- **Benchmark coverage is stated in the catalog.**
  A resource pack existing for a technology isn't a statement of benchmark coverage.
- **Test before you rely on results.**
  Develop and test custom controls with
  [Chef Workstation](/workstation/latest/) before you run them against production systems.
- **Custom checks report the same way.**
  Controls you write produce the same pass, fail, and skip results as prebuilt content,
  and report to Chef Automate through the same paths described in
  [compliance audit](/solutions/compliance/#compliance-audit).

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms)
- [Chef InSpec](/inspec/latest/)
- [Chef Workstation](/workstation/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
