+++
title = "Habitat Builder system requirements"

[menu]
  [menu.habitat]
    title = "System requirements"
    identifier = "habitat/on-prem-builder/install/install/system requirements"
    parent = "habitat/on-prem-builder/install"
    weight = 20
+++

See the following sections for Chef Habitat On-Prem Builder's requirements.

## Requirements

- Deploy Habitat Builder on a [Linux distribution supported by Habitat](/habitat/install_habitat/#chef-habitat-for-linux).
- The Linux OS must support the `systemd` process manager.
- You can deploy on bare metal, a VM, or a container image.
- Match CPU and RAM to your deployment purpose:
  - Use 2 CPUs and 4 GB RAM for trial deployments.
  - Use 16 CPUs and 32 GB RAM for production deployments.
- Provide enough free disk space:
  - 2 GB for the baseline Chef Habitat On-Prem Builder services,
  - 15 GB or more for the latest Chef Habitat On-Prem Builder core packages,
  - 30 GB or more to download and expand the core package bootstrap in the volume containing `/tmp`.

  Recommended disk space:
  - 50 GB for trial deployments.
  - 100 GB for production deployments.
- Outbound network (HTTPS) connectivity to the WAN is required for the initial install.
- Inbound network connectivity from the LAN (HTTP/HTTPS) is required for internal clients to access Chef Habitat On-Prem Builder. This is port 80 or port 443 if you plan to enable SSL.
- An OAuth2 authentication provider is required. Chef Automate v2, Azure AD, GitHub, GitHub Enterprise, GitLab, Okta, and Bitbucket (cloud) are verified. You can request support for additional providers.

## Optional: Memory filesystem storage

Follow these guidelines for filesystem storage:

- Chef Habitat On-Prem Builder needs substantial storage space for packages. Make sure your filesystem has enough free space.
- By default, Chef Habitat On-Prem Builder stores package artifacts in a MinIO instance, typically at `/hab/svc/builder-minio/data`.
- If you need more storage, create a mount at `/hab` and point it to your external storage. This isn't required if you already have enough free space.
- To use Artifactory instead of MinIO for object storage, see the [Habitat On-Prem Builder and Artifactory](/habitat/on_prem_builder/configure/artifactory/) documentation.
