+++
title = "knife node"
draft = false



[menu]
  [menu.workstation_25]
    title = "knife node"
    identifier = "workstation_25/tools/knife/knife_node.md knife node"
    parent = "workstation_25/tools/knife"
+++
<!-- markdownlint-disable-file MD024 MD036 -->

A node is any device---physical, virtual, cloud, or network device---that's under management by Chef Infra.

{{< readfile file="content/workstation/25/reusable/md/knife_node_summary.md" >}}

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_see_common_options_link.md" >}}

{{< /note >}}

## bulk delete

Use the `bulk delete` argument to delete one or more nodes that match a
pattern defined by a regular expression. The regular expression must be
within quotes and not be surrounded by forward slashes (/).

### Syntax

This argument has the following syntax:

```bash
knife node bulk delete REGEX
```

### Options

This command doesn't have any specific options.

### Examples

The following examples show how to use this knife subcommand:

**Bulk delete nodes**

Use a regular expression to define the pattern used to bulk delete
nodes:

```bash
knife node bulk delete "^[0-9]{3}$"
```

Type `Y` to confirm a deletion.

## create

Use the `create` argument to add a node to Chef Infra Server. Node
data is stored as JSON on Chef Infra Server.

### Syntax

This argument has the following syntax:

```bash
knife node create NODE_NAME
```

### Options

This command doesn't have any specific options.

### Examples

The following examples show how to use this knife subcommand:

**Create a node**

To add a node named `node1`, enter:

```bash
knife node create node1
```

In the \$EDITOR enter the node data in JSON:

```javascript
{
   "normal": {
   },
   "name": "foobar",
   "override": {
   },
   "default": {
   },
   "json_class": "Chef::Node",
   "automatic": {
   },
   "run_list": [
      "recipe[zsh]",
      "role[webserver]"
   ],
   "chef_type": "node"
}
```

When finished, save it.

## delete

Use the `delete` argument to delete a node from Chef Infra Server.
If using Chef Infra Client 12.17 or later, you can delete multiple nodes using
this subcommand.

{{< note >}}

Deleting a node won't delete any corresponding API clients.

{{< /note >}}

### Syntax

This argument has the following syntax:

```bash
knife node delete NODE_NAME
```

### Options

This command doesn't have any specific options.

### Examples

The following examples show how to use this knife subcommand:

**Delete a node**

To delete a node named `node1`, enter:

```bash
knife node delete node1
```

## edit

Use the `edit` argument to edit the details of a node on a Chef Infra
Server. Node data is stored as JSON on Chef Infra Server.

### Syntax

This argument has the following syntax:

```bash
knife node edit NODE_NAME (options)
```

### Options

This argument has the following options:

`-a`, `--all`

: Display a node in the \$EDITOR. By default, attributes that are
    default, override, or automatic, aren't shown.

### Examples

The following examples show how to use this knife subcommand:

**Edit a node**

To edit the data for a node named `node1`, enter:

```bash
knife node edit node1 -a
```

Update the role data in JSON:

```javascript
{
   "normal": {
   },
   "name": "node1",
   "override": {
   },
   "default": {
   },
   "json_class": "Chef::Node",
   "automatic": {
   },
   "run_list": [
      "recipe[devops]",
      "role[webserver]"
   ],
   "chef_type": "node"
}
```

When finished, save it.

## environment set

Use the `environment set` argument to set the environment for a node
without editing the node object.

### Syntax

This argument has the following syntax:

```bash
knife node environment_set NODE_NAME ENVIRONMENT_NAME (options)
```

### Options

This command doesn't have any specific options.

### Examples

None.

## from file

Use the `from file` argument to create a node using existing node data
as a template.

### Syntax

This argument has the following syntax:

```bash
knife node from file FILE
```

### Options

This command doesn't have any specific options.

### Examples

The following examples show how to use this knife subcommand:

**Create a node using a JSON file**

To add a node using data contained in a JSON file:

```bash
knife node from file "PATH_TO_JSON_FILE"
```

## list

Use the `list` argument to view the nodes that exist on a Chef
Infra Server.

### Syntax

This argument has the following syntax:

```bash
knife node list (options)
```

### Options

This argument has the following options:

`-w`, `--with-uri`

: Show the corresponding URIs.

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

### Examples

The following examples show how to use this knife subcommand:

**View a list of nodes**

To verify the list of nodes that are registered with the Chef Infra
Server, enter:

```bash
knife node list
```

to return something similar to:

```bash
i-12345678
rs-123456
```

## policy set

Use the `policy set` argument to set the policy group and policy name
for a node.

### Syntax

This argument has the following syntax:

```bash
knife node policy set NODE POLICY_GROUP POLICY_NAME
```

### Examples

Set the policy group and policy name for a node named `test-node`:

```bash
knife node policy set test-node 'test-group' 'test-name'
```

## run_list add

A run-list defines all of the information necessary for Chef to
configure a node into the desired state. A run-list is:

- An ordered list of roles and/or recipes that are run in the exact
    order defined in the run-list; if a recipe appears more than once in
    the run-list, Chef Infra Client won't run it twice
- Always specific to the node on which it runs; nodes may have a
    run-list that's identical to the run-list used by other nodes
- Stored as part of the node object on Chef Infra Server
- Maintained using knife and then uploaded from the workstation to the
    Chef Infra Server, or maintained using Chef Automate

Use the `run_list add` argument to add run-list items (roles or recipes)
to a node.

A run-list must be in one of the following formats: fully qualified,
cookbook, or default. Both roles and recipes must be in quotes, for
example:

```json
"role[NAME]"
```

or

```json
"recipe[COOKBOOK::RECIPE]"
```

Use a comma to separate roles and recipes when adding more than one item
the run-list:

