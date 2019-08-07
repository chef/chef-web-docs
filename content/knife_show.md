+++
title = "knife show"
description = "DESCRIPTION"
draft = false

aliases = "/knife_show.html"

[menu]
  [menu.docs]
    title = "knife show"
    identifier = "chef_infra/chefdk/knife/knife_show.html knife show"
    parent = "chef_infra/chefdk/knife"
    weight = 250
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_show.rst)

{{% knife_show_summary %}}

Syntax
======

This subcommand has the following syntax:

``` bash
$ knife show [PATTERN...] (options)
```

Options
=======

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

{{% knife_common_see_common_options_link %}}

</div>

This subcommand has the following options:

`-a ATTR`, `--attribute ATTR`

:   The attribute (or attributes) to show.

`--chef-repo-path PATH`

:   The path to the chef-repo. This setting will override the default
    path to the chef-repo. Default: same value as specified by
    `chef_repo_path` in client.rb.

`--concurrency`

:   The number of allowed concurrent connections. Default: `10`.

`--local`

:   Show local files instead of remote files.

`--repo-mode MODE`

:   The layout of the local chef-repo. Possible values: `static`,
    `everything`, or `hosted_everything`. Use `static` for just roles,
    environments, cookbooks, and data bags. By default, `everything` and
    `hosted_everything` are dynamically selected depending on the server
    type. Default: `everything` / `hosted_everything`.

`-S SEPARATOR`, `--field-separator SEPARATOR`

:   Character separator used to delineate nesting in --attribute
    filters. For example, to use a colon as the delimiter, specify `-S:`
    in your `knife node show` subcommand. Default is `.`

Examples
========

The following examples show how to use this knife subcommand:

**Show all cookbooks**

To show all cookbooks in the `cookbooks/` directory:

``` bash
$ knife show cookbooks/
```

or, (if already in the `cookbooks/` directory in the local chef-repo):

``` bash
$ knife show
```

**Show roles and environments**

``` bash
$ knife show roles/ environments/
```
