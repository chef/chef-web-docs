+++
title = "About Chef Workstation"
draft = false

[cascade]
  [cascade.params]
    swiftype_search_products = ["workstation-26.2"]
    version_selector_product = "workstation"
    version_selector = true
    this_version_text = "Chef Workstation 26.2"
    section_root = "/workstation/26.2"
    menu_id = "workstation_26_2"
    breadcrumbs = true
    st_robots = ''

[menu]
  [menu.workstation_26_2]
    title = "About Chef Workstation"
    identifier = "workstation_26_2/about_workstation.md About Chef Workstation"
    weight = 10
+++

<!-- markdownlint-disable-file MD033 -->

Chef Workstation is an all-in-one package that gives you everything you need to get started with Chef infrastructure automation.
With a single installation, you get tools for configuration management, compliance scanning, cookbook development, dependency resolution, and testing.

Chef Workstation is the primary toolkit for Chef infrastructure engineers.
You can use Chef Workstation to:

- **Define automation**: Generate cookbooks and write configuration policy using Chef's declarative resources, or use community cookbooks from Chef Supermarket.
- **Manage secrets**: Encrypt and manage sensitive data, such as passwords and certificates, using Chef Vault.
- **Scan for compliance**: Run Chef InSpec profiles against remote systems to detect and remediate security and configuration issues.
- **Test locally**: Validate your cookbooks with Test Kitchen and Cookstyle before deploying to production.

## Components

Chef Workstation includes the following fully integrated tools:

### Core development tools

- **Chef CLI (`chef-cli`)**: Primary command-line interface for Chef development workflows, providing unified access to common Chef operations
- **Chef Infra Client**: Latest release candidate of the Chef Infra Client, enabling infrastructure automation and configuration management
- **knife**: Essential tool for interacting with Chef Infra Server, managing nodes, cookbooks, roles, and other Chef objects
- **Chef InSpec**: Latest release candidate of InSpec, enabling compliance and security testing.

### Testing and quality assurance

- **Chef Test Kitchen Enterprise**: Comprehensive testing framework for validating infrastructure code across multiple platforms and environments
- **Chef InSpec**: Compliance and security testing framework for auditing infrastructure and applications against security standards and regulations
- **Cookstyle**: Ruby and Chef cookbook linting tool that enforces style guidelines and best practices
- **Fauxhai**: Mock Ohai data generator for testing purposes, enabling rapid cookbook testing without requiring actual systems

### Dependency and secret management

- **Berkshelf**: Cookbook dependency manager that streamlines the process of managing and retrieving cookbook dependencies
- **Chef Vault**: Secure data management tool for encrypting and managing secrets within Chef workflows
- **Ohai**: System profiling tool that detects and reports system attributes for use in Chef recipes

## Get started

To get started with Chef Workstation:

1. [Install Workstation](/workstation/26.2/install/)
1. [Set up Workstation](/workstation/26.2/set_up/)
1. [Add a license](/workstation/26.2/license/)
1. Optional: [Get started with Workstation](/workstation/26.2/get_started/)

### Cookbook development workflow

Use the following workflow when creating, developing, and testing your cookbooks:

1. Generate a new cookbook with `chef generate cookbook <COOKBOOK_NAME>`

   This creates a cookbook with a default recipe, a `kitchen.yml` configuration for Test Kitchen Enterprise, and a starter Chef InSpec profile.

1. Write cookbook recipes in the `recipes` directory.

1. Create a Chef InSpec profile that verifies that your cookbook runs successfully.

1. Lint the cookbook with Cookstyle (`cookstyle .`) to check for style issues.

1. Run Test Kitchen Enterprise (`kitchen converge`) to converge your cookbook in a local VM or container and verify it works:

   This command does the following:

   1. Creates a VM, container, or cloud instance.
   1. Installs the provisioner (Chef Infra Client) on the instance.
   1. Loads the cookbook and Test Kitchen config on the instance.
   1. Runs the cookbook to bring the instance into the state defined in the cookbook.

1. Use Test Kitchen Enterprise to run your InSpec profile (`kitchen verify`) against the converged instance.

    Test Kitchen reports a pass or fail for each control defined in the InSpec profile.

1. Destroy the Test Kitchen Enterprise instance (`kitchen destroy`) when you're done.

1. If your tests fail, update your cookbook and InSpec profile, re-converge your cookbook and re-verify your InSpec profile until all tests pass.

1. Before deploying in a production environment, test your cookbook in a matching environment.

1. Deploy your cookbooks to production only after they pass all acceptance tests.

## More resources

- [Chef Tutorials](https://www.chef.io/training/tutorials)
- [Chef Support and Learning Hub](https://community.progress.com/s/products/chef)
