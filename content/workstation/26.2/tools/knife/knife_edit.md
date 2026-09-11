+++
title = "knife edit"
draft = false



[menu]
  [menu.workstation_26_2]
    title = "knife edit"
    identifier = "workstation_26_2/tools/knife/reference/knife_edit.md knife edit"
    parent = "workstation_26_2/tools/knife/reference"
+++

{{< readfile file="content/workstation/26.2/reusable/md/knife_edit_summary.md" >}}

## Syntax

This subcommand has the following syntax:

```bash
knife edit (options)
```

## Options

{{< note >}}

{{< readfile file="content/workstation/26.2/reusable/md/knife_common_see_common_options_link.md" >}}

{{< /note >}}

This subcommand has the following options:

`--chef-repo-path PATH`

: The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by `chef_repo_path` in client.rb.

`--concurrency`

: The number of allowed concurrent connections. Default: `10`.

`--local`

: Show files in the local chef-repo instead of a remote location. Default: `false`.

`--repo-mode MODE`

: The layout of the local chef-repo. Possible values: `static`, `everything`, or `hosted_everything`. Use `static` for just roles, environments, cookbooks, and data bags. By default, `everything` and `hosted_everything` are dynamically selected depending on the server type. Default: `everything` / `hosted_everything`.

{{< note >}}

{{< readfile file="content/workstation/26.2/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

## Examples

The following examples show how to use this knife subcommand:

### Remove a user from /groups/admins.json

A user who belongs to the `admins` group must be removed from the group
before they may be removed from an organization. To remove a user from
the `admins` group, run the following:

```bash
EDITOR=vi knife edit /groups/admins.json
```

make the required changes, and then save the file.
