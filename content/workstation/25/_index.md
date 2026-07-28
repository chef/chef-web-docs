+++
title = "About Chef Workstation"
draft = false

[cascade]
  [cascade.params]
    swiftype_search_products = ["workstation-25"]
    version_selector_product = "workstation"
    version_selector = true
    this_version_text = "Chef Workstation 25"
    section_root = "/workstation/25"
    menu_id = "workstation_25"
    breadcrumbs = true
    st_robots = ''

[menu]
  [menu.workstation_25]
    title = "About Chef Workstation"
    identifier = "workstation_25/about_workstation.md About Chef Workstation"
    weight = 10
+++

<!-- markdownlint-disable-file MD033 -->

{{< readfile file="content/workstation/25/reusable/md/chef_workstation.md" >}}

Chef Workstation replaces ChefDK, combining all the existing features
with new features, such as ad-hoc task support and the new Chef
Workstation desktop application.

## Getting Started

Chef Infra is a systems and cloud infrastructure automation framework
that makes it easy to deploy servers and applications to any physical,
virtual, or cloud location, no matter the size of the infrastructure.
Each organization is comprised of one (or more) Chef Workstation
installations, a single server, and every node that will be configured
and maintained by Chef Infra Client. Cookbooks (and recipes) are used to
tell Chef Infra Client how each node in your organization should be
configured. Chef Infra Client---which is installed on every node---does
the actual configuration.

- [An Overview of Chef Infra](/chef_overview/)
- [Install Chef Workstation](/workstation/25/install/)

### Cookbook Development Workflow

Chef Infra defines a common workflow for cookbook development:

1. Create a skeleton cookbook by running `chef generate cookbook MY_COOKBOOK_NAME`. This generates a cookbook with a single recipe and testing configuration for Test Kitchen with Chef InSpec.
1. Write cookbook recipes or resources and lint and debug them with Cookstyle and Test Kitchen. Making your own cookbooks is an iterative process where you develop, test, find and fix bugs, and then develop and test some more. A text editor---Visual Studio Code, Atom, vim, or any other preferred text editor---is the only tool that you need to author your cookbooks.
1. Test in acceptance. Test your work in an environment that matches your production environment.
1. Deploy your cookbooks to the production environment, but only after they pass all the acceptance tests and are verified to work in the desired manner.

## Tools

Chef Workstation packages all the tools necessary to be successful with Chef Infra and InSpec. These tools are combined into packages for common operating systems and include all the dependencies you need to get started.

The most important tools included in Chef Workstation are:

- **Chef CLI**: A workflow tool for Chef Infra.
- **knife**: A tool for managing systems on Chef Infra Server.
- **Chef Infra Client**: The Chef Infra agent.
- **Chef InSpec**: A compliance as code tool that can also be used for testing Chef Infra cookbooks.
- **Cookstyle**: A linting tool that helps you write better Chef Infra cookbooks by detecting and automatically correcting style, syntax, and logic mistakes in your code.
- **Test Kitchen**: An integration testing framework tool that tests cookbooks across platforms and various cloud provider / hypervisors.
