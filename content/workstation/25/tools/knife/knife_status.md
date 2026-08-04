+++
title = "knife status"
draft = false



[menu]
  [menu.workstation_25]
    title = "knife status"
    identifier = "workstation_25/tools/knife/knife_status.md knife status"
    parent = "workstation_25/tools/knife"
+++
<!-- markdownlint-disable-file MD036 -->

{{< readfile file="content/workstation/25/reusable/md/knife_status_summary.md" >}}

## Syntax

This subcommand has the following syntax:

```bash
knife status (options)
```

## Options

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_see_common_options_link.md" >}}

{{< /note >}}

This subcommand has the following options:

`QUERY`

: The search query used to identify a list of items on a Chef Infra Server. This option uses the same syntax as the `search` subcommand.

`--hide-by-mins`

: Hide nodes that have performed a successful Chef Infra Client run within the last specified number of minutes. The number of minutes to hide is provided as an integer, such as `--hide-by-mins 10`.

`-l`, `--long`

: Display all attributes in the output and show the output as JSON.

`-m`, `--medium`

: Display normal attributes in the output and to show the output as
    JSON.

`-r RUN_LIST`, `--run-list RUN_LIST`

: A comma-separated list of roles and/or recipes to be applied.

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

## Examples

The following examples show how to use this knife subcommand:

**View status, include run-lists**

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

**View status using a time range**

To show the status of nodes on which Chef Infra Client didn't run
successfully within the past hour, enter:

```bash
knife status --hide-by-mins 60
```

to return something like:

```bash
422492 hours ago, runner-1-432.lxc, centos 6.8.
27 hours ago, union-3-432.lxc, centos 7.3.1611.
```

**View status using a query**

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

**View status for all nodes**

To view the status of all nodes in the organization, enter:

```bash
knife status
```

to return something like:

```bash
20 hours ago, dev-vm.chisamore.com, ubuntu 10.04, dev-vm.chisamore.com, 10.66.44.126
3 hours ago, i-225f954f, ubuntu 10.04, ec2-67-202-63-102.compute-1.amazonaws.com, 67.202.63.102
3 hours ago, i-a45298c9, ubuntu 10.04, ec2-174-129-127-206.compute-1.amazonaws.com, 174.129.127.206
3 hours ago, i-5272a43f, ubuntu 10.04, ec2-184-73-9-250.compute-1.amazonaws.com, 184.73.9.250
3 hours ago, i-226ca64f, ubuntu 10.04, ec2-75-101-240-230.compute-1.amazonaws.com, 75.101.240.230
3 hours ago, i-f65c969b, ubuntu 10.04, ec2-184-73-60-141.compute-1.amazonaws.com, 184.73.60.141
```
