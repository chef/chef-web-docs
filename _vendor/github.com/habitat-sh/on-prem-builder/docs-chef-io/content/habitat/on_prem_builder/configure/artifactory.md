+++
title = "Use Artifactory as a Habitat package artifact store"

[menu]
  [menu.habitat]
    title = "Use Artifactory as a package artifact store"
    identifier = "habitat/on-prem-builder/configure/artifactory"
    parent = "habitat/on-prem-builder/configure"
    weight = 30
+++

You can use an existing Artifactory instance as your object store instead of MinIO.
This feature is available as an early preview for testing.

## Configure Habitat Builder to use Artifactory as an object store

Before you start, make sure you have:

- The URL of your Artifactory instance.
- An API key to authenticate with Artifactory.
- An Artifactory repository for storing Habitat artifacts.

To use an Artifactory instance as your object store, follow these steps:

1. If you don't have it already on your system, clone the [habitat-sh/on-prem-builder repository](https://github.com/habitat-sh/on-prem-builder).
1. Update your `bldr.env` file using the Artifactory settings in [`bldr.env.sample`](https://github.com/habitat-sh/on-prem-builder/blob/main/bldr.env.sample).
1. Install Habitat Builder on-prem as usual with the `install.sh` script.
1. Optional: Sign in to Habitat Builder, create an origin, upload some packages, and verify that the packages appear in your specified Artifactory repository.

If you have issues, see the support section below.

## Test a local Artifactory instance

To quickly test with a local Artifactory instance, run:

```bash
sudo hab svc load core/artifactory
```

This command starts a local Artifactory instance.
You can view it at: `http://localhost:8081/artifactory/webapp/#/home`

## Manage Builder artifacts on Artifactory

If you use Artifactory for your Habitat Builder on-prem artifact store, read about [Artifactory's best practices for disaster recovery](https://jfrog.com/whitepaper/best-practices-for-artifactory-backups-and-disaster-recovery/).
