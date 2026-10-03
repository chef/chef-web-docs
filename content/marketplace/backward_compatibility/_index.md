+++
title = "Backward compatibility"
draft = false
+++

Marketplace is available at `https://marketplace.chef.io`.
You can continue to use `https://supermarket.chef.io`, or configure Marketplace as your public cookbook source for any of the workflows in the following sections.
No Marketplace credentials are required for any of these workflows.

See [Chef Supermarket](/supermarket/) to learn more about the platform these workflows currently consume cookbooks from.

## Supported workflows

- [`knife supermarket` commands](/marketplace/backward_compatibility/knife_supermarket/): Download, install, list, search, and show cookbooks with the same unauthenticated, read-only commands you already use.
- [Berkshelf](/marketplace/backward_compatibility/berkshelf/): Point your `Berksfile` at Marketplace to keep your existing Berkshelf workflow working.
- [Policyfile](/marketplace/backward_compatibility/policyfile/): Configure Marketplace as your Policyfile `default_source` for cookbook consumption.

Compatibility applies only to cookbooks from the public Chef Supermarket.
You can use the public Chef Supermarket and Marketplace as cookbook sources in parallel.

## Not yet supported

- Private Chef Supermarket content, including migration workflows for moving that content into Marketplace.
- `knife supermarket` write or administrative workflows.
- Publishing, sharing, unsharing, deprecating, deleting, and administrative content operations.
- Content types other than cookbooks from the public Chef Supermarket.
