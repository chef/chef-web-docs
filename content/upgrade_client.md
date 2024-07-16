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

Linux, macOS, and Unix-based hosts:

```bash
{{< readfile file="content/chef_install_script.md" >}}
```

Windows hosts:

```powershell
{{< readfile file="content/chef_install_script.md" >}}
```

### Specifying the Version to Install

The install script accepts arguments to allow installing specific versions of Chef Infra Client on systems.

Linux, macOS, and Unix-based hosts:

```bash
{{< readfile file="content/chef_install_script.md" >}}
```

Windows hosts:

```powershell
. { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install -version 17.9.26
```

### Upgrading Multiple Hosts with Knife

The `knife ssh` command in Chef Workstation can be used to execute the install script on multiple Linux, macOS, and Unix-based hosts at once:

```bash
{{< readfile file="content/chef_install_script.md" >}}
```

## Cookbook-Based Upgrade

The [chef_client_updater](https://supermarket.chef.io/cookbooks/chef_client_updater) cookbook can be used to install or upgrade Chef Infra Client package on a node.
