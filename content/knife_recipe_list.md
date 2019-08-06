+++
title = "knife recipe list"
description = "DESCRIPTION"
draft = false

aliases = "/knife_recipe_list.html"

[menu]
  [menu.docs]
    title = "knife recipe list"
    identifier = "chef_infra/chefdk/knife/knife_recipe_list.html knife recipe list"
    parent = "chef_infra/chefdk/knife"
    weight = 210
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_recipe_list.rst)

{{% knife_recipe_list_summary %}}

Syntax
======

This subcommand has the following syntax:

``` bash
$ knife recipe list REGEX
```

Options
=======

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

{{% knife_common_see_common_options_link %}}

</div>

This command does not have any specific options.

Examples
========

The following examples show how to use this knife subcommand:

**View a list of recipes**

To view a list of recipes:

``` bash
$ knife recipe list 'couchdb::*'
```

to return:

``` bash
couchdb::main_monitors
couchdb::master
couchdb::default
couchdb::org_cleanup
```
