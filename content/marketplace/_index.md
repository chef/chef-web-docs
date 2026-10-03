+++
title = "Marketplace overview"
draft = false
+++

Marketplace is a Chef product for public cookbook content that is planned to become part of [Chef 360 Platform](/360/latest/).
It supports cookbook consumption through workflows that already use [Chef Supermarket](/supermarket/).

## Intended audience

This page is for teams that currently consume cookbooks from the public Chef Supermarket.

## Public Chef Supermarket mirroring

For the time being, ongoing cookbook updates published to [the public Chef Supermarket](https://supermarket.chef.io) are mirrored to Marketplace and reflected on `marketplace.chef.io`.

## Backward compatibility

Marketplace's backward-compatibility support helps teams continue using their existing automation to consume public cookbooks.
Marketplace currently supports these public cookbook workflows:

- [Read-only `knife supermarket` commands](/marketplace/backward_compatibility/knife_supermarket/) to download, install, list, search, and view public cookbooks.
- [Berkshelf](/marketplace/backward_compatibility/berkshelf/) cookbook sources.
- [Policyfile](/marketplace/backward_compatibility/policyfile/) cookbook sources.

## Limitations

- Marketplace supports public cookbooks only. Private Chef Supermarket content and migration of private content to Marketplace aren't supported.
- Marketplace doesn't support Knife write or administrative operations, including `knife supermarket upload`. To publish or upload cookbooks with Knife, continue to use `supermarket.chef.io`.
- Marketplace doesn't support cookbook publishing or content types other than cookbooks.

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [Marketplace release notes](/release_notes/marketplace/)
- [Chef Supermarket](/supermarket/)
- [Chef 360 Platform](/360/latest/)
- [knife supermarket](/workstation/latest/tools/knife/knife_supermarket/)
- [Berkshelf](/workstation/latest/tools/berkshelf/)
- [About Policyfiles](/client/latest/policy/policyfile/)