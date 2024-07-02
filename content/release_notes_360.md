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

## Chef 360 Platform 1.0

### Release details

- Version number: 1.0
- Release date: 2 July, 2024

### Overview

This is the initial release of Progress Chef 360 platform. Chef Platform is a set of integrated software components and a surrounding ecosystem where value comes not only from individual features but from its ability to connect external tools, teams, data, and processes. We see Chef 360 platform as a way to take the power and benefits of policy as code and spread it to everyone who has a role in development, operations and security. In addition to that Chef 360 platform is an integrated ecosystem of tools providing not just value but also its ability to connect teams and tools together. It is a modern, cloud-native DevOps platform that democratizes DevOps by empowering IT operators and DevOps engineers to manage mission-critical infrastructure securely.

When we set out to build a new platform we identified four primary guiding principles, used to help us make the right choices and stay aligned with our objectives.

- Automate everything (within reason), by providing you prescriptive ways to use the platform, while still retaining our core flexibility.
- Reach everywhere, be that your data center, a cloud, a laptop, single board computer or even a satellite. We want to support you everywhere you are running a workload.
- Embrace all users and skill levels. So we are making this platform not just with APIs and CLIs for automation but also with an intuitive UI.
- Embrace open standards. This means you get open interoperability to OpenAPI v3 services, cloud-native benefits by starting in Kubernetes at Chef 360's inception, and other security standards to make acceptance and adoption easy.

Chef 360 Platform contains a host of services on which new products from Chef are being built. Progress Chef Courier is one such product. This release also is the initial release of Progress Chef Courier product.

Chef Courier is an enterprise job orchestration and automation platform that allows you to perform any action over your IT fleet with immense flexibility. With this flexibility you can now use Chef Courier to perform any actions (**Whatever**) on any target (**Wherever**) in your IT fleet at any time, immediate, scheduled or otherwise (**Whenever**).

This functionality empowers practitioners to execute ad hoc and unplanned duties without having to create bespoke solutions, especially during critical incidents. When such routine but complex tasks are automated, you will realize a significant reduction in time and effort to manage your IT fleet. Courier provides you with more resilience and efficiency by easily integrating with pre-existing infrastructure management technologies.

### Major services

Chef 360 platform comes packaged with the following major categories of services. Each of these categories serves a very specific purpose in enabling the end-to-end functioning of every product made accessible through the Chef 360 platform.

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
- Use one of the command-line interfaces (CLIs) to interact with the complete Chef 360 platform.
- Try the user experience (UI) to visualize results and model new queries.

### Supported platforms

1. The Chef-360 Platform is a set of containers which run on standard Kubernetes environments. Most containers are 'scratch' containers and run on the default pod provided by the host. Some containers are on Debian base images. The Chef-360 Platform v1.0 release is packaged inside and is tested on a `k0s` distribution.
1. The Chef-360 platform has three command-line interfaces which run on versions of Linux, Microsoft Windows, and MacOS on x86 or ARM architectures (as appropriate). These are available in the bundled tools container in the Chef-360 Platform distribution.
1. The Chef-360 platform has three agents: the Habitat base module, a Node Management agent, and a Courier agent. The Habitat installer runs on all platforms indicated on the [Chef Habitat downloads page](https://community.chef.io/downloads/tools/habitat) (or your support portal if you have a commercial Chef license). We tested with the latest version of Habitat for this release. The agents are available in the bundled tools container in the Chef-360 Platform distribution.
1. Chef-360 Platform relies on the following infrastructure components for its services:

    - Postgres v16.1
    - MinIO v2023.11.20
    - RabbitMQ v3.12.10
    - NGINX v1.25.4
    - Mailhog v1.0.1 (optional)

1. All open-source licenses used within Chef-360 Platform are cited in the `NOTICES.TXT` file accompanying each binary, including the command-lines.

### Known issues

We have tested on the supported platforms listed above and intend on broadening this support in upcoming releases. Chef-360 Platform may operate correctly on other platforms; we just cannot guarantee it. Contact your customer success team with questions.

Chef 360 1.0 has the following known issues:

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
