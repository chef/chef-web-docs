+++
title = "Marketplace overview"
draft = false
+++

Marketplace is a Chef product for public cookbook content, and it will become part of [Chef 360 Platform](/360/latest/) as the product grows.
This initial release focuses on one thing: keeping your existing [Chef Supermarket](/supermarket/) cookbook-consumption workflows working without disruption.
You can adopt Marketplace at your own pace, since Chef Supermarket and Marketplace are both available as public cookbook sources today.

## Intended audience

This page is for DevOps engineers and platform teams that currently consume cookbooks from the public Chef Supermarket.

## Initial-release scope

The initial release is limited to backward compatibility for cookbook-consumption workflows that currently use the public Chef Supermarket.

The confirmed scope includes:

- Backward compatibility for unauthenticated, read-only `knife supermarket` commands, including `download`, `install`, `list`, `search`, and `show`.
- Backward compatibility for Berkshelf cookbook consumption workflows.
- Backward compatibility for Policyfile cookbook consumption workflows.
- Compatibility only for cookbooks from the public Chef Supermarket.
- Parallel support for public Chef Supermarket and Marketplace cookbook sources.

See [Backward compatibility](/marketplace/backward_compatibility/) for configuration steps for each workflow.

## Out-of-scope and limitations for this release

The following items are outside the initial-release scope:

- Private Chef Supermarket content.
- `knife supermarket` write or administrative workflows.
- Publishing, sharing, unsharing, deprecating, deleting, and administrative content operations.
- Migration workflows for private Chef Supermarket.
- New content types beyond cookbooks from the public Chef Supermarket.

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [Chef Supermarket](/supermarket/)
- [Chef 360 Platform](/360/latest/)
- [knife supermarket](/workstation/latest/tools/knife/knife_supermarket/)
- [Berkshelf](/workstation/latest/tools/berkshelf/)
- [About Policyfiles](/client/latest/policy/policyfile/)