+++
title = "About Chef Habitat On-Prem Builder"
description = "Chef Habitat Builder is Chef's Application Delivery Enterprise hub"
linkTitle = "Habitat On-Prem Builder"
summary = "Host and manage packages within your organization's infrastructure"

[menu.builder]
    title = "On-Prem Builder"
    identifier = "habitat/builder/on-prem/about"
    parent = "habitat/builder/on-prem"
    weight = 10
+++

Chef Habitat On-Prem Builder is the preferred and fully supported method for hosting and managing Habitat packages within your organization's infrastructure.
It provides a secure, private, and compliant environment for managing your software artifacts and is ideal for both connected and air-gapped environments.

You can deploy Chef Habitat On-Prem Builder and privately host Chef Habitat packages and associated artifacts such as keys.
You can direct Chef Habitat clients (such as the `hab` cli, Supervisors, and Studios) to your On-Prem Builder deployment, which allows you to develop, execute, and manage packages without depending on the public Chef Habitat services.

## Audience

This documentation is for anyone who wishes to host Chef Habitat packages in their own infrastructure.

## Features

Once installed, you'll be able to do the following:

- Log into Chef Habitat On-Prem Builder.
- Create origins, keys, and access tokens.
- Invite users to origins.
- Upload and download Chef Habitat packages.
- Promote and demote Chef Habitat packages to channels.
- Normal interactions using the `hab` client with the Chef Habitat Builder API.
- Package builds using the `hab` client and Chef Habitat Studio.
- Import core packages from the upstream Chef Habitat SaaS Builder.

The following Chef Habitat SaaS Builder features aren't available with On-Prem Builder:

- automated package builds
- automated package exports

## Resources

- [on-prem-builder GitHub repository](https://github.com/habitat-sh/on-prem-builder)
- [habitat GitHub repository](https://github.com/habitat-sh/habitat)
- [Progress Chef Community](https://community.progress.com/s/products/chef)
- [Chef Community Slack](https://community.chef.io/slack)
- [Chef Discourse](https://discourse.chef.io/)

## More information

- [Chef Habitat CLI](/habitat/habitat_cli/)
- [Chef Automate and Chef Habitat Builder](/automate/on_prem_builder/)
