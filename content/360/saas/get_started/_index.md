+++
title = "Get started with Chef 360 SaaS"
linkTitle = "Get started"

[menu.cloud]
title = "Overview"
identifier = "chef_cloud/360/get_started/overview"
parent = "chef_cloud/360/get_started"
weight = 10
+++

This section is a quickstart guide to using Chef 360 SaaS and its tools.

## How Chef 360 SaaS works

Chef 360 SaaS consists of three main components:

- **Chef 360 SaaS CLIs**: Users use the CLIs to define and invoke Chef Courier jobs, and configure user accounts, tenants, organizations, and nodes.
- **Chef 360 SaaS**: Manages users, organizations, and tenants, schedules and distributes Courier jobs, and monitors nodes and job results.
- **Chef skills**: Chef 360 SaaS installs skills on each node that manage the node, execute jobs, and report to Chef 360 SaaS.

## What this guide covers

This guide walks you through the following steps:

1. Installing Chef 360 SaaS in a single-node Kubernetes cluster.
1. Installing Chef 360 SaaS CLIs on a local workstation and registering it with Chef 360 SaaS.
1. Enrolling a node with Chef 360 SaaS. Nodes can be enrolled using a Chef 360 SaaS CLI or by uploading a Chef Infra cookbook if Chef Infra Client is already installed on the node.
1. Defining and running a basic job on a node, and reviewing the job's execution details and the results of each step.

## Before you begin

- Review the [Chef 360 SaaS system requirements]({{< relref "/360/saas/system_requirements.md" >}}).

## Next steps

- [Set up Chef 360 SaaS]({{< relref "/360/saas/get_started/set_up.md" >}}).
