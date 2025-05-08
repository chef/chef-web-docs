+++
title = "Bootstrap Core Packages"

[menu]
  [menu.habitat]
    title = "Bootstrap Core Packages"
    identifier = "habitat/builder/on-prem/Bootstrap Core Packages"
    parent = "habitat/builder/on-prem"
    weight = 20
+++


## Create the Core Origin

Create a `core` origin for an initial set of base packages. Uploads will fail unless you first populate your Chef Habitat Builder on-prem with the upstream `core` upstream origin.

Once you are logged in to the Chef Habitat Builder on-prem UI, select the `New Origin` button and enter in `core` as the origin name.

## Generate a Personal Access Token

Next, generate a Personal Access Token for bootstrapping the `core` packages, as well as for performing authenticated operations using the `hab` client.

Select your Gravatar icon on the top right corner of the Chef Habitat Builder on-prem web page, and then select **Profile**. This will take you to a page where you can generate your access token. Make sure to save it securely.

## Bootstrap Builder with Habitat Packages

Chef Habitat Builder on-prem has no pre-installed package sets. You must populate your Builder instance by uploading packages.
With Habitat *0.88.0*, two new commands were introduced to assist in bootstrapping an on-prem Builder instance with a set of stable packages:

1. *hab pkg download*
1. *hab pkg bulkupload*

As you can see from the commands above, the package Bootstrap flow is comprised of two main phases: a download from the public [SaaS Builder](https://bldr.habitat.sh) followed by a bulkupload to your on-prem Builder instance(s). Historically, we bootstrapped on-prem-builders by downloading all the packages in 'core' for all targets. That amounted to ~15GB and was both too much and too little, in that many of the packages weren't needed, and for many patterns (effortless) other origins were needed.

The [new bootstrap process flow](https://forums.habitat.sh/t/populating-chef-habitat-builder-on-prem/1228) allows you to easily customize your Bootstrap package set or use pre-populated [Package Seed Lists](https://github.com/habitat-sh/on-prem-builder/blob/master/package_seed_lists/README.md) files.

The following section illustrates the steps required to bootstrap the on-prem Builder with the [Effortless Linux](https://github.com/habitat-sh/on-prem-builder/blob/master/package_seed_lists/effortless_x86_64-linux_stable) package seed list. Simply repeat the following download/bulkupload flow for any other package seed lists you think you will need to have in your on-prem Builder, or even create your own custom package seed list file:

1. Phase 1: download

    ```bash
    export HAB_AUTH_TOKEN=<your_public_Builder_instance_token>
    cd on-prem-builder
    hab pkg download --target x86_64-linux --channel stable --file package_seed_lists/effortless_x86_64-linux_stable --download-directory builder_bootstrap
    ```

    > Note: If the on-prem Builder is Airgapped, this phase must be completed on a system with Internet connectivity. The downloaded content will need to be zipped and then transferred to the Builder system for phase 2.

1. Phase 2: bulkupload

     **Important**: Inspect the contents of the `builder_bootstrap/artifacts` directory created from the download command above. For each of the origins (`core`, `effortless`, etc),  create the origin name if one doesn't exist already in the on-prem Builder UI before starting the bulkupload.

    > Note: If your on-prem builder's SSL certificate was issued from an internal Public Key Infrastructure and not from a Publicly Trusted Certificate Authority, you will need to copy the SSL public key cert chain into `/hab/cache/ssl` locally on the system that is uploading packages to the on-prem Builder. This is described in more detail [here](https://blog.chef.io/chef-habitat-product-announcement-improved-tls-certificate-management/)

    ```bash
    export HAB_AUTH_TOKEN=<your_on-prem_Builder_instance_token>
    hab pkg bulkupload --url https://your-builder.tld --channel stable builder_bootstrap/
    ```

## Configuring a user workstation

Configuring a user's workstation to point to the Chef Habitat Builder on-prem should be fairly straightforward.

The following environment variables should be configured as needed:

1. `HAB_BLDR_URL` - this is the main (and most important) configuration. It should point to the instance of Chef Habitat Builder on-prem that you have set up. To invoke a Chef Automate-installed on-prem Builder from the command line, use:

```bash
export HAB_BLDR_URL=https://MY_ON_PREM_URL/bldr/v1/`
```

2. `HAB_AUTH_TOKEN` - this is the user's auth token that will be needed for private packages (if any), or for operations requiring privileges, for example, package uploads. The user will need to create their auth token and set/use it appropriately.
3. `SSL_CERT_FILE` - if the Chef Habitat Builder on-prem is configured with SSL and uses a self-signed or other certificate that is not in the trusted chain, then this environment variable can be used on the user's workstation to point the `hab` client to the correct certificate to use when connecting to Chef Habitat Builder on-prem.
