+++
title = "Debug Recipes, Chef Infra Client Runs"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/debug.html"]

[menu]
  [menu.infra]
    title = "Debug Recipes, Client Runs"
    identifier = "chef_infra/cookbook_reference/recipes/debug.md Debug Recipes, Client Runs"
    parent = "chef_infra/cookbook_reference/recipes"
    weight = 20
+++

Elements of good approaches to building cookbooks and recipes that are
reliable include:

* A consistent syntax pattern when constructing recipes
* Using the same patterns in Ruby
* Using resources included in Chef Infra Client or community cookbooks before creating custom ones

Ideally, the best way to debug a recipe is to not have to debug it in the first place. That said, the following sections discuss various approaches to debugging recipes and failed Chef Infra Client runs.

## Basic

Some simple ways to identify common issues that can trigger recipe and/or Chef Infra Client run failures include:

* Using an empty run-list
* Using verbose logging with knife
* Using logging with Chef Infra Client
* Using the **log** resource in a recipe to define custom logging

### Empty Run-lists

{{< readfile file="content/reusable/md/node_run_list_empty.md" >}}

### Knife

Use the verbose logging that's built into knife:

`-V`, `--verbose`

: Set for more verbose outputs. Use `-VV` for much more verbose outputs. Use `-VVV` for maximum verbosity, which may provide more information than is actually helpful.

{{< note >}}

Plugins don't always support verbose logging.

{{< /note >}}

### Chef Infra Client

Use the verbose logging that's built into Chef Infra Client:

`-l LEVEL`, `--log_level LEVEL`

