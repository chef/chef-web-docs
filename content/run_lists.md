+++
title = "About Run-lists"
draft = false
gh_repo = "chef-web-docs"

product = ["client", "server"]

[menu]
  [menu.infra]
    title = "Run-lists"
    identifier = "chef_infra/policyfiles/run_lists.md Run-lists"
    parent = "chef_infra/policyfiles"
    weight = 50
+++
<!-- markdownlint-disable-file MD024 -->
{{< readfile file="content/reusable/md/node_run_list.md" >}}

## Run-list Format

{{< readfile file="content/reusable/md/node_run_list_format.md" >}}

### Empty Run-lists

{{< readfile file="content/reusable/md/node_run_list_empty.md" >}}

## Knife Commands

The following knife commands may be used to manage run-lists on the Chef
Infra Server.

### Quotes, Windows

When running knife in Windows, a string may be interpreted as
a wildcard pattern when quotes are not present in the command. The
number of quotes to use depends on the shell from which the command is
being run.

When running knife from the command prompt, a string should be
surrounded by single quotes (`' '`). For example:

```bash
knife node run_list set test-node 'recipe[iptables]'
```

When running knife from Windows PowerShell, a string should be
surrounded by triple single quotes (`''' '''`). For example:

```bash
knife node run_list set test-node '''recipe[iptables]'''
```

#### Import-Module chef

The Chef Infra Client 12.4 release adds an optional feature to the Microsoft
Installer Package (MSI) for Chef. This feature enables the ability to
pass quoted strings from the Windows PowerShell command line without the
need for triple single quotes (`''' '''`). This feature installs a
Windows PowerShell module (typically in `C:\opscode\chef\modules`) that
is also appended to the `PSModulePath` environment variable. This
feature isn't enabled by default. To activate this feature, run the
following command from within Windows PowerShell:

```bash
Import-Module chef
```

or add `Import-Module chef` to the profile for Windows PowerShell
located at:

```bash
~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
```

This module exports cmdlets that have the same name as the command-line
tools---chef-client, knife---that are built into Chef.

For example:

```bash
knife exec -E 'puts ARGV' """&s0meth1ng"""
```

is now:

```bash
knife exec -E 'puts ARGV' '&s0meth1ng'
```

and:

```bash
knife node run_list set test-node '''role[ssssssomething]'''
```

is now:

```bash
knife node run_list set test-node 'role[ssssssomething]'
```

To remove this feature, run the following command from within Windows
PowerShell:

```bash
Remove-Module chef
```

### run_list add

Use the `run_list add` argument to add run-list items (roles or recipes)
to a node.

{{< readfile file="content/reusable/md/node_run_list_format.md" >}}

#### Syntax

This argument has the following syntax:

```bash
knife node run_list add NODE_NAME RUN_LIST_ITEM (options)
```

#### Options

This argument has the following options:

`-a ITEM`, `--after ITEM`

:   Add a run-list item after the specified run-list item.

`-b ITEM`, `--before ITEM`

:   Add a run-list item before the specified run-list item.

{{< note >}}

