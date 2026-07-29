+++
title = "knife recipe list"
draft = false



[menu]
  [menu.workstation_25]
    title = "knife recipe list"
    identifier = "workstation_25/tools/knife/knife_recipe_list.md knife recipe list"
    parent = "workstation_25/tools/knife"
+++
<!-- markdownlint-disable-file MD036 -->

{{< readfile file="content/workstation/25/reusable/md/knife_recipe_list_summary.md" >}}

## Syntax

This subcommand has the following syntax:

```bash
knife recipe list REGEX
```

## Options

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_see_common_options_link.md" >}}

{{< /note >}}

This command doesn't have any specific options.

## Examples

The following examples show how to use this knife subcommand:

**View a list of recipes**

To view a list of recipes:

```bash
knife recipe list 'couchdb::*'
```

to return:

```bash
couchdb::main_monitors
couchdb::master
couchdb::default
couchdb::org_cleanup
```
