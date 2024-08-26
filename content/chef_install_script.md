+++
title = "Chef Software install script"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/install_omnibus.html", "/install_omnibus/"]
product = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

[menu]
  [menu.overview]
    title = "Install script"
    identifier = "overview/packages_&_platforms/Install Script"
    parent = "overview/packages_&_platforms"
    weight = 30
+++

You can use the Chef Software install script to install
any Chef software---including Chef Infra Client, Chef Infra Server, and Chef InSpec---on UNIX, Linux, and Windows platforms.

This script does the following:

- detects the platform, version, and architecture of the machine on which the installer is being executed
- fetches the appropriate package, for the requested product and version
- validates the package content by comparing SHA-256 checksums
- installs the package

## Install using the Commercial API

Commercial users can use the install script from the [Chef Commercial API](/download/commercial/) to install Chef software.

### Prerequisites

You must have a license ID to use the install script from the Chef Commercial API. You can get your license ID from the [Chef Downloads portal](https://chef.io/downloads).

### UNIX, Linux, and macOS

Use the Chef install script to install packages on UNIX, Linux, and macOS systems:

- By default the script installs the latest version of Chef Infra Client:

  ```bash
  curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<LICENSE_ID> | sudo bash
  ```

  Replace `<LICENSE_ID>` with your license ID.

- Use the `-P` option to specify a Chef software application to install:

  ```bash
  curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<LICENSE_ID> | sudo bash -s -- -P <PROJECT>
  ```

  Replace:

  - `<LICENSE_ID>` with your license ID
  - `<PROJECT>` with the application you want to install

For additional script install options, see the [script options](#script-options).

### Windows

On Windows systems, you can install Chef software using the Powershell install script.

- By default the script installs the latest version of Chef Infra Client:

  ```powershell
  . { iwr -useb https://chefdownload-commerical.chef.io/install.ps1?license_id=<LICENSE_ID> } | iex; install
  ```

  Replace `<LICENSE_ID>` with your license ID.

- Use the `-project` option to specify a Chef software application to install:

  ```powershell
  . { iwr -useb https://chefdownload-commerical.chef.io/install.ps1?license_id=<LICENSE_ID> } | iex; install -project <PROJECT>
  ```

  Replace:

  - `<LICENSE_ID>` with your license ID
  - `<PROJECT>` with the application you want to install

For additional script install options, see the [script options](#script-options).

## Install using the Community API

Community users can use the install script from the [Chef Community API](/download/community/) to install Chef software.

### UNIX, Linux, and macOS

Use the Chef install script to install packages on UNIX, Linux, and macOS systems:

- By default the script installs the latest available version of Chef Infra Client:

  ```bash
  curl -L https://chefdownload-community.chef.io/install.sh | sudo bash
  ```

- Use the `-P` option to specify a Chef application to install:

  ```bash
  curl -L https://chefdownload-community.chef.io/install.sh | sudo bash -s -- -P <PROJECT>
  ```

  Replace `<PROJECT>` with the application you want to install

For additional script install options, see the [script options](#script-options).

### Windows

On Windows systems, you can install Chef software using the Powershell install script.

- By default the script installs the latest available version of Chef Infra Client:

  ```powershell
  . { iwr -useb https://chefdownload-community.chef.io/install.ps1 } | iex; install
  ```

- Use the `-project` option to specify a Chef application to install:

  ```powershell
  . { iwr -useb https://chefdownload-community.chef.io/install.ps1 } | iex; install -project <PROJECT>
  ```

For additional script install options, see the [script options](#script-options).

## Script options

In addition to the default install behavior, the Chef Software install script supports the following options:

`-c` (`-channel` on Windows)

: The [release channel](#release-channels) from which a package is pulled.

  The Commercial Download API supports the `current` or `stable` channels.
  The Community Download API only supports the `stable` channel.

  Default value: `stable`.

`-d` (`-download_directory` on Windows)

: The directory into which a package is downloaded. When a package
  already exists in this directory and the checksum matches, the
  package is not re-downloaded. When `-d` and `-f` are not specified,
  a package is downloaded to a temporary directory.

`-f` (`-filename` on Windows)

: The name of the file and the path at which that file is located.
  When a filename already exists at this path and the checksum
  matches, the package is not re-downloaded. When `-d` and `-f` are
  not specified, a package is downloaded to a temporary directory.

`-P` (`-project` on Windows)

: The product name to install. Supported versions of Chef products are
  `chef`,`chef-backend`,`chef-server`,`inspec`,`chef-workstation`,`manage` and
  `supermarket`. Default value: `chef`.

`-s` (`-install_strategy` on Windows)

: The method of package installations. The default strategy is to
  always install when the install.sh script runs. Set to "once" to
  skip installation if the product is already installed on the node.

`-l` (`-download_url_override` on Windows)

: Install package downloaded from a direct URL.

`-a` (`-checksum` on Windows)

:   The SHA256 for download_url_override

`-v` (`-version` on Windows)

:   The version of the package to be installed. A version always takes
    the form x.y.z, where x, y, and z are decimal numbers that are used
    to represent major (x), minor (y), and patch (z) versions. A
    two-part version (x.y) is also allowed. For more information about
    application versioning, see [semver.org](https://semver.org/).

## Release channels

{{< readfile file="content/reusable/md/release_channels.md" >}}

## Examples

The following examples show how to use the Chef Software install script.

- Use the `-v` option to install Chef Infra Client 15.8.23 on Unix, Linux, or macOS hosts:

  ```bash
  curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<LICENSE_ID> | sudo bash -s -- -v 15.8.23
  ```

  Replace `<LICENSE_ID>` with your license ID.

- To install the latest version of Chef Workstation on Windows from the `current` channel:

  ```powershell
  . { iwr -useb https://chefdownload-commerical.chef.io/install.ps1?license_id=<LICENSE_ID> } | iex; install -channel current -project chef-workstation
  ```

  Replace `<LICENSE_ID>` with your license ID.
