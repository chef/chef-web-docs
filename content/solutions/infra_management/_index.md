+++
title = "Chef Configuration Management"
draft = false
gh_repo = "chef-web-docs"

[cascade]
  [cascade.params]
    swiftype_search_products = ["client", "workstation", "automate"]
    section_root = "/solutions/infra_management"
    breadcrumbs = true

[menu.overview]
  identifier = "overview/solutions/infra_management/overview"
  parent = "overview/solutions/infra_management"
  title = "Overview"
  weight = 1
+++

Chef Configuration Management configures servers and other systems from code with Chef Infra.
You describe packages, files, services, users, and other settings in [cookbooks](/client/latest/cookbooks/),
and [Chef Infra Client](/client/latest/) applies that state to each system, changing only what doesn't match.

Start here:

- **New to Chef Infra?**
  The [Chef Infra quickstart guide](/client/latest/quickstart/) writes one recipe and runs it in local mode.
- **Writing your first cookbook?**
  [Get started with Chef Workstation](/workstation/latest/get_started/) generates a cookbook,
  adds a Chef InSpec test, and converges it with Test Kitchen.
  For a multi-recipe cookbook tested on more than one platform, follow the
  [Test Kitchen getting started tutorial](https://kitchen.ci/docs/getting-started/introduction/).
- **Already using another Chef product?**
  See [Use Chef Infra with other Chef products](#use-chef-infra-with-other-chef-products).

## How Chef Infra works

| Component | Role |
| --- | --- |
| [Chef Workstation](/workstation/latest/) | Generate, lint, and test cookbooks before they reach a managed system |
| [Cookbook](/client/latest/cookbooks/) | Recipes, attributes, files, templates, and custom resources that describe a configuration |
| [Policyfile](/client/latest/policy/policyfile/) or [run-list](/client/latest/policy/run_lists/) | Selects the cookbooks and recipes each node runs |
| [Chef Infra Client](/client/latest/) | Runs on each node and applies the cookbooks selected for it |
| [Chef 360 Platform Declarative State Management (DSM)](/360/latest/understand/dsm/) or [Chef Infra Server](/server/) | Stores cookbooks, policies, and node data that nodes download |
| [Chef Automate](/automate/client_runs/) | Shows run status and results for every reporting node |

## Infrastructure configuration

Explore how Chef Infra manages [virtual machines](/solutions/infra_management/virtual_machines/) and
[Windows nodes](/solutions/infra_management/windows/).

### What you can manage

Built-in [resources](/client/latest/resources/) manage packages, files and directories, templates, services,
[users](/client/latest/resources/bundled/user/) and groups, [cron jobs](/client/latest/resources/bundled/cron/),
[kernel parameters](/client/latest/resources/bundled/sysctl/), and Windows settings such as
[registry keys](/client/latest/resources/bundled/registry_key/) and
[scheduled tasks](/client/latest/resources/bundled/windows_task/).
For anything the built-in set doesn't cover, write a [custom resource](/client/latest/resources/custom/)
or use a community cookbook from [Chef Supermarket](https://supermarket.chef.io/).

### How you run Chef Infra Client

You can use more than one approach in the same fleet.

| Approach | Use for | How it runs |
| --- | --- | --- |
| [Local mode](/client/latest/reference/ctl_chef_client/#run-in-local-mode) | Cookbook development and single systems | Runs against a local repository, without a server |
| [Client-server](/client/latest/install/bootstrap/) | Fleets that take policy from Chef 360 Platform DSM or Chef Infra Server | Each node downloads its cookbooks and converges locally |
| [As a service](/client/latest/reference/ctl_chef_client/#run-as-a-service) | Keeping configuration in place over time | Runs as a daemon on each node, configured with the Chef Infra Client cookbook |
| [Agentless Mode](/client/latest/features/agentless/) | Linux nodes and devices where you don't install Chef Infra Client | Runs from a host over SSH ([example](/client/latest/features/agentless/example/)) |
| [Chef 360 Platform job](/360/latest/use/operators/job_execution/interpreters/infra_client/) | Running cookbooks as a step in a Chef Courier job | Chef Courier runs Chef Infra Client on the node |

### Results

Each run's output lists every resource as updated or up to date.
In Chef Automate, the [Client Runs](/automate/client_runs/) page shows the run status of every reporting node
and, for each node, its most recent resources, run-list, and attributes.

## Cookbook development

Develop and test cookbooks with Chef Workstation before you assign them to nodes.
The [cookbook development workflow](/workstation/latest/#cookbook-development-workflow) covers generating a cookbook,
linting it with Cookstyle, and converging and verifying it with Test Kitchen.
For a Chef Infra Client 19 `kitchen.yml` file, see [Run Test Kitchen](/workstation/latest/tools/kitchen/run/).

### Before you apply a cookbook to production

- Keep cookbooks in version control, review each change, and assign an owner to each cookbook.
- Apply a new or changed cookbook to a few nodes, review what changed, then expand.
- The first run on a system already in service changes everything that differs from the cookbook.
  Review what the cookbook manages before you assign it.
- Some workflows, such as `kitchen converge` and `knife bootstrap`, need a
  [Chef license key](/licensing/license_key/) when they download Chef software.

## Use Chef Infra with other Chef products

### If you assess systems with Chef InSpec or Chef Compliance

Use Chef Infra to correct the settings behind failing controls, and run the assessment with each Chef Infra Client run.

1. Check whether Chef remediation content covers your benchmark.
   See [compliance remediation](/solutions/compliance/#compliance-remediation).
1. For any setting it doesn't cover, add a [resource](/client/latest/resources/) to your own cookbook.
1. Turn on the [Compliance Phase](/client/latest/features/chef_compliance_phase/) (Chef Infra Client 17 or later).
1. Review the results in Chef Automate [compliance reports](/automate/reports/).

### If you report with Chef Automate

1. Send Chef Infra Client run data to Chef Automate, directly from each node or through Chef Infra Server.
   See [Data collection](/automate/data_collection/).
1. Review run status, failed resources, and run-lists on the [Client Runs](/automate/client_runs/) page.

### If you run Chef Infra Server

1. Plan for end of life in November 2026.
   See the [Chef Infra Server overview](/server/).
1. Move organizations, users, cookbooks, policies, and nodes to Chef 360 Platform DSM.
   See [Migrate from Chef Infra Server to Chef DSM](/360/latest/migrate/on_prem_to_self_managed/).
1. Continue with [If you use Chef 360 Platform](#if-you-use-chef-360-platform).

### If you use Chef 360 Platform

1. Enroll nodes that run Chef Infra Client.
   See [Enroll nodes with a Chef Infra cookbook](/360/latest/use/operators/node_enrollment/cookbook/).
1. Store cookbooks and policies in DSM.
   See [Declarative State Management overview](/360/latest/understand/dsm/).
1. Run Chef Infra Client from a Chef Courier job.
   See [Chef Infra Client interpreter](/360/latest/use/operators/job_execution/interpreters/infra_client/).

## Supported platforms

Chef Infra Client 19 runs on the platforms listed in
[Chef Infra Client supported platforms](/platforms/#chef-infra-client).
For memory, disk, and cache requirements, see
[Chef Infra Client system requirements](/client/latest/install/system_requirements/).
To install it, see [Install Chef Infra Client](/client/latest/install/).
