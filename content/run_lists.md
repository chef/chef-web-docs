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
{{< readfile file="content/reusable/md/node_run_list.md" >}}

## Run-list Format

{{< readfile file="content/reusable/md/node_run_list_format.md" >}}

### Empty Run-lists

{{< readfile file="content/reusable/md/node_run_list_empty.md" >}}

## Knife Commands

The following knife commands may be used to manage run-lists on the Chef
Infra Server.

### Quotes, Windows

{{< readfile file="content/workstation/reusable/md/knife_common_windows_quotes.md" >}}

#### Import-Module chef

{{< readfile file="content/workstation/reusable/md/knife_common_windows_quotes_module.md" >}}

### run_list add

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_add.md" >}}

{{< readfile file="content/reusable/md/node_run_list_format.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_add_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_add_options.md" >}}

{{< note >}}

{{< readfile file="content/workstation/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

#### Examples

The following examples show how to use this knife subcommand:

##### Add a role

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_add_role.md" >}}

##### Add roles and recipes

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_add_roles_and_recipes.md" >}}

##### Add a recipe with a FQDN

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_add_recipe_with_fqdn.md" >}}

##### Add a recipe with a cookbook

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_add_recipe_with_cookbook.md" >}}

##### Add the default recipe

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_add_default_recipe.md" >}}

### run_list remove

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_remove.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_remove_syntax.md" >}}

#### Options

This command does not have any specific options.

{{< note >}}

{{< readfile file="content/workstation/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

#### Examples

The following examples show how to use this knife subcommand:

##### Remove a role

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_remove_role.md" >}}

##### Remove a run-list

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_remove_run_list.md" >}}

### run_list set

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_set.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/knife_node_run_list_set_syntax.md" >}}

#### Options

This command does not have any specific options.

#### Examples

None.

### status

The following examples show how to use the `knife status` subcommand to
verify the status of run-lists.

#### View status, include run-lists

{{< readfile file="content/workstation/reusable/md/knife_status_include_run_lists.md" >}}

#### View status using a query

{{< readfile file="content/workstation/reusable/md/knife_status_returned_by_query.md" >}}

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
