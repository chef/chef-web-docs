+++
title = "Bootstrap core Habitat packages"

[menu]
  [menu.habitat]
    title = "Bootstrap core packages"
    identifier = "habitat/on-prem-builder/packages/Bootstrap Core Packages"
    parent = "habitat/on-prem-builder/packages"
    weight = 20
+++

When you first deploy Chef Habitat On-Prem Builder, it doesn't include any pre-installed packages.
This page explains how to bootstrap Builder with packages from [Chef's public Habitat Builder](https://bldr.habitat.sh).

## Generate a personal access token

You need a personal access token in your on-prem Habitat Builder deployment to bootstrap the `core` packages and authenticate with the `hab` client.

If you don't already have a token, generate one:

1. In the top right corner of your on-prem Habitat Builder site, select your Gravatar icon, then select **Profile**.
1. On the profile page, generate your access token and save it securely.

## Add a license key

You can enter your license key just below the **Personal Access Token** field so you can access official Chef-maintained packages.

## Enable native package support

Some new LTS-supported packages include `native` packages.
To host LTS packages, you must configure your Habitat Builder deployment to allow native package support.
Enable the `nativepackages` feature and specify `core` as an allowed native package origin.
Edit your On-Prem Builder's `/hab/user/builder-api/config/user.toml` file so the `[api]` section looks like this:

```toml
[api]
features_enabled = "nativepackages"
targets = ["x86_64-linux", "x86_64-linux-kernel2", "x86_64-windows"]
allowed_native_package_origins = ["core"]
```

## Bootstrap Builder in an online environment

Chef Habitat On-Prem Builder doesn't include any pre-installed package sets.
You need to upload packages to populate Habitat Builder deployment.
To help bootstrap your On-Prem Builder with core packages, you can install the `habitat/pkg-sync` package.
This package downloads packages from the public [SaaS Builder](https://bldr.habitat.sh) and then uploads them in bulk to your Habitat Builder deployment.

To bootstrap on-prem Habitat Builder with a full set of stable core packages, run:

```bash
sudo hab pkg install habitat/pkg-sync --channel LTS-2024

hab pkg exec habitat/pkg-sync pkg-sync \
  --bldr-url <PRIVATE_BUILDER_URL> \
  --origin core \
  --channel stable \
  --private-builder-token <PRIVATE_BUILDER_TOKEN> \
  --public-builder-token <PUBLIC_BUILDER_TOKEN>
```

### Bootstrap Builder in an airgapped environment

You can't transfer packages directly to Habitat Builder in an airgapped environment using `pkg-sync`,
so instead you have to download packages from the [public Habitat Builder](https://bldr.habitat.sh) and upload them to your airgapped deployment.

Before you begin, you will need your personal access token that you use to communicate with your on-prem Habitat Builder deployment and the URL of your on-prem Habitat Builder deployment.

To bootstrap an airgapped On-Prem Builder with stable core packages, follow these steps:

1. Download the `habitat/pkg-sync` package on a machine with internet access:

   ```bash
   sudo hab pkg install habitat/pkg-sync --channel LTS-2024
   ```

1. Generate a list of packages to download:

   ```shell
   hab pkg exec habitat/pkg-sync pkg-sync --generate-airgap-list --origin core --channel stable
   ```

1. Download packages into the `builder_bootstrap` directory on your computer:

   ```shell
   hab pkg download --target x86_64-linux --channel stable --file package_list_x86_64-linux.txt --download-directory builder_bootstrap
   hab pkg download --target x86_64-windows --channel stable --file package_list_x86_64-windows.txt --download-directory builder_bootstrap
   ```

1. Archive the `builder_bootstrap` directory, then copy and extract the archive on a computer running in the airgapped environment.

1. Bulk upload packages to Habitat Builder:

   ```bash
   export HAB_AUTH_TOKEN=<ON_PREM_BUILDER_INSTANCE_TOKEN>
   hab pkg bulkupload --url https://<ON_PREM_BUILDER_DOMAIN> --channel stable --auto-create-origins builder_bootstrap/
   ```
