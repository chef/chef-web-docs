+++
title = "Install Chef Infra Client using the migration tool"
linkTitle = "Migration tool"

[menu.install]
title = "Overview"
parent = "install/migration_tool"
weight = 10
+++

The Chef Infra Client migration tool (`migrate-ice`) allows you to install or upgrade Chef Infra Client to the latest version in both online and air-gapped environments.

## Key functions

- **Fresh installation:** Install Chef Infra Client
- **Side-by-side installation:** Install Chef Infra Client and remove or keep the previous Infra Client version. If you keep the previous version in side-by-side mode, the path to the most recent version takes precedence
- **Omnibus upgrade:** Upgrade from Omnibus-based Chef Infra Client 17.x or 18.x versions
- **Habitat upgrade:** Upgrade Habitat-packaged Chef Infra Client releases

## Supported platforms

Chef Infra Client is supported on:

- Currently supported Linux distributions and versions running Linux kernel 2.6.32 and later
- Currently supported Windows versions greater than or equal to Windows 10

## Install guides

To install or upgrade Chef Infra Client, see these guides:

- [Install](install)
- [Online upgrade](upgrade_online)
- [Air-gapped upgrade](upgrade_airgap)
- [`migrate-ice` CLI reference](reference)

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
