+++
title = "knife list"
draft = false



[menu]
  [menu.workstation_26_2]
    title = "knife list"
    identifier = "workstation_26_2/tools/knife/reference/knife_list.md knife list"
    parent = "workstation_26_2/tools/knife/reference"
+++
<!-- markdownlint-disable-file MD036 -->

{{< readfile file="content/workstation/26.2/reusable/md/knife_list_summary.md" >}}

## Syntax

This subcommand has the following syntax:

```bash
knife list [PATTERN...] (options)
```

## Options

{{< note >}}

{{< readfile file="content/workstation/26.2/reusable/md/knife_common_see_common_options_link.md" >}}

{{< /note >}}

This subcommand has the following options:

`-1`

: Show only one column of results. Default: `false`.

`--chef-repo-path PATH`

: The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by `chef_repo_path` in client.rb.

`--concurrency`

: The number of allowed concurrent connections. Default: `10`.

`-d`

: Prevent a directory's children from showing when a directory matches a pattern. Default value: `false`.

`-f`, `--flat`

: Show a list of file names. Set to `false` to view `ls`-like output. Default: `false`.

`--local`

: Return only the contents of the local directory. Default: `false`.

`-p`

: Show directories with trailing slashes (/). Default: `false`.

`-R`

: List directories recursively. Default: `false`.

`--repo-mode MODE`

: The layout of the local chef-repo. Possible values: `static`, `everything`, or `hosted_everything`. Use `static` for just roles, environments, cookbooks, and data bags. By default, `everything` and `hosted_everything` are dynamically selected depending on the server type. Default: `everything` / `hosted_everything`.

{{< note >}}

{{< readfile file="content/workstation/26.2/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

## Examples

The following examples show how to use this knife subcommand:

**List roles**

For example, to view a list of roles on Chef Infra Server:

```bash
knife list roles/
```

**List roles and environments**

To view a list of roles and environments on Chef Infra Server:

```bash
knife list roles/ environments/
```

**List everything**

To view a list of absolutely everything on Chef Infra Server:

```bash
knife list -R /
```
