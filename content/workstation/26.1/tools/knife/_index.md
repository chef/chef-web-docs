+++
title = "About knife"
draft = false

linkTitle = "knife"

[menu]
  [menu.workstation_26_1]
    title = "About knife"
    identifier = "workstation_26_1/tools/knife/knife.md About knife"
    parent = "workstation_26_1/tools/knife"
    weight = 10
+++

<!-- markdownlint-disable-file MD033 -->

knife is a command-line tool that provides an interface between a local
chef-repo and Chef Infra Server. knife helps users to manage:

- Nodes
- Cookbooks and recipes
- Roles, Environments, and Data Bags
- Resources within various cloud environments
- The installation of Chef Infra Client onto nodes
- Searching of indexed data on Chef Infra Server

## Configure knife

See the following guides to setup and configure knife:

- **[Set up knife](/workstation/26.1/tools/knife/set_up/)**: Configure knife to interact with your organization's Chef Infra Server and infrastructure.
- **[knife Common Options](/workstation/26.1/tools/knife/common_options/)**: Common options that are available for all knife subcommands.
- **[config.rb](/workstation/26.1/tools/knife/config_rb/)**: Common options for the `config.rb` file
- **[config.rb optional settings](tools/knife/config_rb_optional_settings/)**: Additional options for your `config.rb` file

## knife subcommands

knife includes a collection of built in subcommands that work together
to provide the functionality required to take specific actions
against any object in an organization, including cookbooks, nodes,
roles, data bags, environments, and users.

### knife command syntax

All knife subcommands have the following syntax:

```bash
knife subcommand [ARGUMENT] (options)
```

Each subcommand has its own set of arguments and options.

{{< note >}}

All syntax examples in this document show variables in ALL_CAPS. For
example `-u PORT_LIST` (where PORT_LIST is a comma-separated list of
local and public UDP ports) or `-F FORMAT` (where FORMAT determines the
output format, either `summary`, `text`, `json`, `yaml`, or `pp`). These
variables often require specific values that are unique to each
organization.

{{< /note >}}

### Built-in subcommands

