+++
title = "knife tag"
draft = false



[menu]
  [menu.workstation_25]
    title = "knife tag"
    identifier = "workstation_25/tools/knife/knife_tag.md knife tag"
    parent = "workstation_25/tools/knife"
+++
<!-- markdownlint-disable-file MD024 MD036 -->

A tag is a custom description that's applied to a node.
A tag, once applied, can be helpful when managing nodes using knife or when building recipes by providing alternate methods of grouping similar types of information.

{{< readfile file="content/workstation/25/reusable/md/knife_tag_summary.md" >}}

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_see_common_options_link.md" >}}

{{< /note >}}

## create

Use the `create` argument to add one or more tags to a node.

### Syntax

This argument has the following syntax:

```bash
knife tag create NODE_NAME [TAG...]
```

### Options

This command doesn't have any specific options.

### Examples

The following examples show how to use this knife subcommand:

**Create tags**

To create tags named `seattle`, `portland`, and `vancouver`, enter:

```bash
knife tag create node seattle portland vancouver
```

## delete

Use the `delete` argument to delete one or more tags from a node.

### Syntax

This argument has the following syntax:

```bash
knife tag delete NODE_NAME [TAG...]
```

### Options

This command doesn't have any specific options.

### Examples

The following examples show how to use this knife subcommand:

**Delete tags**

To delete tags named `denver` and `phoenix`, enter:

```bash
knife tag delete node denver phoenix
```

Type `Y` to confirm a deletion.

## list

Use the `list` argument to list the tags that have been applied
to a node.

### Syntax

This argument has the following syntax:

```bash
knife tag list [NODE_NAME...]
```

### Options

This command doesn't have any specific options.

### Examples

The following examples show how to use this knife subcommand:

**View a list of tags**

To view the tags for a node named `devops_prod1`, enter:

```bash
knife tag list devops_prod1
```
