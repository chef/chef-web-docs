+++
title = "Progress Chef 360 Platform & Progress Chef Courier release notes"
draft = false

product = [""]

[menu]
  [menu.release_notes]
    title = "Chef 360 Platform"
    identifier = "release_notes/release_notes.md Chef 360 Platform"
    parent = "release_notes"
    weight = 10
+++

## Chef 360 Platform 1.1

### New features

- RabbitMQ used for Chef Courier jobs now supports TLS-based communication.

- We added the following system-defined roles:

  - Tenant Admin
  - Organization Admin
  - Node Manager
  - Courier Operator

  Users with these roles can perform tenant management, organization management, node management, and Courier-specific actions.
  You can also use these roles as a reference for creating custom roles and policies based on business needs of your organization.

  See the [System roles](https://docs.chef.io/360/1.1/administration/system_roles) and [System policies](https://docs.chef.io/360/1.1/administration/system_policies) documentation for more information.

- Added UI workflows to perform basic Courier job runs, manage nodes and filters and perform administrative actions. See the [Chef 360 Platform UI documentation](https://docs.chef.io/360/1.1/chef_360_ui) for more information.

- Chef 360 Platform now requires users to load their license keys. Users can run Chef Courier jobs until the license expiration date, after which users must renew their license keys to continue running Courier jobs.

### Improvements

- Upgraded nginx to 1.26.2 to address the following CVEs:

  - CVE-2024-32760
  - CVE-2024-31079
  - CVE-2024-35200
  - CVE-2024-34161

- Added an API to fetch global default settings.
- You can now modify the number of Replicas for each service when deploying Chef 360 Platform. See the [install documentation](https://docs.chef.io/360/1.1/install/server/install#replicas-count) for more information.

### Bug fixes

- You can now redeploy Chef 360 Platform with updated configurations.
- When downloading details of a job, the artifact URL is updated to HTTP or HTTPS dynamically in the artifact URL string based on the server configuration.
- The payload for filtering by the enrollment level and health status attributes is now supported with operator and value fields similar to filtering by other attributes.

  This change requires that all users running Chef 360 Platform 1.0.x must upgrade their skill versions on all nodes to versions supported in the Chef 360 Platform 1.1.
  The previous release versions of these skills won't run if they're not updated.

### Supported skill versions

| Skill                    | Skill name                | Habitat package                                                                                               | Version  |
| -------------------------|---------------------------|---------------------------------------------------------------------------------------------------------------|----------|
| Node Management Agent    | `node-management-agent`   | [chef-platform/node-management-agent](https://bldr.habitat.sh/#/pkgs/chef-platform/node-management-agent)     | 1.0.3    |
| Courier Runner           | `courier-runner`          | [chef-platform/courier-runner](https://bldr.habitat.sh/#/pkgs/chef-platform/courier-runner)                   | 1.4.4    |
| Gohai                    | `chef-gohai`              | [chef-platform/chef-gohai](https://bldr.habitat.sh/#/pkgs/chef-platform/chef-gohai)                           | 1.0.3    |
| Shell Interpreter        | `shell-interpreter`       | [chef-platform/shell-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/shell-interpreter)             | 1.0.3    |
| Restart Interpreter      | `restart-interpreter`     | [chef-platform/restart-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/restart-interpreter)         | 1.0.2   |
| Infra Client Interpreter | `chef-client-interpreter` | [chef-platform/chef-client-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/chef-client-interpreter) | 1.0.4    |
| Inspec Interpreter       | `inspec-interpreter`      | [chef-platform/inspec-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/inspec-interpreter)           | 1.0.4    |

### Known issues

- Re-enrolling a node that's already enrolled to the same organization or a different organization isn't currently supported.
  A node must be unenrolled manually if you want to re-enroll.
- Evidence (log) files are downloaded without the `.zip` extension from the run details screen.

## Chef 360 Platform 1.0.2

### Release details

- Version number: 1.0.2
- Release date: July 22, 2024

### Bug fixes

- The `chef-courier-cli state run list-steps` command now lists all job instance steps.
- The Shell Interpreter now correctly shows steps that failed on Windows nodes.
- The `chef-platform-auth-cli user-account self get-role` now correctly lists HTTP verbs (for example `GET` or `POST`) in its response.

### Supported skill versions

| Skill                    | Skill name                | Habitat package                                                                                               | Version  |
| -------------------------|---------------------------|---------------------------------------------------------------------------------------------------------------|----------|
| Node Management Agent    | `node-management-agent`   | [chef-platform/node-management-agent](https://bldr.habitat.sh/#/pkgs/chef-platform/node-management-agent)     | 1.0.1    |
| Courier Runner           | `courier-runner`          | [chef-platform/courier-runner](https://bldr.habitat.sh/#/pkgs/chef-platform/courier-runner)                   | 1.4.2    |
| Gohai                    | `chef-gohai`              | [chef-platform/chef-gohai](https://bldr.habitat.sh/#/pkgs/chef-platform/chef-gohai)                           | 1.0.1    |
| Shell Interpreter        | `shell-interpreter`       | [chef-platform/shell-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/shell-interpreter)             | 1.0.2    |
| Restart Interpreter      | `restart-interpreter`     | [chef-platform/restart-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/restart-interpreter)         | 1.0.1    |
| Infra Client Interpreter | `chef-client-interpreter` | [chef-platform/chef-client-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/chef-client-interpreter) | 1.0.3    |
| Inspec Interpreter       | `inspec-interpreter`      | [chef-platform/inspec-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/inspec-interpreter)           | 1.0.3    |

## Chef 360 Platform 1.0.1

### Release details

- Version number: 1.0.1
- Release date: July 15, 2024

### Improvements

- In the previous release, you could not add more than one user-defined policy to a custom role.
  You can now create custom roles with multiple policies with a single command.
- The Courier Orchestrator service is now multi-threaded so that it can send multiple Courier jobs that are scheduled simultaneously.
- We improved Chef 360 Platform enrollment failure messages so that they now show appropriate error messages for all stages of enrollment.
- Upgraded Go to v1.22.5 in Chef 360 Platform Auth services and license services.

### Bug fixes

- You can now delete tags applied to nodes.
- Chef 360 Platform now gives the correct health status for nodes with a large check-in interval.
- You can now install Chef 360 Platform with a custom certificate.

### Supported skill versions

| Skill                    | Skill name                | Habitat package                                                                                               | Version  |
| -------------------------|---------------------------|---------------------------------------------------------------------------------------------------------------|----------|
| Node Management Agent    | `node-management-agent`   | [chef-platform/node-management-agent](https://bldr.habitat.sh/#/pkgs/chef-platform/node-management-agent)     | 1.0.1    |
| Courier Runner           | `courier-runner`          | [chef-platform/courier-runner](https://bldr.habitat.sh/#/pkgs/chef-platform/courier-runner)                   | 1.4.1    |
| Gohai                    | `chef-gohai`              | [chef-platform/chef-gohai](https://bldr.habitat.sh/#/pkgs/chef-platform/chef-gohai)                           | 1.0.1    |
| Shell Interpreter        | `shell-interpreter`       | [chef-platform/shell-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/shell-interpreter)             | 1.0.1    |
| Restart Interpreter      | `restart-interpreter`     | [chef-platform/restart-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/restart-interpreter)         | 1.0.1    |
| Infra Client Interpreter | `chef-client-interpreter` | [chef-platform/chef-client-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/chef-client-interpreter) | 1.0.2    |
| Inspec Interpreter       | `inspec-interpreter`      | [chef-platform/inspec-interpreter](https://bldr.habitat.sh/#/pkgs/chef-platform/inspec-interpreter)           | 1.0.2    |

## Chef 360 Platform 1.0.0

### Release details

- Version number: 1.0.0
- Release date: July 2, 2024

### Overview

This is the initial release of Progress Chef 360 Platform. Chef 360 Platform is a set of integrated software components and a surrounding ecosystem where value comes not only from individual features but from its ability to connect external tools, teams, data, and processes. We see Chef 360 Platform as a way to take the power and benefits of policy as code and spread it to everyone who has a role in development, operations and security. In addition to that Chef 360 Platform is an integrated ecosystem of tools providing not just value but also its ability to connect teams and tools together. It is a modern, cloud-native DevOps platform that democratizes DevOps by empowering IT operators and DevOps engineers to manage mission-critical infrastructure securely.

When we set out to build a new platform we identified four primary guiding principles, used to help us make the right choices and stay aligned with our objectives.

- Automate everything (within reason), by providing you prescriptive ways to use the platform, while still retaining our core flexibility.
- Reach everywhere, be that your data center, a cloud, a laptop, single board computer or even a satellite. We want to support you everywhere you are running a workload.
- Embrace all users and skill levels. So we are making this platform not just with APIs and CLIs for automation but also with an intuitive UI.
- Embrace open standards. This means you get open interoperability to OpenAPI v3 services, cloud-native benefits by starting in Kubernetes at Chef 360's inception, and other security standards to make acceptance and adoption easy.

Chef 360 Platform contains a host of services on which new products from Chef are being built. Progress Chef Courier is one such product. This release also is the initial release of Progress Chef Courier product.

Chef Courier is an enterprise job orchestration and automation platform that allows you to perform any action over your IT fleet with immense flexibility. With this flexibility you can now use Chef Courier to perform any actions (**Whatever**) on any target (**Wherever**) in your IT fleet at any time, immediate, scheduled or otherwise (**Whenever**).

This functionality empowers practitioners to execute ad hoc and unplanned duties without having to create bespoke solutions, especially during critical incidents. When such routine but complex tasks are automated, you will realize a significant reduction in time and effort to manage your IT fleet. Courier provides you with more resilience and efficiency by easily integrating with pre-existing infrastructure management technologies.

### Major services

Chef 360 Platform comes packaged with the following major categories of services. Each of these categories serves a very specific purpose in enabling the end-to-end functioning of every product made accessible through the Chef 360 Platform.

- Courier including services for scheduling, orchestrating, delivering and tracking state for jobs
- Node management including centralized services and enrollment
- Core Chef platform services including authorization, user and organizations management, secrets management, notifications and an API gateway
- Licensing & telemetry services
- User experience (UI) and command line interfaces (CLIs)
- Agents with multiple skills including courier, node management, an OS shell interpreter, the Chef Infra interpreter, an InSpec interpreter and a machine restart interpreter

### Highlighted features

Node Management:

- Provides a single pane of glass to manage all the nodes in your infrastructure fleet.
- Centralized enrollment of nodes and distribution of 'skills' helps bootstrap and upgrade Chef agents easily.
- Maintain and search across your fleet of nodes using tags, node lists and filters.

Courier Jobs:

- Perform infrastructure management and compliance actions on enrolled nodes immediately or scheduled for later.
- Orchestrate change rollout by controlling the number of nodes impacted and target specific nodes in a static or dynamically filtered list.
- Track output artifacts and status of jobs performed on nodes, centrally and in real time.

User management:

- Compartmentalize and catalog your enterprise DevOps using tenants and organizational units.
- Customizable roles and policies for groups and individual users permit fine grain access control.

Interface-driven

- Use rich APIs to automate any action against secure, authenticated endpoints.
- Use one of the command-line interfaces (CLIs) to interact with the complete Chef 360 Platform.
- Try the user experience (UI) to visualize results and model new queries.

### Supported platforms

1. The Chef 360 Platform is a set of containers which run on standard Kubernetes environments. Most containers are 'scratch' containers and run on the default pod provided by the host. Some containers are on Debian base images. The Chef 360 Platform v1.0 release is packaged inside and is tested on a `k0s` distribution.
1. The Chef 360 Platform has three command-line interfaces which run on versions of Linux, Microsoft Windows, and MacOS on x86 or ARM architectures (as appropriate). These are available in the bundled tools container in the Chef 360 Platform distribution.
1. The Chef 360 Platform has three agents: the Habitat base module, a Node Management agent, and a Courier agent. The Habitat installer runs on all platforms indicated on the [Chef Habitat downloads page](https://community.chef.io/downloads/tools/habitat) (or your support portal if you have a commercial Chef license). We tested with the latest version of Habitat for this release. The agents are available in the bundled tools container in the Chef 360 Platform distribution.
1. Chef 360 Platform relies on the following infrastructure components for its services:

    - Postgres v16.1
    - MinIO v2023.11.20
    - RabbitMQ v3.12.10
    - NGINX v1.25.4
    - Mailhog v1.0.1 (optional)

1. All open-source licenses used within Chef 360 Platform are cited in the `NOTICES.TXT` file accompanying each binary, including the command-lines.

### Supported skill versions

| Skill                    |  Habitat package                      | Version |
|------------------------- | --------------------------------------|---------|
| Node Management Agent    | chef-platform/node-management-agent   | 1.0.0   |
| Courier Runner           | chef-platform/courier-runner          | 1.4.0   |
| Gohai                    | chef-platform/chef-gohai              | 1.0.0   |
| Shell Interpreter        | chef-platform/shell-interpreter       | 1.0.0   |
| Restart Interpreter      | chef-platform/restart-interpreter     | 1.0.0   |
| Infra Client Interpreter | chef-platform/chef-client-interpreter | 1.0.0   |
| Inspec Interpreter       | chef-platform/inspec-interpreter      | 1.0.0   |

### Known issues

We have tested on the supported platforms listed above and intend on broadening this support in upcoming releases. Chef 360 Platform may operate correctly on other platforms; we just cannot guarantee it. Contact your customer success team with questions.

Chef 360 Platform has the following known issues:

- The Chef 360 Platform is not yet supported for environments which cannot access the internet, that is, air gapped environments.
- Don't create a tenant name with the underscore character `_`, services will fail to start.
- Don't change or modify the underlying Kubernetes configuration after installing v1.0; upgrades are not yet supported.
- Upgrades to v1.0 are manual; automatic upgrades are not supported.
- The message queues internally for Chef Courier job distribution and node enrollment do not support TLS.
- Chef 360 Platform services do not work correctly on nodes using localhost DNS settings (`127.0.0.1`).
- Some Courier jobs run to completion---success or failure---and may not be cancellable. Additionally, if a Linux shell job is specified for a Windows node (or vice-versa), it should be manually verified as working since some scripts may have 3rd party dependencies on a given platform.
- Several features including node filters and exemptions, un-enrolling and re-enrolling a node, and multi-node deployment under development and will be available in a subsequent release.
- The user experience (UI) is experimental and being updated frequently now so some users of the distribution channel and containers may see improvements and screen changes between operations.

Many more feature sets are planned for upcoming releases. Contact your customer success team for more information about the roadmap!

### Contributors

The Progress Chef team would like to thank all the early access users and DevOps engineers in the community and at our customers for their involvement throughout the Progress Chef Customer Validation program. Without this engagement, scenario testing and direct feedback, Courier would not have been able to reach this point so quickly. Thank you.