| Subcommand | Description |
| --- | --- |
| [knife_bootstrap](/workstation/26.1/tools/knife/knife_bootstrap/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_bootstrap_summary.md" >}} |
| [knife_client](/workstation/26.1/tools/knife/knife_client/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_client_summary.md" >}} |
| [knife configure](/workstation/26.1/tools/knife/knife_configure/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_configure_summary.md" >}} |
| [knife cookbook](/workstation/26.1/tools/knife/knife_cookbook/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_cookbook_summary.md" >}} |
| [knife data bag](/workstation/26.1/tools/knife/knife_data_bag/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_data_bag_summary.md" >}} |
| [knife delete](/workstation/26.1/tools/knife/knife_delete/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_delete_summary.md" >}} |
| [knife deps](/workstation/26.1/tools/knife/knife_deps/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_deps_summary.md" >}} |
| [knife diff](/workstation/26.1/tools/knife/knife_diff/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_diff_summary.md" >}} |
| [knife download](/workstation/26.1/tools/knife/knife_download/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_download_summary.md" >}} |
| [knife edit](/workstation/26.1/tools/knife/knife_edit/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_edit_summary.md" >}} |
| [knife environment](/workstation/26.1/tools/knife/knife_environment/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_environment_summary.md" >}} |
| [knife exec](/workstation/26.1/tools/knife/knife_exec/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_exec_summary.md" >}} |
| [knife list](/workstation/26.1/tools/knife/knife_list/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_list_summary.md" >}} |
| [knife node](/workstation/26.1/tools/knife/knife_node/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_node_summary.md" >}} |
| [knife raw](/workstation/26.1/tools/knife/knife_raw/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_raw_summary.md" >}} |
| [knife recipe list](/workstation/26.1/tools/knife/knife_recipe_list/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_recipe_list_summary.md" >}} |
| [knife role](/workstation/26.1/tools/knife/knife_role/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_role_summary.md" >}} |
| [knife search](/workstation/26.1/tools/knife/knife_search/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_search_summary.md" >}} |
| [knife serve](/workstation/26.1/tools/knife/knife_serve/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_serve_summary.md" >}} |
| [knife show](/workstation/26.1/tools/knife/knife_show/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_show_summary.md" >}} |
| [knife ssh](/workstation/26.1/tools/knife/knife_ssh/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_ssh_summary.md" >}} |
| [knife ssl check](/workstation/26.1/tools/knife/knife_ssl_check/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_ssl_check_summary.md" >}} |
| [knife ssl fetch](/workstation/26.1/tools/knife/knife_ssl_fetch/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_ssl_fetch_summary.md" >}} |
| [knife status](/workstation/26.1/tools/knife/knife_status/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_status_summary.md" >}} |
| [knife tag](/workstation/26.1/tools/knife/knife_tag/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_tag_summary.md" >}} |
| [knife supermarket](/workstation/26.1/tools/knife/knife_supermarket/) | Use the `knife supermarket` subcommand to interact with cookbooks that are available in the [Chef Supermarket](https://supermarket.chef.io/). A user account is required for any community actions that write data to this site. The following arguments don't require a user account: `download`, `search`, `install`, and `list`. |
| [knife upload](/workstation/26.1/tools/knife/knife_upload/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_upload_summary.md" >}} |
| [knife user](/workstation/26.1/tools/knife/knife_user/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_user_summary.md" >}} |
| [knife xargs](/workstation/26.1/tools/knife/knife_xargs/) | {{< readfile file="content/workstation/26.1/reusable/md/knife_xargs_summary.md" >}} |

### Verb Subcommands

knife includes a set of subcommands that are built around common verbs:
`delete`, `deps`, `diff`, `download`, `edit`, `list`, `show`, `upload`,
`xargs`. These subcommands allow knife to issue commands that interact
with any object stored in the chef-repo or stored on the Chef Infra
Server. Some important principles behind this group of subcommands
includes:

- A command that works with each object in the chef-repo. The subcommands specify the desired action (the "verb"), and then directory in which that object resides (`clients`, `cookbooks/`, `data_bags/`, `environments/`, `nodes`, `roles/`, and `users`). For example: `download cookbooks/`.
- A command that works with certain objects in Chef Infra Server, including `acls`, `groups`, and `containers`.
- Uses Chef Infra Server as if it were a file system, allowing the chef-repo on Chef Infra Server to behave like a mirror of the chef-repo on the workstation. Chef Infra Server will have the same objects as the local chef-repo. To make changes to the files on Chef Infra Server, just download files from Chef Infra Server or upload files from the chef-repo.
- The context from which a command is run matters. For example, when working in the `roles/` directory, knife will know what's being worked with. Enter `knife show base.json` and knife will return the base role from Chef Infra Server. From the chef-repo root, enter `knife show roles/base.json` to get the same result.
- Parallel requests can be made to Chef Infra Server and are configurable in each command.

### Wildcard Search

A wildcard matching pattern can be used for substring matches that
replace zero (or more) characters. There are two types of wildcard
patterns:

- A question mark ("?") can be used to replace exactly one character (as long as that character isn't the first character)
- An asterisk ("\*") can be used to replace any number of characters (including zero)

Wildcard patterns must be escaped (using a backslash) so that the
wildcard itself can reach Chef Infra Server. If they aren't
escaped, the wildcard is expanded into the actual filenames and knife
won't know the wildcard was intended to be used. For example, if the
Chef Infra Server has data bags named `aardvarks`, `anagrams`, and
`arp_tables`, but the local file system only has `aardvarks` and
`anagrams`, escaping vs. not escaping the wildcard pattern will yield
different results:

```bash
knife list data_bags/a\*
```

asks Chef Infra Server for everything starting with the letter "a"
and will return:

```bash
aardvarks/ anagrams/ arp_tables/
```

But, the following:

```bash
knife list data_bags/a*
```

will return:

```bash
aardvarks/ anagrams/
```

Which is the same as entering:

```bash
knife list data_bags/aardvarks data_bags/anagrams
```

to return:

```bash
aardvarks/ anagrams/
```

## knife Plug-ins

knife functionality can be extended with plugins, which work the same as
built-in subcommands (including common options). knife plugins have been
written to interact with common cloud providers, to simplify common Chef
tasks, and to aid in Chef workflows.

### Plugin Installation

knife plugins ship as RubyGems and are installed into the Chef
Workstation installation using the `chef` command:

```bash
chef gem install PLUGIN_NAME
```

Post installation you will also need to rehash the list of knife
commands by running:

```bash
knife rehash
```

### Chef Maintained knife Plugins

Chef maintains the following plugins which ship with Chef Workstation:

- `knife-acl`
- `knife-azure`
- `knife-ec2`
- `knife-google`
- `knife-lpar`
- `knife-opc`
- `knife-openstack`
- `knife-rackspace`
- `knife-reporting`
- `knife-vcenter`
- `knife-windows`

### Community knife Plugins

knife plugins written by Chef community members can be found on Supermarket under [knife Plugins](https://supermarket.chef.io/tools?type=knife_plugin).
