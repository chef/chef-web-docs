+++
title = "About Marketplace"
draft = false
+++

Marketplace is a central hub for Chef content, available at [marketplace.chef.io](https://marketplace.chef.io).
It's designed to give DevOps engineers and platform teams one place to find and consume the content that supports their Chef automation, and it's planned to become part of [Chef 360 Platform](/360/latest/).

Marketplace currently provides public cookbooks.
With Marketplace, you can:

- **Consume public cookbooks**: Get the public cookbooks that are mirrored from Chef Supermarket.
- **Keep your existing workflows**: Use read-only `knife supermarket` commands, Berkshelf, and Policyfiles with Marketplace.
- **Adopt at your own pace**: Use Marketplace and Chef Supermarket as cookbook sources in parallel.

## Public Chef Supermarket mirroring

For the time being, ongoing cookbook updates published to the [public Chef Supermarket](https://supermarket.chef.io) are mirrored to Marketplace and reflected on `marketplace.chef.io`.
Mirroring means the public cookbooks you use today stay available and current in Marketplace without any action on your part.

## Backward compatibility

Marketplace works with the tools you already use to consume public cookbooks.
To use Marketplace, you point these tools at it. You don't need to change how your pipelines, scripts, and workflows use them.

- [Read-only `knife supermarket` commands](/marketplace/backward_compatibility/knife_supermarket/): Download, install, list, search, and view public cookbooks.
- [Berkshelf](/marketplace/backward_compatibility/berkshelf/): Resolve cookbook dependencies from Marketplace.
- [Policyfile](/marketplace/backward_compatibility/policyfile/): Use Marketplace as a cookbook source in your Policyfiles.

For configuration steps, see [Backward compatibility](/marketplace/backward_compatibility/).

## Limitations

Marketplace has the following limitations:

- Marketplace currently provides public cookbooks only. It doesn't support private Chef Supermarket content or migration of that content to Marketplace.
- Marketplace doesn't support Knife write or administrative operations, including `knife supermarket upload`. To publish or upload cookbooks with Knife, continue to use `supermarket.chef.io`.
- You can't publish content directly to Marketplace.

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [Marketplace release notes](/release_notes/marketplace/)
- [Chef Supermarket](/supermarket/)
- [Chef 360 Platform](/360/latest/)
- [knife supermarket](/workstation/latest/tools/knife/knife_supermarket/)
- [Berkshelf](/workstation/latest/tools/berkshelf/)
- [About Policyfiles](/client/latest/policy/policyfile/)