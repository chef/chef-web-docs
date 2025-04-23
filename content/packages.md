+++
title = "Chef Software Packages"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/packages.html"]
product = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

[menu]
  [menu.overview]
    title = "Packages"
    identifier = "overview/packages_&_platforms/packages.md Packages"
    parent = "overview/packages_&_platforms"
    weight = 10
+++

You can install packages for Chef Software products using platform-native package repositories.

## Release channels

{{< readfile file="content/reusable/md/release_channels.md" >}}

## Package repositories

The `stable` and `current` release channels support the following package repositories:

- APT (Debian and Ubuntu platforms)
- Yum (Enterprise Linux platforms)

You can download Chef Software's GPG public key from [packages.chef.io](https://packages.chef.io/chef.asc).

### Debian / Ubuntu

To set up an APT package repository for Debian and Ubuntu platforms:

1. Enable APT to fetch packages over HTTPS:

    ```bash
    sudo apt-get install apt-transport-https
    ```

1. Install the public key for Chef Software:

    ```bash
    wget -qO - https://packages.chef.io/chef.asc | sudo apt-key add -
    ```

1. Create the APT repository source file:

    ```bash
    echo "deb https://packages.chef.io/repos/apt/<CHANNEL> <DISTRIBUTION> main" > chef-<CHANNEL>.list
    ```

    Replace:

    - `<CHANNEL>` with the release channel: `stable` or `current`.
    - `<DISTRIBUTION>` with the appropriate distribution name. For example:

      - for Debian 9: `stretch`
      - for Debian 10: `buster`
      - for Debian 11: `bullseye`
      - for Ubuntu 18.04: `bionic`
      - for Ubuntu 20.04: `focal`

1. Update the package repository list:

    ```bash
    sudo mv chef-stable.list /etc/apt/sources.list.d/
    ```

1. Update the cache for the package repository:

    ```bash
    sudo apt-get update
    ```

### Enterprise Linux

{{< note >}}

Starting in Chef Infra Client 18.6.2, we upgraded the GPG signing algorithm used to sign RHEL packages from SHA1 to SHA256. RHEL 9 no longer supports the less secure SHA1 hashes.

{{< /note >}}

Before you begin, verify that you have the `yum-utils` package installed.

To set up a Yum package repository for Enterprise Linux platforms, follow these steps:

1. Install the public key for Chef Software:

    ```bash
    sudo rpm --import https://packages.chef.io/chef.asc
    ```

1. Create the Yum repository source file:

    ```bash
    cat >chef-<CHANNEL>.repo <<EOL
    [chef-<CHANNEL>]
    name=chef-<CHANNEL>
    baseurl=https://packages.chef.io/repos/yum/<CHANNEL>/el/<VERSION>/\$basearch/
    gpgcheck=1
    # No auto-upgrade, as there are manual steps needed for Chef Infra Server upgrades
    enabled=0
    EOL
    ```

    Replace:

    - `<CHANNEL>` with the release channel: `stable` or `current`.
    - `<VERSION>` with the Enterprise Linux version.

1. Update the package repository list:

    ```bash
    sudo yum-config-manager --add-repo chef-stable.repo
    ```
