+++
title = "ohai (executable)"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/ctl_ohai.html"]

[menu]
  [menu.infra]
    title = "ohai (executable)"
    identifier = "chef_infra/features/ohai/ctl_ohai.md ohai Commands"
    parent = "chef_infra/features/ohai"
    weight = 20
+++

`ohai` is the command-line interface for Ohai, a tool that's used to
detect attributes on a node, and then provide these attributes to Chef
Infra Client at the start of every Chef Infra Client run.

## Options

This command has the following syntax:

```bash
ohai OPTION
```

This tool has the following options:

`ATTRIBUTE_NAME ATTRIBUTE NAME ...`

:   Use to have Ohai show only output for named attributes. To address attributes deeper in the tree, use a `/` delimiter between each level. For example: `memory/free`.

`-c CONFIG`, `--config CONFIG`

:   The path to a configuration file to use. For example:
    `/etc/ohai/config.rb`.

`-d DIRECTORY`, `--directory DIRECTORY`

:   The directory in which additional Ohai plugins are located. For
    example: `/my/extra/plugins`.

`-h`, `--help`

:   Show help for the command.

`-l LEVEL`, `--log_level LEVEL`

:   The level of logging to be stored in a log file.

`-L LOGLOCATION`, `--logfile LOGLOCATION`

:   The location of the log file.

`-v`, `--version`

:   The version of Ohai.

## Examples

The following examples show how to use the Ohai command-line tool:

### Query for a specific attribute

Pass an attribute as an argument to `ohai` to get the value of that attribute. For example:

```bash
ohai os
```

This fetches the value of Chef Infra's node data at `node['os']` and returns something like:

```json
[
  "linux"
]
```

To query for an attribute deeper in the tree, use a forward slash (`/`) as a
delimiter. For example, to query for free memory, run:

```bash
ohai memory/free
```

### Run a plugin independently of a Chef Infra Client run

An Ohai plugin can be run independently of a Chef Infra Client run.
First, ensure that the plugin is located in the `/plugins` directory and
then use the `-f` option when running Ohai from the command line. For
example, a plugin named `sl_installed` may look like the following:

```ruby
Ohai.plugin(:Sl) do
  provides "sl"

  collect_data(:default) do
    sl Mash.new

    if ::File.exist?("/usr/games/sl")
      sl[:installed] = true
    else
      sl[:installed] = false
    end

    # sl[:installed] = ::File.exist?("/usr/games/sl")

  end
end
```

To run that plugin from the command line, use the following command:

```bash
ohai --directory /path/to/directory sl
```

The command will return something similar to:

```json
{
  "sl": {
    "installed": true
  }
}
```
