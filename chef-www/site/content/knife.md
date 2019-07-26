+++
title = "About Knife"
description = "DESCRIPTION"
draft = false

aliases = "/knife.html"

[menu]
  [menu.docs]
    title = "About Knife"
    identifier = "about knife/knife.html"
    parent = "chefdk/knife"
    weight = 10
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife.rst)

{{% knife_summary %}}

The Knife Quick Reference provides an all-in-one quick reference of
knife commands. You can view the
[overview](https://github.com/chef/quick-reference/blob/master/qr_knife_web.png)
or download the [source files](https://github.com/chef/quick-reference).

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Topic</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="/knife_setup.html">Setting up Knife</a></td>
<td>Configure knife to interact with your organization's Chef Infra Server and infrastructure.</td>
</tr>
<tr class="even">
<td><a href="/knife_options.html">Knife Common Options</a></td>
<td>Common options that are available for all knife subcommands.</td>
</tr>
<tr class="odd">
<td><a href="/config_rb.html">config.rb</a></td>
<td>Common options for the <code>config.rb</code> (knife.rb) file</td>
</tr>
<tr class="even">
<td><a href="/config_rb_optional_settings.html">config.rb Optional Settings</a></td>
<td>Additional options for your <code>config.rb</code> file</td>
</tr>
</tbody>
</table>

Knife Subcommands
=================

knife includes a collection of built in subcommands that work together
to provide all of the functionality required to take specific actions
against any object in an organization, including cookbooks, nodes,
roles, data bags, environments, and users.

Knife Command Syntax
--------------------

All knife subcommands have the following syntax:

``` bash
knife subcommand [ARGUMENT] (options)
```

Each subcommand has its own set of arguments and options.

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

All syntax examples in this document show variables in ALL_CAPS. For
example `-u PORT_LIST` (where PORT_LIST is a comma-separated list of
local and public UDP ports) or `-F FORMAT` (where FORMAT determines the
output format, either `summary`, `text`, `json`, `yaml`, or `pp`). These
variables often require specific values that are unique to each
organization.

</div>

Built-in Subcommands
--------------------

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Subcommand</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="/knife_bootstrap.html">knife_bootstrap</a></td>
<td>{{% knife_bootstrap_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_client.html">knife_client</a></td>
<td>{{% knife_client_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_configure.html">knife configure</a></td>
<td>{{% knife_configure_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_cookbook.html">knife cookbook</a></td>
<td>{{% knife_cookbook_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_data_bag.html">knife data bag</a></td>
<td>{{% knife_data_bag_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_delete.html">knife delete</a></td>
<td>{{% knife_delete_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_deps.html">knife deps</a></td>
<td>{{% knife_deps_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_diff.html">knife diff</a></td>
<td>{{% knife_diff_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_download.html">knife download</a></td>
<td>{{% knife_download_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_edit.html">knife edit</a></td>
<td>{{% knife_edit_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_environment.html">knife environment</a></td>
<td>{{% knife_environment_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_exec.html">knife exec</a></td>
<td>{{% knife_exec_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_list.html">knife list</a></td>
<td>{{% knife_list_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_node.html">knife node</a></td>
<td>{{% knife_node_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_raw.html">knife raw</a></td>
<td>{{% knife_raw_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_recipe_list.html">knife recipe list</a></td>
<td>{{% knife_recipe_list_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_role.html">knife role</a></td>
<td>{{% knife_role_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_search.html">knife search</a></td>
<td>{{% knife_search_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_serve.html">knife serve</a></td>
<td>{{% knife_serve_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_show.html">knife show</a></td>
<td>{{% knife_show_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_ssh.html">knife ssh</a></td>
<td>{{% knife_ssh_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_ssl_check.html">knife ssl check</a></td>
<td>{{% knife_ssl_check_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_ssl_fetch.html">knife ssl fetch</a></td>
<td>{{% knife_ssl_fetch_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_status.html">knife status</a></td>
<td>{{% knife_status_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_tag.html">knife tag</a></td>
<td>{{% knife_tag_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_supermarket.html">knife supermarket</a></td>
<td>Use the <code>knife supermarket</code> subcommand to interact with cookbooks that are available in the <a href="https://supermarket.chef.io/">Chef Supermarket</a>. A user account is required for any community actions that write data to this site. The following arguments do not require a user account: <code>download</code>, <code>search</code>, <code>install</code>, and <code>list</code>.</td>
</tr>
<tr class="odd">
<td><a href="/knife_upload.html">knife upload</a></td>
<td>{{% knife_upload_summary %}}</td>
</tr>
<tr class="even">
<td><a href="/knife_user.html">knife user</a></td>
<td>{{% knife_user_summary %}}</td>
</tr>
<tr class="odd">
<td><a href="/knife_xargs.html">knife xargs</a></td>
<td>{{% knife_xargs_summary %}}</td>
</tr>
</tbody>
</table>

Verb Subcommands
----------------

knife includes a set of subcommands that are built around common verbs:
`delete`, `deps`, `diff`, `download`, `edit`, `list`, `show`, `upload`,
`xargs`. These subcommands allow knife to issue commands that interact
with any object stored in the chef-repo or stored on the Chef Infra
Server. Some important principles behind this group of subcommands
includes:

-   A command that works with each object in the chef-repo. The
    subcommands specify the desired action (the "verb"), and then
    directory in which that object resides (`clients`, `cookbooks/`,
    `data_bags/`, `environments/`, `nodes`, `roles/`, and `users`). For
    example: `download cookbooks/`
-   A command that works with certain objects in the Chef Infra Server,
    including `acls`, `groups`, and `containers`
-   Uses the Chef Infra Server as if it were a file system, allowing the
    chef-repo on the Chef Infra Server to behave like a mirror of the
    chef-repo on the workstation. The Chef Infra Server will have the
    same objects as the local chef-repo. To make changes to the files on
    the Chef Infra Server, just download files from the Chef Infra
    Server or upload files from the chef-repo
-   The context from which a command is run matters. For example, when
    working in the `roles/` directory, knife will know what is being
    worked with. Enter `knife show base.json` and knife will return the
    base role from the Chef Infra Server. From the chef-repo root, enter
    `knife show roles/base.json` to get the same result
-   Parallel requests can be made to the Chef Infra Server and are
    configurable on a per-command basis

Wildcard Search
---------------

A wildcard matching pattern can be used for substring matches that
replace zero (or more) characters. There are two types of wildcard
patterns:

-   A question mark ("?") can be used to replace exactly one character
    (as long as that character is not the first character)
-   An asterisk ("\*") can be used to replace any number of characters
    (including zero)

Wildcard patterns must be escaped (using a backslash) so that the
wildcard itself can reach the Chef Infra Server. If they are not
escaped, the wildcard is expanded into the actual filenames and knife
will not know the wildcard was intended to be used. For example, if the
Chef Infra Server has data bags named `aardvarks`, `anagrams`, and
`arp_tables`, but the local file system only has `aardvarks` and
`anagrams`, escaping vs. not escaping the wildcard pattern will yield
different results:

``` bash
$ knife list data_bags/a\*
```

asks the Chef Infra Server for everything starting with the letter "a"
and will return:

``` bash
$ aardvarks/ anagrams/ arp_tables/
```

But, the following:

``` bash
$ knife list data_bags/a*
```

will return:

``` bash
$ aardvarks/ anagrams/
```

Which is the same as entering:

``` bash
$ knife list data_bags/aardvarks data_bags/anagrams
```

to return:

``` bash
$ aardvarks/ anagrams/
```

Knife Plug-ins
==============

Knife functionality can be extended with plugins, which work the same as
built-in subcommands (including common options). Knife plugins have been
written to interact with common cloud providers, to simplify common Chef
tasks, and to aid in Chef workflows.

Plugin Installation
-------------------

Knife plugins ship as RubyGems and are installed into the Chef
Workstation installation using the `chef` command:

``` bash
chef gem install PLUGIN_NAME
```

Post installation you will also need to rehash the list of knife
commands by running:

``` bash
knife rehash
```

Chef Maintained Knife Plugins
-----------------------------

Chef maintains the following plugins which ship with Chef Workstation:

-   `knife-acl`
-   `knife-azure`
-   `knife-ec2`
-   `knife-google`
-   `knife-lpar`
-   `knife-opc`
-   `knife-openstack`
-   `knife-push`
-   `knife-rackspace`
-   `knife-reporting`
-   `knife-vcenter`
-   `knife-windows`

Community Knife Plugins
-----------------------

Knife plugins written by Chef community members can be found on
Supermarket under [Knife
Plugins](https://supermarket.chef.io/tools?type=knife_plugin).