```json
"recipe[COOKBOOK::RECIPE],COOKBOOK::RECIPE,role[NAME]"
```

### Syntax

This argument has the following syntax:

```bash
knife node run_list add NODE_NAME RUN_LIST_ITEM (options)
```

{{< warning >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_windows_quotes.md" >}}

{{< /warning >}}

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_windows_quotes_module.md" >}}

{{< /note >}}

### Options

This argument has the following options:

`-a ITEM`, `--after ITEM`

:   Add a run-list item after the specified run-list item.

`-b ITEM`, `--before ITEM`

:   Add a run-list item before the specified run-list item.

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

### Examples

The following examples show how to use this knife subcommand:

**Add a role**

To add a role to a run-list, enter:

```bash
knife node run_list add NODE_NAME 'role[ROLE_NAME]'
```

**Add roles and recipes**

To add roles and recipes to a run-list, enter:

```bash
knife node run_list add NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME],recipe[COOKBOOK::RECIPE_NAME],role[ROLE_NAME]'
```

**Add a recipe with a FQDN**

To add a recipe to a run-list using the fully qualified format, enter:

```bash
knife node run_list add NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME]'
```

**Add a recipe with a cookbook**

To add a recipe to a run-list using the cookbook format, enter:

```bash
knife node run_list add NODE_NAME 'COOKBOOK::RECIPE_NAME'
```

**Add the default recipe**

To add the default recipe of a cookbook to a run-list, enter:

```bash
knife node run_list add NODE_NAME 'COOKBOOK'
```

## run_list remove

Use the `run_list remove` argument to remove run-list items (roles or
recipes) from a node. A recipe must be in one of the following formats:
fully qualified, cookbook, or default. Both roles and recipes must be in
quotes, for example: `'role[ROLE_NAME]'` or
`'recipe[COOKBOOK::RECIPE_NAME]'`. Use a comma to separate roles and
recipes when removing more than one, like this:
`'recipe[COOKBOOK::RECIPE_NAME],COOKBOOK::RECIPE_NAME,role[ROLE_NAME]'`.

### Syntax

This argument has the following syntax:

```bash
knife node run_list remove NODE_NAME RUN_LIST_ITEM
```

### Options

This command doesn't have any specific options.

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

### Examples

The following examples show how to use this knife subcommand:

**Remove a role**

To remove a role from a run-list, enter:

```bash
knife node run_list remove NODE_NAME 'role[ROLE_NAME]'
```

**Remove a run-list**

To remove a recipe from a run-list using the fully qualified format,
enter:

```bash
knife node run_list remove NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME]'
```

## run_list set

Use the `run_list set` argument to set the run-list for a node. A recipe
must be in one of the following formats: fully qualified, cookbook, or
default. Both roles and recipes must be in quotes, for example:
`"role[ROLE_NAME]"` or `"recipe[COOKBOOK::RECIPE_NAME]"`. Use a comma to
separate roles and recipes when setting more than one, like this:
`"recipe[COOKBOOK::RECIPE_NAME],COOKBOOK::RECIPE_NAME,role[ROLE_NAME]"`.

### Syntax

This argument has the following syntax:

```bash
knife node run_list set NODE_NAME RUN_LIST_ITEM
```

{{< warning >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_windows_quotes.md" >}}

{{< /warning >}}

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/knife_common_windows_quotes_module.md" >}}

{{< /note >}}

### Options

This command doesn't have any specific options.

### Examples

None.

## show

Use the `show` argument to display information about a node.

### Syntax

This argument has the following syntax:

```bash
knife node show NODE_NAME (options)
```

### Options

This argument has the following options:

`-a ATTR`, `--attribute ATTR`

: The attribute (or attributes) to show.

`-F json`, `--format=json`

: Display output as JSON.

`-l`, `--long`

: Display all attributes in the output.

`-m`, `--medium`

: Display normal attributes in the output.

`-r`, `--run-list`

: Show only the run-list.

### Examples

The following examples show how to use this knife subcommand:

**Show all data about nodes**

To view all data for a node named `build`, enter:

```bash
knife node show build
```

to return:

```bash
Node Name: build
Environment: _default
FQDN:
IP:
Run List:
Roles:
Recipes:
Platform:
```

**Show basic information about nodes**

To show basic information about a node, that's truncated and formatted:

```bash
knife node show NODE_NAME
```

**Show all data about nodes, truncated**

To show all information about a node, formatted:

```bash
knife node show -l NODE_NAME
```

**Show attributes**

To list a single node attribute:

```bash
knife node show NODE_NAME -a ATTRIBUTE_NAME
```

where `ATTRIBUTE_NAME` is something like `kernel` or `platform`.

To list a nested attribute:

```bash
knife node show NODE_NAME -a ATTRIBUTE_NAME.NESTED_ATTRIBUTE_NAME
```

where `ATTRIBUTE_NAME` is something like `kernel` and
`NESTED_ATTRIBUTE_NAME` is something like `machine`.

**Show the FQDN**

To view the FQDN for a node named `i-12345678`, enter:

```bash
knife node show i-12345678 -a fqdn
```

to return:

```bash
fqdn: ip-10-251-75-20.ec2.internal
```

**Show a run-list**

To view the run-list for a node named `dev`, enter:

```bash
knife node show dev -r
```

**Show as JSON data**

To view information in JSON format, use the `-F` common option; use a
command like this for a node named `devops`:

```bash
knife node show devops -F json
```

Other formats available include `text`, `yaml`, and `pp`.

**Show as raw JSON data**

To view node information in raw JSON, use the `-l` or `--long` option:

```bash
knife node show -l -F json NODE_NAME
```

and/or:

```bash
knife node show -l --format=json NODE_NAME
```
