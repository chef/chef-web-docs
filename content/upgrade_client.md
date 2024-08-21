+++
title = "Upgrade Chef Infra Client"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/upgrade_client.html"]

[menu]
  [menu.infra]
    title = "Upgrade"
    identifier = "chef_infra/install/upgrade_client.md"
    parent = "chef_infra/install"
    weight = 50
+++

The following sections describe the upgrade process for Chef Infra Client. If you are also [upgrading the Chef Infra Server]({{< relref "/server/upgrades" >}}) complete that process **first** and **then** upgrade the Chef Infra Client.

## Prerequisites

Commercial users must have a license ID. You can get your license ID from the [Chef Downloads portal](https://chef.io/downloads).

For community users, see the [Chef install script documentation](/chef_install_script/).

## Command line upgrades

Use the [Chef install script](/chef_install_script/) to upgrade to the latest version of Chef Infra Client on a node from the command line.

- On Linux, macOS, and Unix-based hosts:

  ```bash
  curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<LICENSE_ID> | sudo bash
  ```

  Replace `<LICENSE_ID>` with your license ID.

- On Windows hosts:

  ```powershell
  . { iwr -useb https://chefdownload-commerical.chef.io/install.ps1?license_id=<LICENSE_ID> } | iex; install
  ```

  Replace `<LICENSE_ID>` with your license ID.

### Specify the install version

You can install a specific version of Chef Infra Client using the [Chef install script](/chef_install_script/).

- Use the `-v` option to install a specific version on Linux, macOS, and Unix-based hosts. For example:

  ```bash
  curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<LICENSE_ID> | sudo bash -s -- -v 17.9.26
  ```

  Replace `<LICENSE_ID>` with your license ID.

- Use the `-version` option to install a specific version on Windows hosts. For example:

  ```powershell
  . { iwr -useb https://chefdownload-commerical.chef.io/install.ps1?license_id=<LICENSE_ID> } | iex; install -version 17.9.26
  ```

  Replace `<LICENSE_ID>` with your license ID.

### Upgrade multiple hosts with knife

You can use the [`knife ssh` command](/workstation/knife_ssh/) in Chef Workstation to execute the install script on multiple Linux, macOS, and Unix-based hosts at once.

```bash
knife ssh <SEARCH_QUERY> 'curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<LICENSE_ID> | sudo bash'
```

Replace:

- `<LICENSE_ID>` with your license ID
- `<SEARCH_QUERY>` with a [node search query](/chef_search/)

## Cookbook-based upgrade

Use the [chef_client_updater cookbook](https://supermarket.chef.io/cookbooks/chef_client_updater) to install or upgrade Chef Infra Client on a node.
