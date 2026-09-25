+++
title = "Marketplace overview"
draft = false
+++

Marketplace is a Chef product for public cookbook content, and it will become part of [Chef 360 Platform](/360/latest/) as the product grows.
This initial release focuses on one thing: keeping your existing [Chef Supermarket](/supermarket/) cookbook-consumption workflows working without disruption.
You can adopt Marketplace at your own pace, since Chef Supermarket and Marketplace are both available as public cookbook sources today.

## Intended audience

This page is for DevOps engineers and platform teams that currently consume cookbooks from the public Chef Supermarket.

## Backward compatibility

The initial release of Marketplace focuses entirely on backward compatibility: keeping the cookbook-consumption workflows you already use working, whether you point them at Marketplace, the public Chef Supermarket, or both at once.
This protects the automation you already have: pipelines, scripts, and workflows built around `knife supermarket`, Berkshelf, or Policyfile keep working whether they point at Chef Supermarket or Marketplace.
This covers the three ways teams typically consume public cookbooks today:

- `knife supermarket` commands
- Berkshelf
- Policyfile

See [Backward compatibility](/marketplace/backward_compatibility/) for the supported workflows and configuration steps for each one.
See the [Marketplace release notes](/release_notes/marketplace/) for what's new and what's out of scope in each release.

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [Marketplace release notes](/release_notes/marketplace/)
- [Chef Supermarket](/supermarket/)
- [Chef 360 Platform](/360/latest/)
- [knife supermarket](/workstation/latest/tools/knife/knife_supermarket/)
- [Berkshelf](/workstation/latest/tools/berkshelf/)
- [About Policyfiles](/client/latest/policy/policyfile/)