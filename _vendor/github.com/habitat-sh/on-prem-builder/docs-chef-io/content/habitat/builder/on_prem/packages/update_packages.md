+++
title = "Update packages on Habitat Builder"

[menu]
  [menu.habitat]
    title = "Update packages"
    identifier = "habitat/builder/on-prem/packages/update"
    parent = "habitat/builder/on-prem/packages"
    weight = 30
+++

After a Chef Habitat release, you may want to update Habitat packages on Habitat Builder to the latest versions.
This document lays out the steps to take in order to perform such an update.

## Bootstrap vs Update: Understanding the Difference

**Bootstrapping** is the initial process of populating an empty On-Prem Builder instance with packages from the public Habitat Builder. This is typically done once when you first set up your Builder instance. See the [Bootstrap Core Packages guide](../packages/bootstrap_core_packages) for initial setup.

**Updating** is the ongoing process of refreshing your existing On-Prem Builder with the latest package versions from the public/SaaS Habitat Builder. This is done periodically to keep your packages current with the latest releases, security updates, and improvements.

The main differences:
- **Bootstrap**: Used for initial setup of an empty Builder instance. Downloads essential core packages needed for basic functionality
- **Update**: Used for ongoing maintenance to refresh packages to newer versions. Can focus on specific package sets (habitat, builder) or all packages in an origin

## Enable native package support

Native packages are specialized Habitat packages that contain platform-specific binaries or libraries that cannot be easily rebuilt from source in the Habitat studio environment. They provide essential system-level components and low-level dependencies that other Habitat packages rely on. Examples include: 
- Core system libraries
- Compilers
- Other foundational tools that need to maintain their original binary format for compatibility and performance reasons.

Some new low level `core` origin packages include `native` packages.
To host these packages, you need to configure Habitat On-Prem Builder to allow native package support.

To enable native package support, follow this step:

- Edit the `/hab/user/builder-api/config/user.toml` file on your Habitat Builder deployment so that the `[api]` section looks like this:

  ```toml
  [api]
  features_enabled = "nativepackages"
  targets = ["x86_64-linux", "aarch64-linux", "x86_64-windows"]
  allowed_native_package_origins = ["core"]
  ```

  This enables the `nativepackages` feature and specifies `core` as an allowed native package origin.

## Bootstrap Builder with Habitat packages

Use the `habitat/pkg-sync` package to install and sync packages with an Habitat On-Prem Builder deployment.
This package downloads packages from the public [SaaS Habitat Builder](https://bldr.habitat.sh) and performs a bulk upload to your Habitat Builder deployment.

### Bootstrap Builder in an internet-connected environment

To refresh your On-Prem Builder with the latest released Habitat packages, run the following commands.

Before you begin, you will need your [personal access token](https://bldr.habitat.sh/#/profile) that you use to communicate with the public Habitat Builder and the URL of your Habitat On-Prem Builder deployment.

1. Install the `habitat/pkg-sync` package.

    ```bash
    sudo hab pkg install habitat/pkg-sync
    ```

1. Sync packages from the public Habitat Builder to your Habitat On-Prem Builder deployment:

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

Follow these steps to refresh an airgapped On-Prem Builder with the latest stable Habitat packages:

1. On an internet connected machine, install the `habitat/pkg-sync` package:

    ```sh
    sudo hab pkg install habitat/pkg-sync
    ```

1. Use `pkg-sync` to generate a list of habitat and core packages:

    ```bash
    mkdir chef-pkgs
    cd chef-pkgs
    hab pkg exec habitat/pkg-sync pkg-sync \
      --generate-airgap-list \
      --channel stable \
      --package-list habitat \
      --public-builder-token <PUBLIC_BUILDER_TOKEN>
    cd ../
    mkdir core-pkgs
    cd core-pkgs
    hab pkg exec habitat/pkg-sync pkg-sync \
      --generate-airgap-list \
      --channel base \
      --origin core \
      --public-builder-token <PUBLIC_BUILDER_TOKEN>
    ```
1.  Download habitat packages and their core dependencies from the public Habitat Builder

    ```bash
    cd ../
    hab pkg download \
      -u https://bldr.habitat.sh \
      -z <PUBLIC_BUILDER_TOKEN> \
      --target x86_64-linux \
      --file chef-pkgs/package_list_x86_64-linux.txt \
      --download-directory habitat_packages
    hab pkg download \
      -u https://bldr.habitat.sh \
      -z <PUBLIC_BUILDER_TOKEN> \
      --target x86_64-windows \
      --file chef-pkgs/package_list_x86_64-windows.txt \
      --download-directory habitat_packages
    hab pkg download \
      -u https://bldr.habitat.sh \
      -z <PUBLIC_BUILDER_TOKEN> \
      --target aarch64-linux \
      --file chef-pkgs/package_list_aarch64-linux.txt \
      --download-directory habitat_packages
    ```

1. Create an archive of the `chef-pkgs`, `core-pkgs`, and `habitat_packages` directories, copy it to a computer in the airgapped environment, and extract the archive.

1. Bulk upload the packages to your Habitat Builder deployment:

    ```bash
    export HAB_AUTH_TOKEN=<PRIVATE_BUILDER_TOKEN>
    hab pkg bulkupload \
      --url <PRIVATE_BUILDER_URL> \
      --auto-create-origins \
      habitat_packages/
    ```

1. Promote the `core` origin packages to the `base` channel:

    ```bash
    hab pkg exec habitat/pkg-sync pkg-sync \
      --bldr-url <PRIVATE_BUILDER_URL> \
      --channel base \
      --private-builder-token <PRIVATE_BUILDER_INSTANCE_TOKEN> \
      --idents-to-promote core-pkgs/package_list_x86_64-linux.txt
    hab pkg exec habitat/pkg-sync pkg-sync \
      --bldr-url <PRIVATE_BUILDER_URL> \
      --channel base \
      --private-builder-token <PRIVATE_BUILDER_INSTANCE_TOKEN> \
      --idents-to-promote core-pkgs/package_list_x86_64-windows.txt
    hab pkg exec habitat/pkg-sync pkg-sync \
      --bldr-url <PRIVATE_BUILDER_URL> \
      --channel base \
      --private-builder-token <PRIVATE_BUILDER_INSTANCE_TOKEN> \
      --idents-to-promote core-pkgs/package_list_aarch64-linux.txt
    ```

1. Promote the `chef` origin packages to the `stable` channel:

    ```bash
    hab pkg exec habitat/pkg-sync pkg-sync \
      --bldr-url <PRIVATE_BUILDER_URL> \
      --channel stable \
      --private-builder-token <PRIVATE_BUILDER_INSTANCE_TOKEN> \
      --idents-to-promote chef-pkgs/package_list_x86_64-linux.txt
    hab pkg exec habitat/pkg-sync pkg-sync \
      --bldr-url <PRIVATE_BUILDER_URL> \
      --channel stable \
      --private-builder-token <PRIVATE_BUILDER_INSTANCE_TOKEN> \
      --idents-to-promote chef-pkgs/package_list_x86_64-windows.txt
    hab pkg exec habitat/pkg-sync pkg-sync \
      --bldr-url <PRIVATE_BUILDER_URL> \
      --channel stable \
      --private-builder-token <PRIVATE_BUILDER_INSTANCE_TOKEN> \
      --idents-to-promote chef-pkgs/package_list_aarch64-linux.txt
    ```
