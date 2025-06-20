+++
title = "About on-prem Chef Habitat Builder"

[cascade]
  [cascade.params]
    gh_repo = "on-prem-builder"
    product = ["habitat"]

[menu]
  [menu.habitat]
    title = "About on-prem Builder"
    identifier = "habitat/on-prem-builder/overview"
    parent = "habitat/on-prem-builder"
    weight = 10
+++

You can deploy Chef Habitat Builder in an on-prem environment which allows you to privately host Chef Habitat packages and associated artifacts such as keys.
You can direct Chef Habitat clients (such as the `hab` cli, Supervisors, and Studios) to your Builder on-prem deployment, which allows you to develop, execute, and manage packages without depending on the public Chef Habitat services.

## Audience

This documentation is for anyone who wishes to host Chef Habitat packages in their own infrastructure.

## Features

Once installed, you'll be able to do the following:

- Log into your Chef Habitat Builder on-prem website.
- Create origins, keys, and access tokens.
- Invite users to origins.
- Upload and download Chef Habitat packages.
- Promote and demote Chef Habitat packages to channels.
- Normal interactions of the `hab` client with the Chef Habitat Builder API.
- Package builds using the `hab` client and Chef Habitat Studio.
- Import core packages from the upstream Chef Habitat Builder.

The following Chef Habitat Builder features aren't available in an on-prem deployment:

- Automate package builds.
- Automate package exports.

## Resources

- [on-prem-builder GitHub repository](https://github.com/habitat-sh/on-prem-builder)
- [Progress Chef Community](https://community.progress.com/s/products/chef)
- [Chef Community Slack](https://community.chef.io/slack)
- [Chef Discourse](https://discourse.chef.io/)

## More information

- [Chef Habitat CLI](/habitat/habitat_cli/)
- [Chef Automate and Chef Habitat Builder](/automate/on_prem_builder/)
