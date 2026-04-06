+++
title = "Install Chef Infra Client"
linkTitle = "Install"

[menu]
  [menu.install]
    title = "Overview"
    identifier = "install/overview"
    parent = "install"
    weight = 10
+++

Use either a native installer or the Chef Infra Client migration tool to install or upgrade Chef Infra Client.

## Supported platforms

Chef Infra Client is supported on:

- Currently supported Linux distributions and versions running Linux kernel 2.6.32 and later
- Currently supported Windows versions greater than or equal to Windows 10

## Native installers

The [Chef Infra Client native installers](installer) provide an efficient way to install Chef Infra Client on Debian and RPM-based distributions.
You can download and install the pre-built `.msi`, `.deb`, or `.rpm` packages using your existing package management tools, simplifying the deployment process for managing system configurations.

## Migration tool

The [Chef Infra Client migration tool](migration_tool) (`chef-migrate`) allows you to install or upgrade Chef Infra Client to the latest version in both online and air-gapped environments.

**Key functions:**

- **Fresh installation:** Install Chef Infra Client
- **Side-by-side installation:** Install Chef Infra Client and remove or keep the previous Infra Client version. If you keep the previous version in side-by-side mode, the path to the most recent version takes precedence
- **Omnibus upgrade:** Upgrade from Omnibus-based Chef Infra Client 17.x or 18.x versions
- **Habitat upgrade:** Upgrade from Habitat-packaged Chef Infra Client releases

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
