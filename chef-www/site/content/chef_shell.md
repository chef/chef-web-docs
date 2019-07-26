+++
title = "chef-shell (executable)"
description = "DESCRIPTION"
draft = false

aliases = "/chef_shell.html"

[menu]
  [menu.docs]
    title = "chef-shell (executable)"
    identifier = "chef-shell (executable)/chef_shell.html"
    parent = "chef infra/chefdk"
    weight = 30
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ctl_chef_shell.rst)

{{% chef_shell_summary %}}

The chef-shell executable is run as a command-line tool.

Modes
=====

{{% chef_shell_modes %}}

Options
=======

This command has the following syntax:

``` bash
chef-shell OPTION VALUE OPTION VALUE ...
```

This command has the following options:

`-a`, `--standalone`

:   Run chef-shell in standalone mode.

`-c CONFIG`, `--config CONFIG`

:   The configuration file to use.

`-h`, `--help`

:   Show help for the command.

`-j PATH`, `--json-attributes PATH`

:   The path to a file that contains JSON data.

    {{% node_ctl_run_list %}}

    <div class="warning" markdown="1">

    <div class="admonition-title" markdown="1">

    Warning

    </div>

    {{% node_ctl_attribute %}}

    </div>

`-l LEVEL`, `--log-level LEVEL`

:   The level of logging to be stored in a log file.

`-s`, `--solo`

:   Run chef-shell in chef-solo mode.

`-S CHEF_SERVER_URL`, `--server CHEF_SERVER_URL`

:   The URL for the Chef Infra Server.

`-v`, `--version`

:   The Chef Infra Client version.

`-z`, `--client`

:   Run chef-shell in Chef Infra Client mode.

Configure
=========

{{% chef_shell_config %}}

chef-shell.rb
-------------

{{% chef_shell_config_rb %}}

Run as a Chef Infra Client
--------------------------

{{% chef_shell_run_as_chef_client %}}

Manage
======

{{% chef_shell_manage %}}

Use Breakpoints
===============

{{% chef_shell_breakpoints %}}

Step Through Run-list
---------------------

{{% chef_shell_step_through_run_list %}}

Debug Existing Recipe
---------------------

{{% chef_shell_debug_existing_recipe %}}

Advanced Debugging
------------------

{{% chef_shell_advanced_debug %}}

Examples
========

The following examples show how to use chef-shell.

"Hello World"
-------------

{{% chef_shell_example_hello_world %}}

Get Specific Nodes
------------------

{{% chef_shell_example_get_specific_nodes %}}
