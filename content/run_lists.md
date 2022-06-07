+++
title = "About Run-lists"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/run_lists.html"]
product = ["client", "server"]

[menu]
  [menu.infra]
    title = "Run-lists"
    identifier = "chef_infra/policyfiles/run_lists.md Run-lists"
    parent = "chef_infra/policyfiles"
    weight = 50
+++
<!-- markdownlint-disable-file MD024 -->
{{% node_run_list %}}

## Run-list Format

{{% node_run_list_format %}}

### Empty Run-lists

{{% node_run_list_empty %}}

## Knife Commands

The following knife commands may be used to manage run-lists on the Chef
Infra Server.

### Quotes, Windows

{{% chef-workstation/knife_common_windows_quotes %}}

#### Import-Module chef

{{% chef-workstation/knife_common_windows_quotes_module %}}

### run_list add

{{% chef-workstation/knife_node_run_list_add %}}

{{% node_run_list_format %}}

#### Syntax

{{% chef-workstation/knife_node_run_list_add_syntax %}}

#### Options

{{% chef-workstation/knife_node_run_list_add_options %}}

{{< note >}}

{{% chef-workstation/knife_common_see_all_config_options %}}

{{< /note >}}

#### Examples

The following examples show how to use this knife subcommand:

##### Add a role

{{% chef-workstation/knife_node_run_list_add_role %}}

##### Add roles and recipes

{{% chef-workstation/knife_node_run_list_add_roles_and_recipes %}}

##### Add a recipe with a FQDN

{{% chef-workstation/knife_node_run_list_add_recipe_with_fqdn %}}

##### Add a recipe with a cookbook

{{% chef-workstation/knife_node_run_list_add_recipe_with_cookbook %}}

##### Add the default recipe

{{% chef-workstation/knife_node_run_list_add_default_recipe %}}

### run_list remove

{{% chef-workstation/knife_node_run_list_remove %}}

#### Syntax

{{% chef-workstation/knife_node_run_list_remove_syntax %}}

#### Options

This command does not have any specific options.

{{< note >}}

{{% chef-workstation/knife_common_see_all_config_options %}}

{{< /note >}}

#### Examples

The following examples show how to use this knife subcommand:

##### Remove a role

{{% chef-workstation/knife_node_run_list_remove_role %}}

##### Remove a run-list

{{% chef-workstation/knife_node_run_list_remove_run_list %}}

### run_list set

{{% chef-workstation/knife_node_run_list_set %}}

#### Syntax

{{% chef-workstation/knife_node_run_list_set_syntax %}}

#### Options

This command does not have any specific options.

#### Examples

None.

### status

The following examples show how to use the `knife status` subcommand to
verify the status of run-lists.

#### View status, include run-lists

{{% chef-workstation/knife_status_include_run_lists %}}

#### View status using a query

{{% chef-workstation/knife_status_returned_by_query %}}

## Run-lists, Applied

A run-list will tell Chef Infra Client what to do when bootstrapping
that node for the first time, and then how to configure that node on
every subsequent Chef Infra Client run.

### Bootstrap Operations

{{% install_chef_client %}}

{{% chef_client_bootstrap_node %}}

{{% chef_client_bootstrap_stages %}}

### The Chef Infra Client Run

{{% chef_client_run %}}
