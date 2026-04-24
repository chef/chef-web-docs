+++
title = "Chef Infra Client"
linkTitle = "version 19"
summary = "Chef Infra Client v 19"

[cascade]
  [cascade.params]
    swiftype_search_products = ["client-19"]
    version_selector_product = "client"
    version_selector = true
    this_version_text = "Chef Infra Client 19"
    section_root = "/client/19"
    menu_id = "client_19"
    breadcrumbs = true
    st_robots = ''

[menu.client_19]
    title = "Chef Infra Client"
    identifier = "overview/Client Overview"
    parent = "overview"
    weight = 10
+++

Chef Infra Client is an agent that runs locally on every node that's under management by Chef Infra Server.
Chef Infra Client transforms your infrastructure into code by automatically configuring systems to match your desired state.

When Chef Infra Client runs, it performs all the steps required to bring a node into the expected state, including:

- Registering and authenticating the node with Chef Infra Server
- Synchronizing cookbooks from Chef Infra Server to the node
- Compiling the resource collection by loading each of the required cookbooks, including recipes, attributes, and all other dependencies
- Taking the appropriate and required actions to configure the node based on recipes and attributes
- Reporting summary information on the run to Chef Automate

## Chef Infra Client components

Chef Infra Client works with key components to manage your infrastructure:

### Compliance Phase

The Compliance Phase is an integrated security and compliance feature that runs Chef InSpec profiles automatically as part of every Chef Infra Client run.
This phase allows you to continuously audit your infrastructure for compliance with security policies and regulatory requirements without managing separate tools or processes.

For detailed information, see [About the Compliance Phase](/client/19/features/chef_compliance_phase/).

### Node

A node represents any system that Chef Infra Client manages - whether it's a virtual machine, container instance, or physical server.
Every node runs Chef Infra Client and maintains its configuration state according to the policies you define.

### Cookbooks and recipes

Cookbooks contain the instructions (recipes) that tell Chef Infra Client how to configure your systems.
Recipes use resources to describe the desired state of system components like packages, files, and services.

### Run list

The run list defines which cookbooks and recipes Chef Infra Client should execute on a node and in what order.
You can customize run lists for different node types or environments.

### Ohai

Ohai is a system profiling tool that collects detailed information about your nodes, including hardware details, network configuration, and operating system data.
Chef Infra Client uses this information to make intelligent configuration decisions.

### Agentless

Agentless allows you to execute Infra Client runs on a target node over SSH without having Chef Infra Client installed on the node.

For more details and setup instructions, see the [Agentless documentation](/client/19/features/agentless/).

## How Chef Infra Client works

Chef Infra Client operates on a pull-based model where nodes periodically contact Chef Infra Server to retrieve their configuration policies.
This approach ensures that your infrastructure remains in the desired state even if individual nodes experience temporary disconnections or issues.

## Common use cases

You can use Chef Infra Client to automate infrastructure management tasks:

- **Server provisioning**: Automatically configure new servers with required software and settings
- **Application deployment**: Deploy and configure applications across different environments
- **Security compliance**: Enforce security policies and compliance requirements
- **Configuration drift prevention**: Continuously check and correct configuration changes
- **Environment management**: Maintain consistent configurations across development, staging, and production environments

## The Chef Infra Client run

{{< readfile file="content/client/19/reusable/md/chef_client_run.md" >}}

## Related content

- [Chef Infra Client (executable)](/client/19/reference/ctl_chef_client/)
- [Chef Infra Server](/server/)
- [Cookbooks](/client/19/cookbooks/)
- [Nodes](/client/19/overview/nodes/)
- [Run Lists](/client/19/policy/run_lists/)

## Next steps

- [Install Chef Workstation](https://docs.chef.io/workstation/latest/install/)
- [Install Infra Client](/install/)
