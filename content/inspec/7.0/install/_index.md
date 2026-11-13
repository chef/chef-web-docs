+++
title = "Install Chef InSpec"
draft = false

[menu.inspec_7_0]
    title = "Install InSpec"
    identifier = "install/install"
    parent = "install"
    weight = 10
+++

<!-- cSpell:ignore binlink, binlinks, binlinked -->

This page documents how to install Chef InSpec from a Chef Habitat package.

## Supported platforms

Chef InSpec is supported on the following platforms:

- Windows x86-64
- Linux x86-64

## Prerequisites

- [Chef Habitat installed on your workstation](/habitat/install_habitat/)
- [A Chef Habitat Builder profile with a personal access token](/habitat/builder_profile/)

## Install Chef InSpec

Install the Chef InSpec Habitat package:

```sh
sudo hab pkg install chef/inspec --channel base-2025 --binlink --force --auth <HAB_BUILDER_TOKEN>
```

For more information, see the [Habitat CLI documentation](/habitat/habitat_cli/#hab-pkg-install).

## Verify installation

Use the following commands to verify that Chef InSpec is installed:

- If you binlinked the InSpec package during installation, check the installed InSpec version:

  ```sh
  inspec version
  ```

## Manage the Chef InSpec package

### Upgrade Chef InSpec

To upgrade to a newer version in the same channel, re-run the install command with `--force`:

```sh
sudo hab pkg install chef/inspec --channel base-2025 --binlink --force
```

### Uninstall the InSpec package

```sh
sudo hab pkg uninstall chef/inspec
```

## Troubleshooting

### Authentication errors

While installing Chef InSpec, if you see an error like this:

```sh
✗✗✗ When applicable, we try once, then re-attempt 5 times to
✗✗✗ download a package. Unfortunately, we failed to download
✗✗✗ chef/inspec/7.*.**/2025****** for x86_64-linux.
✗✗✗ Last error: [401 Unauthorized] Please check that you have specified a valid Personal Access Token.
```

This indicates that Habitat CLI can't authenticate with Chef Habitat Builder due to an invalid personal access token.

- [Verify your token or create a new personal access token](/habitat/builder_profile/#create-a-personal-access-token) in Chef Habitat Builder.
