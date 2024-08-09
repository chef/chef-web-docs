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

## Command Line Upgrades

To upgrade Chef Infra Client on a node from the command line, run the install script to install the latest Chef Infra Client release:

Please follow steps mentioned in this document [Chef Software Install Script](/install_omnibus/)

Linux, macOS, and Unix-based hosts:

{{< note >}}Please follow steps mentioned in this document [Chef Software Install Script](/install_omnibus/).Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```bash
curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<YOUR LICENSE ID>| sudo bash
```

Windows hosts:

{{< note >}}Please follow steps mentioned in this document [Chef Software Install Script](/install_omnibus/).Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```powershell
. { iwr -useb https://chefdownload-commerical.chef.io/install.ps1?license_id=<YOUR LICENSE ID> } | iex; install
```

### Specifying the Version to Install

The install script accepts arguments to allow installing specific versions of Chef Infra Client on systems.

Linux, macOS, and Unix-based hosts:

{{< note >}}Please follow steps mentioned in this document [Chef Software Install Script](/install_omnibus/). Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```bash
curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<YOUR LICENSE ID> | sudo bash -s -- -v 17.9.26
```

Windows hosts:

{{< note >}}Please follow steps mentioned in this document [Chef Software Install Script](/install_omnibus/). Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```powershell
. { iwr -useb https://chefdownload-commerical.chef.io/install.ps1?license_id=<YOUR LICENSE ID1> } | iex; install -version 17.9.26
```

### Upgrading Multiple Hosts with Knife

The `knife ssh` command in Chef Workstation can be used to execute the install script on multiple Linux, macOS, and Unix-based hosts at once:

{{< note >}}Please follow steps mentioned in this document [Chef Software Install Script](/install_omnibus/). Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```bash
knife ssh 'name:*' 'curl -L https://chefdownload-commerical.chef.io/install.sh?license_id=<YOUR LICENSE ID> | sudo bash'
```

## Cookbook-Based Upgrade

The [chef_client_updater](https://supermarket.chef.io/cookbooks/chef_client_updater) cookbook can be used to install or upgrade Chef Infra Client package on a node.
