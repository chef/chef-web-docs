+++
title = "About Chef Habitat Builder"
description = "Chef Habitat Builder is Chef's Application Delivery Enterprise hub"
linkTitle = "Builder"
summary = "Chef Habitat Builder is Chef's Application Delivery Enterprise hub"
list_pages = true

[menu.habitat]
    title = "About Habitat SaaS Builder"
    identifier = "habitat/builder/about"
    parent = "habitat/builder"
    weight = 10
+++

Chef Habitat Builder acts as the core of Chef's Application Delivery Enterprise hub.
It provides a repository for all available Chef Habitat packages built by Chef and the supporting community, as well as search and an API for clients.

You can store application plans on the Chef Habitat Builder SaaS where the Chef Habitat community can view and access them. You can also deploy the [on-prem version of Chef Habitat Builder](https://github.com/habitat-sh/on-prem-builder) where you can store and maintain your apps in a secure environment.

## Chef Habitat Builder components

- **Application Manifest**: The application manifest provides a single application directory, which includes, at a minimum, the compiled app artifact, dynamic links to all direct and transitive runtime dependencies, and instructions to install and run the app.
- **Deployment Channel Management**: Pre-canned deployment channels that you can use as-is or customize. Apps deployed through Chef Habitat can subscribe to a channel and be upgraded automatically whenever the app is promoted.
- **Content Library**: Hundreds of pre-built [application delivery packages](https://bldr.habitat.sh/#/pkgs/core) and core dependencies make it easy to get started with Chef Habitat.
- **Custom Data and Reporting APIs**: Rich APIs enable exporting data to CSV or JSON.
- **DevOps Integration APIs**: APIs allow clients to find and download the necessary packages to run their applications. Additional APIs enable integration with popular DevOps tools, including Jenkins, Terraform, Artifactory, Hashi Vault, and others.
- **Role-Based User Access**: Improves your organization's operational safety by letting you assign specific levels of access to each origin member.

For more information about how the SaaS and on-premises versions of Chef Habitat Builder work together, read the blog: [Chef Habitat On-Prem Builder Enhancements that Extend Support to Airgap Environments and Simplify Set-Up](https://www.chef.io/blog/chef-habitat-product-announcement-builder-on-prem-enhancements-that-extend-support-to-airgap-environments-and-simplify-set-up).
