+++
title = "Set up a Chef package repository"
draft = false
gh_repo = "chef-web-docs"

swiftype_search_products = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

[menu]
  [menu.overview]
    title = "Set up a Chef package repository"
    identifier = "overview/packages_&_platforms/packages.md Packages"
    parent = "overview/packages_&_platforms"
    weight = 10
+++

<!-- cspell:words trixie -->

Use this guide to create a platform-native package repository so you can install Progress Chef application packages through your system's package manager.

## Before you begin

{{< readfile file="content/reusable/md/release_channels.md" >}}

The `stable` and `current` release channels support the following package repositories:

- APT (Debian and Ubuntu platforms)
- YUM and DNF (Enterprise Linux platforms)

## Set up an APT package repository for Debian and Ubuntu

To set up an APT package repository for Debian and Ubuntu, follow these steps:

1. Enable APT to fetch packages over HTTPS:

    ```shell
    sudo apt-get install apt-transport-https
    ```

1. Install the public key for Chef Software:

    ```shell
    wget -qO - https://packages.chef.io/chef.asc | sudo apt-key add -
    ```

1. Create the APT repository source file:

    ```shell
    echo "deb https://<LICENSE_ID>@packages.chef.io/repos/apt/<CHANNEL> <DISTRIBUTION> main" > chef-<CHANNEL>.list
    ```

    Replace:

    - `<LICENSE_ID>` with your license ID.
    - `<CHANNEL>` with the release channel: `stable` or `current`.
    - `<DISTRIBUTION>` with the codename for your distribution. For example:

      - Debian 11: `bullseye`
      - Debian 12: `bookworm`
      - Debian 13: `trixie`
      - Ubuntu 22.04: `jammy`
      - Ubuntu 24.04: `noble`

1. Move the repository source file into the APT sources directory:

    ```shell
    sudo mv chef-stable.list /etc/apt/sources.list.d/
    ```

1. Update the APT package cache:

    ```shell
    sudo apt-get update
    ```

## Set up a package repository for Enterprise Linux

{{< note >}}

Starting in Chef Infra Client 18.6.2, Chef upgraded the GPG signing algorithm used to sign RHEL packages from SHA1 to SHA256. RHEL 9 no longer supports the less secure SHA1 hashes.

{{< /note >}}

### Set up a YUM repository for Enterprise Linux

To set up a YUM package repository for Enterprise Linux, follow these steps:

1. Verify that you have the `yum-utils` package installed:

    ```shell
    rpm -q yum-utils
    ```

    If the command returns `package yum-utils is not installed`, install it:

    ```shell
    sudo yum install -y yum-utils
    ```

1. Install the public key for Chef Software:

    ```shell
    sudo rpm --import https://packages.chef.io/chef.asc
    ```

1. Create the YUM repository source file:

    ```shell
    cat >chef-<CHANNEL>.repo <<EOL
    [chef-<CHANNEL>]
    name=chef-<CHANNEL>
    baseurl=https://<LICENSE_ID>@packages.chef.io/repos/yum/<CHANNEL>/el/<VERSION>/\$basearch/
    gpgcheck=1
    # No auto-upgrade, as there are manual steps needed for Chef Infra Server upgrades
    enabled=0
    EOL
    ```

    Replace:

    - `<LICENSE_ID>` with your license ID.
    - `<CHANNEL>` with the release channel: `stable` or `current`.
    - `<VERSION>` with the Enterprise Linux version.

1. Add the repository to your package manager configuration:

    ```shell
    sudo yum-config-manager --add-repo chef-stable.repo
    ```

1. Pull the repository metadata:

    ```shell
    sudo yum makecache
    ```

### Set up a DNF repository for Enterprise Linux

To set up a DNF package repository for Enterprise Linux, follow these steps:

1. Install the public key for Chef Software:

    ```shell
    sudo rpm --import https://packages.chef.io/chef.asc
    ```

1. Create the DNF repository source file:

    ```shell
    cat >chef-<CHANNEL>.repo <<EOL
    [chef-<CHANNEL>]
    name=chef-<CHANNEL>
    baseurl=https://<LICENSE_ID>@packages.chef.io/repos/yum/<CHANNEL>/el/<VERSION>/$basearch/
    gpgcheck=1
    # No auto-upgrade, as there are manual steps needed for Chef Infra Server upgrades
    enabled=0
    EOL
    ```

    Replace:

    - `<LICENSE_ID>` with your license ID.
    - `<CHANNEL>` with the release channel: `stable` or `current`.
    - `<VERSION>` with the Enterprise Linux version.

1. Add the repository to your package manager configuration:

    ```shell
    sudo dnf config-manager --add-repo chef-stable.repo
    ```

1. Pull the repository metadata:

    ```shell
    sudo dnf makecache
    ```
