+++
title = "Update packages on Habitat Builder"

[menu]
  [menu.habitat]
    title = "Update packages"
    identifier = "habitat/on-prem-builder/packages/update"
    parent = "habitat/on-prem-builder/packages"
    weight = 30
+++

After a Chef Habitat release, you may want to update Habitat packages on Habitat Builder to the latest versions.
This document lays out the steps to take in order to perform such an update.

## Enable native package support

Chef Habitat and other Chef products are moving to long-term support (LTS) channels.
Some of the new LTS-supported packages include native packages.
To host LTS packages, you need to configure on-prem Habitat Builder to allow native package support.

To enable native package support, follow this step:

- Edit the `/hab/user/builder-api/config/user.toml` file on your Habitat Builder deployment so that the `[api]` section looks like this:

  ```toml
  [api]
  features_enabled = "nativepackages"
  targets = ["x86_64-linux", "x86_64-linux-kernel2", "x86_64-windows"]
  allowed_native_package_origins = ["core"]
  ```

  This enables the `nativepackages` feature and specifies `core` as an allowed native package origin.

## Bootstrap Builder with Habitat packages

Use the `habitat/pkg-sync`package to install and sync packages with an on-prem Habitat Builder deployment.
This package downloads packages from the public [SaaS Habitat Builder](https://bldr.habitat.sh) and performs a bulk upload to your Habitat Builder deployment.

### Bootstrap Builder in an internet-connected environment

To refresh your on-prem Builder with the latest released Habitat packages, run the following commands.

Before you begin, you will need your [personal access token](https://bldr.habitat.sh/#/profile) that you use to communicate with the public Habitat Builder and the URL of your on-prem Habitat Builder deployment.

1. Install the `habitat/pkg-sync` package.

    ```bash
    sudo hab pkg install habitat/pkg-sync --channel LTS-2024
    ```

1. Sync packages from the public Habitat Builder to your on-prem Habitat Builder deployment:

    ```bash
    hab pkg exec habitat/pkg-sync pkg-sync \
      --bldr-url <ON_PREM_BUILDER_URL> \
      --channel stable \
      --package-list habitat \
      --private-builder-token <PRIVATE_BUILDER_INSTANCE_TOKEN> \
      --public-builder-token  <PUBLIC_BUILDER_INSTANCE_TOKEN>
    ```

    Replace:

    - `<ON_PREM_BUILDER_URL>` with the URL of your Habitat Builder deployment.
    - `<PUBLIC_BUILDER_ACCESS_TOKEN>` with your public Habitat Builder personal access token.

### Bootstrap Builder in an airgapped environment

For airgapped Habitat Builder deployments, `pkg-sync` can't transfer packages from the public internet to your instance. In this case, you'll download packages on an internet-connected computer, transfer them to your airgapped Habitat Builder, and bulk upload them.

Follow these steps to refresh an airgapped on-prem Builder with the latest stable Habitat packages:

1. On an internet connected machine, install the `habitat/pkg-sync` package:

    ```sh
    sudo hab pkg install habitat/pkg-sync --channel LTS-2024
    ```

1. Use `pkg-sync` to generate a list of packages and download packages from the public Habitat Builder:

    ```bash
    hab pkg exec habitat/pkg-sync pkg-sync \
      --generate-airgap-list \
      --channel stable \
      --package-list habitat \
      --public-builder-token <PUBLIC_BUILDER_TOKEN>

    hab pkg download \
      -u https://bldr.habitat.sh \
      -z <PUBLIC_BUILDER_TOKEN> \
      --target x86_64-linux \
      --channel stable \
      --file package_list_x86_64-linux.txt \
      --download-directory habitat_packages

    hab pkg download \
      -u https://bldr.habitat.sh \
      -z <PUBLIC_BUILDER_TOKEN> \
      --target x86_64-windows \
      --channel stable \
      --file package_list_x86_64-windows.txt \
      --download-directory habitat_packages
    ```

1. Create an archive of the `habitat_packages` directory, copy it to a computer in the airgapped environment, and extract the archive.

1. Bulk upload the packages to your Habitat Builder deployment:

    ```bash
    export HAB_AUTH_TOKEN=<PRIVATE_BUILDER_TOKEN>
    hab pkg bulkupload \
      --url <PRIVATE_BUILDER_URL> \
      --channel stable \
      --auto-create-origins \
      habitat_packages/
    ```