: The level of logging to be stored in a log file. Possible levels: `auto` (default), `debug`, `error`, `fatal`, `info`, `trace`, or `warn`. Default value: `warn` (when a terminal is available) or `info` (when a terminal isn't available).

`-L LOGLOCATION`, `--logfile c`

: The location of the log file. This is recommended when starting any executable as a daemon. Default value: `STDOUT`.

### log Resource

Use the **log** resource to create log entries. The **log** resource
behaves like any other resource: built into the resource collection
during the compile phase, and then run during the execution phase. (To
create a log entry that isn't built into the resource collection, use
`Chef::Log` instead of the **log** resource.)

{{< note >}}

By default, every log resource that executes will count as an updated
resource in the updated resource count at the end of a Chef run. You can
disable this behavior by adding `count_log_resource_updates false` to
your Chef `client.rb` configuration file.

{{< /note >}}

New in 12.0, `-o RUN_LIST_ITEM`. Changed in 12.0 `-f` no longer allows unforked intervals, `-i SECONDS` is applied before a Chef Infra Client run.

#### Syntax

{{< readfile file="content/reusable/md/resource_log_syntax.md" >}}

#### Actions

The log resource has the following actions:

`:nothing`

:   {{< readfile file="content/reusable/md/resources_common_actions_nothing.md" >}}

`:write`

:   Default. Write to log.

#### Properties

{{< readfile file="content/reusable/md/resource_log_properties.md" >}}

#### Examples

The following examples demonstrate various approaches for using
resources in recipes:

##### Specify a Log Entry

```ruby
log 'a string to log'
```

##### Set debug logging level

{{< readfile file="content/reusable/md/resource_log_set_debug.md" >}}

##### Create log entry when the contents of a data bag are used

{{< readfile file="content/reusable/md/resource_log_set_debug.md" >}}

##### Add a message to a log file

```ruby
log 'message' do
  message 'This is the message that will be added to the log.'
  level :info
end
```

## Advanced

Some more complex ways to debug issues with a Chef Infra Client run
include:

* Using the **chef_handler** resource
* Using the chef-shell and the **breakpoint** resource to add breakpoints to recipes, and to then step through the recipes using the breakpoints
* Using the `debug_value` method from chef-shell to identify the locations from which attribute values are being set
* Using the `ignore_failure` method in a recipe to force Chef Infra Client to move past an error to see what else is going on in the recipe, outside of a known failure
* Using chef-solo to run targeted Chef Infra Client runs for specific scenarios

### chef_handler

{{< readfile file="content/reusable/md/handler.md" >}}

{{< readfile file="content/reusable/md/handler_types.md" >}}

Read more [about exception, report, and start handlers](/handlers/).

### chef-shell

{{< readfile file="content/reusable/md/chef_shell_summary.md" >}}

{{< readfile file="content/reusable/md/chef_shell_modes.md" >}}

#### Configure

{{< readfile file="content/reusable/md/chef_shell_config.md" >}}

#### chef-shell.rb

{{< readfile file="content/reusable/md/chef_shell_config_rb.md" >}}

#### Run as a Chef Infra Client

{{< readfile file="content/reusable/md/chef_shell_run_as_chef_client.md" >}}

#### Manage

{{< readfile file="content/reusable/md/chef_shell_manage.md" >}}

### breakpoint Resource

{{< readfile file="content/reusable/md/chef_shell_breakpoints.md" >}}

Use the **breakpoint** resource to add breakpoints to recipes. Run the
chef-shell in Chef Infra Client mode, and then use those breakpoints to
debug recipes. Breakpoints are ignored by Chef Infra Client during an
actual Chef Infra Client run. That said, breakpoints are typically used
to debug recipes only when running them in a non-production environment,
after which they're removed from those recipes before the parent
cookbook is uploaded to the Chef Infra Server.

#### Syntax

A **breakpoint** resource block creates a breakpoint in a recipe:

```ruby
breakpoint 'name' do
  action :break
end
```

where

`:break` will tell Chef Infra Client to stop running a recipe; can
only be used when Chef Infra Client is being run in chef-shell mode

#### Actions

The breakpoint resource has the following actions:

`:break`

:   Use to add a breakpoint to a recipe.

`:nothing`

:   {{< readfile file="content/reusable/md/resources_common_actions_nothing.md" >}}

#### Attributes

This resource doesn't have any properties.

#### Examples

The following examples demonstrate various approaches for using resources in recipes:

##### A recipe without a breakpoint

```ruby
yum_key node['yum']['elrepo']['key'] do
  url  node['yum']['elrepo']['key_url']
  action :add
end

yum_repository 'elrepo' do
  description 'ELRepo.org Community Enterprise Linux Extras Repository'
  key node['yum']['elrepo']['key']
  mirrorlist node['yum']['elrepo']['url']
  includepkgs node['yum']['elrepo']['includepkgs']
  exclude node['yum']['elrepo']['exclude']
  action :create
end
```

##### The same recipe with breakpoints

```ruby
breakpoint "before yum_key node['yum']['repo_name']['key']" do
  action :break
end

yum_key node['yum']['repo_name']['key'] do
  url  node['yum']['repo_name']['key_url']
  action :add
end

breakpoint "after yum_key node['yum']['repo_name']['key']" do
  action :break
end

breakpoint "before yum_repository 'repo_name'" do
  action :break
end

yum_repository 'repo_name' do
  description 'description'
  key node['yum']['repo_name']['key']
  mirrorlist node['yum']['repo_name']['url']
  includepkgs node['yum']['repo_name']['includepkgs']
  exclude node['yum']['repo_name']['exclude']
  action :create
end

breakpoint "after yum_repository 'repo_name'" do
  action :break
end
```

where the name of each breakpoint is an arbitrary string. In the
previous examples, the names are used to indicate if the breakpoint is
before or after a resource, and then also to specify which resource.

### Step Through Run-list

{{< readfile file="content/reusable/md/chef_shell_step_through_run_list.md" >}}

### Debug Existing Recipe

{{< readfile file="content/reusable/md/chef_shell_debug_existing_recipe.md" >}}

### Advanced Debugging

{{< readfile file="content/reusable/md/chef_shell_advanced_debug.md" >}}

### debug_value

Use the `debug_value` method to discover the location within the attribute precedence hierarchy from which a particular attribute (or sub-attribute) is set. This method is available when running chef-shell in Chef Infra Client mode:

```bash
chef-shell -z
```

For example, the following attributes exist in a cookbook. Some are defined in a role file:

```ruby
default_attributes 'test' => { 'source' => 'role default' }
override_attributes 'test' => { 'source' => 'role override' }
```

And others are defined in an attributes file:

```ruby
default[:test][:source]  = 'attributes default'
normal[:test][:source]      = 'attributes normal'
override[:test][:source] = 'attributes override'
```

To debug the location in which the value of `node[:test][:source]` is set, use chef-shell and run a command similar to:

```ruby
pp node.debug_value('test', 'source')
```

This will pretty-print return all of the attributes and sub-attributes as an array of arrays; `:not_present` is returned for any attribute without a value:

```bash
[['set_unless_enabled?', false],
 ['default', 'attributes default'],
 ['env_default', :not_present],
 ['role_default', 'role default'],
 ['force_default', :not_present],
 ['normal', 'attributes normal'],
 ['override', 'attributes override'],
 ['role_override', 'role override'],
 ['env_override', :not_present],
 ['force_override', :not_present],
 ['automatic', :not_present]]
```

where

* `set_unless_enabled` indicates if the attribute collection is in `set_unless` mode; this typically returns `false`
* Each attribute type is listed in order of precedence
* Each attribute value shown is the value that's set for that precedence level
* `:not_present` is shown for any attribute precedence level that has no attributes

### ignore_failure method

All resources share a set of common actions, attributes, and other properties. Use the following attribute in a resource to help identify where an issue within a recipe may be located:

| Attribute      | Description                                                                           |
|----------------|---------------------------------------------------------------------------------------|
| ignore_failure | Continue running a recipe if a resource fails for any reason. Default value: `false`. |

### chef-solo

See [chef-solo (executable)](/ctl_chef_solo/) for complete CTL documentation.

{{< readfile file="content/reusable/md/chef_solo_summary.md" >}}

See [chef-solo (executable)](/ctl_chef_solo/) for complete CTL documentation.
