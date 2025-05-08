+++
title = "Chef Habitat Builder on-prem"

[menu]
  [menu.habitat]
    title = "Builder on-prem"
    identifier = "habitat/builder/on-prem/overview"
    parent = "habitat/builder/on-prem"
    weight = 10
+++

You can deploy Chef Habitat Builder in an on-prem environment, which allows you to privately host Chef Habitat packages and associated artifacts such as keys.
You can direct Chef Habitat clients (such as the `hab` cli, Supervisors, and Studios) to your Builder on-prem deployment, which allows you to develop, execute, and manage packages without depending on the public Chef Habitat services.

## Audience

This documentation is for anyone who wishes to host Chef Habitat packages in their own infrastructure.

## Features

Once installed, you'll be able to do the following:

- Log into your Chef Habitat Builder on-prem website.
- Create origins, keys, and access tokens.
- Invite users to origins.
- Upload and download Chef Habitat packages.
- Promote and demote Chef Habitat packages to channels.
- Normal interactions of the `hab` client with the Chef Habitat Builder API.
- Package builds using the `hab` client and Chef Habitat Studio.
- Import core packages from the upstream Chef Habitat Builder.

The following Chef Habitat Builder features are _not_ available in an on-prem deployment:

- Automate package builds.
- Automate package exports.

## System requirements

Chef Habitat Builder has the following minimum requirements:

- Deploy Builder on a [Linux distribution supported by Habitat](https://docs.chef.io/habitat/install_habitat/#chef-habitat-for-linux).
- The Linux OS must support the `systemd` process manager.
- It can be deployed to bare metal, a VM, or a container image.
- CPU / RAM should be appropriate for the deployment purpose:
  - 2 CPUs and 4 GB RAM for trial deployments.
  - 16 CPUs and 32 GB RAM for production deployments.
- Significant free disk space:
  - 2GB for the baseline Chef Habitat Builder on-prem services.
  - 15GB+ for the latest Chef Habitat Builder core packages.
  - 30GB+ to download and expand the core package bootstrap in the volume containing the `/tmp` directory.

  We recommend:
  - 50 GB disk space for trial deployments.
  - 100 GB disk space for production deployments.
- Outbound network (HTTPS) connectivity to WAN is required for the _initial_ install.
- Inbound network connectivity from LAN (HTTP/HTTPS) is required for internal clients to access the Chef Habitat Builder on-prem.
- An OAuth2 authentication provider. Chef Automate v2, Azure AD, GitHub, GitHub Enterprise, GitLab, Okta and Bitbucket (cloud) have been verified. Additional providers may be added on request.

## Optional: Memory filesystem storage

Review the following guidelines for your filesystem storage:

- Chef Habitat Builder requires substantial storage space for packages. Ensure you have an appropriate amount of free space on your filesystem.
- Chef Habitat Builder stores package artifacts in a MinIO instance by default, typically in `/hab/svc/builder-minio/data`.
- If you need additional storage, create a mount at `/hab` and point it to your external storage. This is not required if you have sufficient free space.
- If you would prefer to Artifactory instead of MinIO for the object storage, see the [Habitat Builder on-prem and Artifactory](./artifactory/) documentation.

## Next step

After you've prepared your system, use one of the following guides to deploy Habitat Builder:

- [Install Builder on-prem authenticating with Chef Automate](./builder-automate.md)
- [Install Builder on-prem authenticating with another OAuth service](./builder-oauth.md)
