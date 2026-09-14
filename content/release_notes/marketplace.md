+++
title = "Marketplace release notes"
draft = false
linkTitle = "Marketplace"
summary = "Marketplace release notes"

[menu]
  [menu.release_notes]
    title = "Marketplace"
    identifier = "release_notes/Marketplace"
    parent = "release_notes"
    weight = 130
+++

## Marketplace 1.0.0

Release date: September 2, 2026

Marketplace 1.0.0 is the first release of Marketplace, a new Chef product for public cookbook content that will become part of Chef 360 Platform as it grows.
This release focuses on backward compatibility, so your existing public Chef Supermarket cookbook-consumption workflows keep working if you choose to adopt Marketplace.
See the [Marketplace overview](/marketplace/) to learn what Marketplace is and how it relates to Chef Supermarket.

### New features requiring configuration updates

- **Marketplace public cookbook source**: You can use Marketplace as the public cookbook source for Berkshelf, Policyfiles, and `knife supermarket` commands.
  Update your source URL to `https://marketplace.chef.io`.
  See [Backward compatibility](/marketplace/backward_compatibility/) for configuration steps.

### New features

- **Unauthenticated read-only Knife commands**: Marketplace supports unauthenticated, read-only `knife supermarket` commands, including `download`, `install`, `list`, `search`, and `show`.
- **Parallel public-source support**: You can continue to use the public Chef Supermarket source or configure Marketplace as your public cookbook source, at your own pace.

### Limitations

Marketplace 1.0.0 supports backward compatibility for cookbook-consumption workflows only.
The following items are out of scope for this release:

- Private Chef Supermarket content, including migration workflows for moving that content into Marketplace.
- `knife supermarket` write or administrative workflows.
- Publishing, sharing, unsharing, deprecating, deleting, and administrative content operations.
- Content types other than cookbooks from the public Chef Supermarket.

See [Backward compatibility](/marketplace/backward_compatibility/) for the current, up-to-date list of supported and unsupported workflows.