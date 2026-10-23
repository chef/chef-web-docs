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
how to add a resource pack to a profile,
and how custom checks relate to the benchmark coverage in the rest of this section.

If you haven't written a profile before, start with
[Audit SSH configuration across a Linux fleet](/solutions/compliance/ssh_baseline/),
which walks through authoring and running one end to end using core resources.
This page picks up where that leaves off: checking technologies that need a resource pack.

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

## Add a resource pack to a profile

Resource packs are distributed in three ways, and the one you're using
determines how you add it.
Each pack's documentation states which applies.

### Cloud packs: Generate a profile for the platform

The AWS, Azure, and GCP packs are wired up by `inspec init profile`.
Pass `--platform` and you get a profile already configured for that cloud:

```bash
inspec init profile --platform aws my-aws-profile
```

Chef InSpec uses the cloud provider's standard authentication.
For AWS, set credentials as environment variables:

```bash
export AWS_REGION=us-east-1
export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
```

Confirm Chef InSpec can reach the account before you write any controls:

```bash
inspec detect -t aws://
```

```text
== Platform Details
Name: aws
Families: cloud, api
Release: aws-sdk-v2.10.125
```

Then write controls against the pack's resources.
This one checks that a bucket isn't exposed publicly:

```ruby
control 'aws-s3-01' do
  impact 'critical'
  title 'Ensure the audit log bucket is not public'

  describe aws_s3_bucket('audit-logs-example') do
    it { should exist }
    it { should_not be_public }
  end
end
```

Run it against the account rather than a host:

```bash
inspec exec my-aws-profile -t aws://
```

The target is the cloud account, not a machine, so there's nothing to connect to over SSH.
Use an account with read-only permissions ---
for AWS, the managed `ReadOnlyAccess` policy is a reasonable starting point.

### Packs distributed as an archive: Add a `depends` entry

The Kubernetes pack is added as a dependency in `inspec.yml`,
along with the platform it supports:

```yaml
supports:
  platform: k8s
depends:
  - name: inspec-k8s
    url: https://github.com/inspec/inspec-k8s/archive/main.tar.gz
```

Chef InSpec reads your `KUBECONFIG` environment variable or `~/.kube/config`
to find the cluster, then you run against the cluster as the target:

```bash
inspec exec my-k8s-profile -t k8s://
```

### Packs distributed as a gem: Depend on the gem

Starting in Chef InSpec 7, some resources that used to ship in core are released
as separate Ruby gems.
The Docker resources are one example:

```yaml
depends:
  - name: inspec-docker-resources
    gem: inspec-docker-resources
```

If you upgrade to Chef InSpec 7 and controls that used `docker_container`
suddenly fail to resolve, a missing dependency entry like this is the reason.

Check the pack's own documentation for the exact entry to use ---
these three patterns aren't interchangeable.

## Core resources

Core resources cover operating systems, databases, web servers, and host networking,
and they're what most prebuilt benchmark content is built on.
If you're writing checks for a server, a desktop, a web server,
or a relational database, start with core resources rather than a pack.

They need no dependency entry and no credentials beyond access to the target:

```ruby
describe package('openssh-server') do
  it { should be_installed }
end

describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end

describe port(22) do
  it { should be_listening }
end
```

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

- [Audit SSH configuration across a Linux fleet](/solutions/compliance/ssh_baseline/)
- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms)
- [Chef InSpec](/inspec/latest/)
- [Chef Workstation](/workstation/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