{{< readfile file="content/workstation/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

#### Examples

The following examples show how to use this knife subcommand:

##### Add a role

To add a role to a run-list, enter:

```bash
knife node run_list add NODE_NAME 'role[ROLE_NAME]'
```

##### Add roles and recipes

To add roles and recipes to a run-list, enter:

```bash
knife node run_list add NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME],recipe[COOKBOOK::RECIPE_NAME],role[ROLE_NAME]'
```

##### Add a recipe with a FQDN

To add a recipe to a run-list using the fully qualified format, enter:

```bash
knife node run_list add NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME]'
```

##### Add a recipe with a cookbook

To add a recipe to a run-list using the cookbook format, enter:

```bash
knife node run_list add NODE_NAME 'COOKBOOK::RECIPE_NAME'
```

##### Add the default recipe

To add the default recipe of a cookbook to a run-list, enter:

```bash
knife node run_list add NODE_NAME 'COOKBOOK'
```

### run_list remove

Use the `run_list remove` argument to remove run-list items (roles or
recipes) from a node. A recipe must be in one of the following formats:
fully qualified, cookbook, or default. Both roles and recipes must be in
quotes, for example: `'role[ROLE_NAME]'` or
`'recipe[COOKBOOK::RECIPE_NAME]'`. Use a comma to separate roles and
recipes when removing more than one, like this:
`'recipe[COOKBOOK::RECIPE_NAME],COOKBOOK::RECIPE_NAME,role[ROLE_NAME]'`.

#### Syntax

This argument has the following syntax:

```bash
knife node run_list remove NODE_NAME RUN_LIST_ITEM
```

#### Options

This command doesn't have any specific options.

{{< note >}}

{{< readfile file="content/workstation/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

#### Examples

The following examples show how to use this knife subcommand:

##### Remove a role

To remove a role from a run-list, enter:

```bash
knife node run_list remove NODE_NAME 'role[ROLE_NAME]'
```

##### Remove a run-list

To remove a recipe from a run-list using the fully qualified format,
enter:

```bash
knife node run_list remove NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME]'
```

### run_list set

Use the `run_list set` argument to set the run-list for a node. A recipe
must be in one of the following formats: fully qualified, cookbook, or
default. Both roles and recipes must be in quotes, for example:
`"role[ROLE_NAME]"` or `"recipe[COOKBOOK::RECIPE_NAME]"`. Use a comma to
separate roles and recipes when setting more than one, like this:
`"recipe[COOKBOOK::RECIPE_NAME],COOKBOOK::RECIPE_NAME,role[ROLE_NAME]"`.

#### Syntax

This argument has the following syntax:

```bash
knife node run_list set NODE_NAME RUN_LIST_ITEM
```

#### Options

This command doesn't have any specific options.

#### Examples

None.

### status

The following examples show how to use the `knife status` subcommand to
verify the status of run-lists.

#### View status, include run-lists

To include run-lists in the status, enter:

```bash
knife status --run-list
```

to return something like:

```bash
20 hours ago, dev-vm.chisamore.com, ubuntu 10.04, dev-vm.chisamore.com, 10.66.44.126, role[lb].
3 hours ago, i-225f954f, ubuntu 10.04, ec2-67-202-63-102.compute-1.amazonaws.com, 67.202.63.102, role[web].
3 hours ago, i-a45298c9, ubuntu 10.04, ec2-174-129-127-206.compute-1.amazonaws.com, 174.129.127.206, role[web].
3 hours ago, i-5272a43f, ubuntu 10.04, ec2-184-73-9-250.compute-1.amazonaws.com, 184.73.9.250, role[web].
3 hours ago, i-226ca64f, ubuntu 10.04, ec2-75-101-240-230.compute-1.amazonaws.com, 75.101.240.230, role[web].
3 hours ago, i-f65c969b, ubuntu 10.04, ec2-184-73-60-141.compute-1.amazonaws.com, 184.73.60.141, role[web].
```

#### View status using a query

To show the status of a subset of nodes that are returned by a specific
query, enter:

```bash
knife status "role:web" --run-list
```

to return something like:

```bash
3 hours ago, i-225f954f, ubuntu 10.04, ec2-67-202-63-102.compute-1.amazonaws.com, 67.202.63.102, role[web].
3 hours ago, i-a45298c9, ubuntu 10.04, ec2-174-129-127-206.compute-1.amazonaws.com, 174.129.127.206, role[web].
3 hours ago, i-5272a43f, ubuntu 10.04, ec2-184-73-9-250.compute-1.amazonaws.com, 184.73.9.250, role[web].
3 hours ago, i-226ca64f, ubuntu 10.04, ec2-75-101-240-230.compute-1.amazonaws.com, 75.101.240.230, role[web].
3 hours ago, i-f65c969b, ubuntu 10.04, ec2-184-73-60-141.compute-1.amazonaws.com, 184.73.60.141, role[web].
```

## Run-lists, Applied

A run-list will tell Chef Infra Client what to do when bootstrapping
that node for the first time, and then how to configure that node on
every subsequent Chef Infra Client run.

### Bootstrap Operations

{{< readfile file="content/reusable/md/install_chef_client.md" >}}

{{< readfile file="content/reusable/md/chef_client_bootstrap_node.md" >}}

{{< readfile file="content/reusable/md/chef_client_bootstrap_stages.md" >}}

### The Chef Infra Client Run

{{< readfile file="content/reusable/md/chef_client_run.md" >}}
