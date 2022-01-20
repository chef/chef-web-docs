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
curl -L https://chef.io/chef/install.sh | sudo bash
```

Windows hosts:

```powershell
. { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install
```

### Specifying the Version to Install

The install script accepts arguments to allow installing specific versions of Chef Infra Client on systems.

Linux, macOS, and Unix-based hosts:

```bash
curl -L https://chef.io/chef/install.sh | sudo bash -s -- -v 17.9.26
```

Windows hosts:

```powershell
. { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install -version 17.9.26
```

### Upgrading Multiple Hosts with Knife

The `knife ssh` command in Chef Workstation can be used to execute the install script on multiple Linux, macOS, and Unix-based hosts at once:

```bash
knife ssh 'name:*' 'curl -L https://chef.io/chef/install.sh | sudo bash'
```

## Cookbook Upgrade

The [chef_client_updater](https://supermarket.chef.io/cookbooks/chef_client_updater)
cookbook can be used to install or upgrade Chef Infra Client package on a node.

## Upgrade Preparation

Preparing your Chef Infra Client system before upgrading to Chef Infra Server will improve your Chef experience.

During a Chef Infra Server upgrade, the node data is:

1. Extracted
1. Converted to a new format
1. Uploaded

A large amount of data (cookbooks, nodes, etc.,) increases the duration of the upgrade process and extends your downtime.

Managing your data before upgrading will improve experience upgrading and using Chef Infra Server and Chef Infra Client. This list of client-based tasks before upgrading will expedite the upgrade process and mitigate many common issues.

### Prep Steps

1. Install the version of Chef Infra Client you plan on using after the upgrade on a small number of test nodes and verify that:

    - All nodes can authenticate and converge successfully.
    - Custom Ohai plugins still work as expected.
    - Custom Handlers still work as expected.

1. Ensure that the cookbooks used by your organization are correctly located and identified:

    - Do all cookbooks used by your organization exist in source control? Upload any missing cookbooks and dependencies.
    - Do all cookbooks have a `metadata.rb` or `metadata.json` file?
    - Delete unused cookbook versions. First, run `knife cookbook list` to view a list of cookbooks. Next, for each cookbook, run `knife cookbook show COOKBOOK_NAME` to view its versions. Then, delete each unused version with `knife cookbook delete -v VERSION_NAME`.

1. Download all cookbooks and validate the following against each cookbook:

    - Run `egrep -L ^name */metadata.rb`. Does each have a `metadata.rb` file?
    - Does the cookbook name in the `metadata.rb` file match the name in the run-list? (Some older versions of Chef Infra Client used the cookbook name for the run-list based on the directory name of the cookbook and not the cookbook_name in the `metadata.rb` file.)

1. Cook as lean as possible:

    - Verify cookbook size and mitigate the size of large cookbooks where possible. Most cookbooks are quite small, under ~200 KB. For any cookbook over 200 KB, consider why they are that large. Are there binary files?
    - Clean up `git` history for any cookbook found to be excessively large.

1. Verify nodes and clients that are in use:

    - Are all nodes and/or clients in use? Clean up any extra nodes and clients. Use the `knife node list`, `knife client list`, and [knife status](/workstation/knife_status/) commands to verify nodes and clients in use.
    - Use the `knife client delete` command to remove unused clients. Use the ``knife node delete\`\` command to remove unused nodes.

Run the test nodes against the Chef Infra Server. If you are also upgrading the Chef Infra Server complete that process **first** and **then** verify the test nodes against the upgraded Chef Infra Server.
