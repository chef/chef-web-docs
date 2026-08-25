+++
title = "Chef Habitat Builder release notes"
draft = false
swiftype_search_products = ["habitat"]
linkTitle = "Chef Habitat Builder"
summary = "Chef Habitat Builder release notes"

[menu]
  [menu.release_notes]
    title = "Chef Habitat Builder"
    identifier = "release_notes/Chef Habitat Builder"
    parent = "release_notes"
    weight = 45
+++

## Chef Habitat Builder 20260820

Release date: August 25, 2026

### Summary

We've promoted this release to the `on-prem-base` channel and is the recommended version for new and existing Chef Habitat On-Prem Builder deployments.
It includes changes from several releases that were previously published to the `base` channel, including major version upgrades to the bundled MinIO and PostgreSQL packages and an updated Habitat Supervisor.

{{< note >}}

If you're upgrading an existing Chef Habitat On-Prem Builder deployment that uses the bundled MinIO and PostgreSQL packages to store data, read [Before you begin]({{< relref "/habitat/builder/on_prem/manage/upgrade.md#before-you-begin" >}}) before you start the upgrade.

{{< /note >}}

### Breaking changes

- **MinIO and PostgreSQL major version upgrades**: This release includes major version upgrades of the bundled MinIO and PostgreSQL packages. Upgrading from an earlier version to this release---or any Chef Habitat On-Prem Builder release dated July 28, 2026 or later---triggers an automatic data migration that can take several minutes to complete. If you use an externally hosted PostgreSQL database or S3-compatible object storage instead of the bundled services, this migration doesn't apply. See [Upgrade your Chef Habitat On-Prem Builder deployment]({{< relref "/habitat/builder/on_prem/manage/upgrade.md" >}}) for complete upgrade and rollback steps.
- **Default channel changed to `on-prem-base`**: The default value of `BLDR_CHANNEL` in `bldr.env` changed from `on-prem-stable` to `on-prem-base`. Update your `bldr.env` file to set `BLDR_CHANNEL=on-prem-base` before upgrading.
- **Required `HAB_AUTH_TOKEN`**: `bldr.env` now requires a valid personal access token, from the public Habitat Builder that's associated with an active license. Set `HAB_AUTH_TOKEN` in your `bldr.env` file before installing or upgrading. The installer adds this token to your Builder's systemd environment. See [Install Chef Habitat On-Prem Builder]({{< relref "/habitat/builder/on_prem/install/builder_oauth.md" >}}) for setup steps.

### New features

- **Habitat Supervisor updated to the latest Habitat 2.1.x release**: Chef Habitat On-Prem Builder now installs the Habitat Supervisor from the latest Habitat 2.1.x release line, bringing in all Supervisor fixes and improvements released since the previous on-prem release.
- **aarch64-linux and aarch64-darwin added as default platforms**: Chef Habitat On-Prem Builder now supports `aarch64-linux` and `aarch64-darwin` as default target platforms, so you can sync and serve packages for these architectures without additional configuration.
