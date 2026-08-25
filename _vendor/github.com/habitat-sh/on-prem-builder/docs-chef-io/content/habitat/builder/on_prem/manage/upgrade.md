+++
title = "Upgrade your Chef Habitat On-Prem Builder deployment"

[menu]
  [menu.habitat]
    title = "Upgrade Builder"
    identifier = "habitat/builder/on-prem/manage/upgrade"
    parent = "habitat/builder/on-prem/manage"
    weight = 50
+++

Chef Habitat On-Prem Builder services don't upgrade automatically.
To upgrade the services, use the uninstall script to stop, unload, and remove them.

{{< note >}}

The uninstall script doesn't remove user data, so you can uninstall and reinstall the Habitat Builder services without losing data.

{{< /note >}}

## Before you begin

If you're upgrading to a Habitat Builder version dated **20260728** or later from an earlier version and you're using MinIO and PostgreSQL to store data, back up your `/hab/svc` directory prior to upgrading.

This release includes major version upgrades of MinIO and PostgreSQL and upgrading to this release triggers an automatic data migration, which can take several minutes to complete.

If the upgrade fails, you can restore your backed-up data and roll back to an earlier Habitat Builder version.

If you store data on your own external PostgreSQL or S3-compliant storage, then you don't need to worry about upgrading the MinIO or PostgreSQL packages installed with Habitat Builder.

## Upgrade Chef Habitat On-Prem Builder

To upgrade Chef Habitat On-Prem Builder, follow these steps:

1. Clone a fresh copy of the [`habitat-sh/on-prem-builder`](https://github.com/habitat-sh/on-prem-builder) repository on the computer running Habitat On-Prem Builder.

1. Confirm your `bldr.env` file has a valid `HAB_AUTH_TOKEN` and set `BLDR_CHANNEL` to `on-prem-base`.

    See the [`bldr.env.sample`](https://github.com/habitat-sh/on-prem-builder/blob/main/bldr.env.sample) file for an example.

1. Uninstall all Habitat Builder services by running the [uninstall script](https://github.com/habitat-sh/on-prem-builder/blob/main/uninstall.sh):

    ```shell
    sudo ./uninstall.sh
    ```

1. After the services are uninstalled, reinstall them by running the [`install.sh` script](https://github.com/habitat-sh/on-prem-builder/blob/main/install.sh):

    ```shell
    ./install.sh
    ```

1. Optional: Follow the supervisor logs to monitor the migration progress. Services may be unavailable for a few minutes after `install.sh` completes, particularly when a data migration is triggered when updating `builder-minio` or `builder-datastore`.

    To follow the logs, run the following command:

    ```shell
    journalctl -fu hab-sup
    ```

    While the migration runs, it is common to see a large number of entries similar to:

    ```shell
    Aug 14 15:11:58 ip-172-31-38-141 hab[121787]: [3.4K blob data]
    ```

    The migration is typically finished once you see a final entry like:

    ```shell
    Aug 14 15:12:14 ip-172-31-38-141 hab[121787]: builder-minio.default hook[post-run]:(HK): Minio bucket is up to date.
    ```

## Roll back an upgrade

If an upgrade to a version dated **20260728** or later fails, and you backed up your `/hab/svc` directory beforehand, you can roll back to the latest on-prem version prior to **20260728**:

1. Uninstall all Habitat Builder services by running the [uninstall script](https://github.com/habitat-sh/on-prem-builder/blob/main/uninstall.sh):

    ```shell
    sudo ./uninstall.sh
    ```

1. Restore your backed up `/hab/svc` directory.

1. In your `bldr.env` file, set `BLDR_CHANNEL` to `on-prem-stable`.

1. Reinstall the services by running the [`install.sh` script](https://github.com/habitat-sh/on-prem-builder/blob/main/install.sh):

    ```shell
    ./install.sh
    ```

1. Binlink Chef Habitat version 1.6:

    ```shell
    sudo hab pkg install core/hab --channel stable -bf
    ```

1. Restart the `hab-sup` systemd service:

    ```shell
    sudo systemctl restart hab-sup
    ```
