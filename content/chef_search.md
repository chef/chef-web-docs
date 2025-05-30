+++
title = "About Search"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/chef_search.html", "essentials_search.html"]
product = ["client", "server", "workstation"]

[menu]
  [menu.infra]
    title = "Search"
    identifier = "chef_infra/features/chef_search.md Search"
    parent = "chef_infra/features"
    weight = 70
+++
<!-- markdownlint-disable-file MD033 -->
{{< readfile file="content/reusable/md/search.md" >}}

Many of the examples in this section use knife, but the search indexes
and search query syntax can be used in many locations, including from
within recipes and when using the Chef Infra Server API.

## Search Indexes

A search index is a full-text list of objects that are stored on the
Chef Infra Server, against which search queries can be made. The
following search indexes are built:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Search Index Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>client</code></td>
<td>API client</td>
</tr>
<tr>
<td><code>DATA_BAG_NAME</code></td>
<td>A data bag is a global variable that's stored as JSON data and is accessible from a Chef Infra Server. The name of the search index is the name of the data bag. For example, if the name of the data bag was "admins" then a corresponding search query might look something like <code>search(:admins, "*:*")</code>.</td>
</tr>
<tr>
<td><code>environment</code></td>
<td>An environment is a way to map an organization's real-life workflow to what can be configured and managed when using Chef Infra Server.</td>
</tr>
<tr>
<td><code>node</code></td>
<td>A node is any server or virtual server that's configured to be maintained by a Chef Infra Client.</td>
</tr>
<tr>
<td><code>role</code></td>
<td>A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function.</td>
</tr>
</tbody>
</table>

### Using Knife

{{< readfile file="content/workstation/reusable/md/knife_search_summary.md" >}}

#### Search by platform ID

{{< readfile file="content/workstation/reusable/md/knife_search_by_platform_ids.md" >}}

#### Search by instance type

{{< readfile file="content/workstation/reusable/md/knife_search_by_platform_instance_type.md" >}}

#### Search by recipe

{{< readfile file="content/workstation/reusable/md/knife_search_by_recipe.md" >}}

#### Search by cookbook, then recipe

{{< readfile file="content/workstation/reusable/md/knife_search_by_cookbook.md" >}}

#### Search by node

{{< readfile file="content/workstation/reusable/md/knife_search_by_node.md" >}}

#### Search by node and environment

{{< readfile file="content/workstation/reusable/md/knife_search_by_node_and_environment.md" >}}

#### Search for nested attributes

{{< readfile file="content/workstation/reusable/md/knife_search_by_nested_attribute.md" >}}

#### Search for multiple attributes

{{< readfile file="content/workstation/reusable/md/knife_search_by_query_for_many_attributes.md" >}}

#### Search for nested attributes using a search query

{{< readfile file="content/workstation/reusable/md/knife_search_by_query_for_nested_attribute.md" >}}

#### Use a test query

{{< readfile file="content/workstation/reusable/md/knife_search_test_query_for_ssh.md" >}}

## Query Syntax

{{< readfile file="content/reusable/md/search_query_syntax.md" >}}

{{< note >}}

Search queries may not contain newlines.

{{< /note >}}

## Filter Search Results

{{< readfile file="content/reusable/md/infra_lang_method_search_filter_result.md" >}}

## Keys

{{< readfile file="content/reusable/md/search_key.md" >}}

### Nested Fields

{{< readfile file="content/reusable/md/search_key_nested.md" >}}

### Examples

{{< readfile file="content/reusable/md/search_key_name.md" >}}

{{< readfile file="content/reusable/md/search_key_wildcard_question_mark.md" >}}

{{< readfile file="content/reusable/md/search_key_wildcard_asterisk.md" >}}

{{< readfile file="content/reusable/md/search_key_nested_starting_with.md" >}}

{{< readfile file="content/reusable/md/search_key_nested_range.md" >}}

## Patterns

{{< readfile file="content/reusable/md/search_pattern.md" >}}

### Exact Matching

{{< readfile file="content/reusable/md/search_pattern_exact.md" >}}

{{< readfile file="content/reusable/md/search_pattern_exact_key_and_item.md" >}}

{{< readfile file="content/reusable/md/search_pattern_exact_key_and_item_string.md" >}}

### Wildcard Matching

{{< readfile file="content/reusable/md/search_pattern_wildcard.md" >}}

{{< readfile file="content/reusable/md/search_pattern_wildcard_any_node.md" >}}

{{< readfile file="content/reusable/md/search_pattern_wildcard_node_contains.md" >}}

### Range Matching

{{< readfile file="content/reusable/md/search_pattern_range.md" >}}

{{< readfile file="content/reusable/md/search_pattern_range_in_between.md" >}}

{{< readfile file="content/reusable/md/search_pattern_range_exclusive.md" >}}

### Fuzzy Matching

{{< readfile file="content/reusable/md/search_pattern_fuzzy.md" >}}

{{< readfile file="content/reusable/md/search_pattern_fuzzy_summary.md" >}}

## Operators

{{< readfile file="content/reusable/md/search_boolean_operators.md" >}}

{{< readfile file="content/reusable/md/search_boolean_operators_andnot.md" >}}

### AND

{{< readfile file="content/reusable/md/search_boolean_and.md" >}}

### NOT

{{< readfile file="content/reusable/md/search_boolean_not.md" >}}

### OR

{{< readfile file="content/reusable/md/search_boolean_or.md" >}}

## Special Characters

{{< readfile file="content/reusable/md/search_special_characters.md" >}}

## Targets

A search target is any object that has been indexed on the Chef Infra
Server, including roles (and run-lists), nodes, environments, data bags,
and any API client.

### Roles in Run-lists

A search query can be made for roles that are at the top-level of a
run-list and also for a role that's part of an expanded run-list.

{{< note >}}

The `roles` field is updated with each Chef Infra Client run; changes to
a run-list won't affect `roles` until the next Chef Infra Client run
on the node.

{{< /note >}}

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Role Location</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><p>Top-level</p></td>
<td><p>To find a node with a role in the top-level of its run-list, search within the <code>role</code> field (and escaping any special characters with the slash symbol) using the following syntax:</p>
<pre><code>role:ROLE_NAME</code></pre>
<p>where <code>role</code> (singular!) indicates the top-level run-list.</p></td>
</tr>
<tr>
<td><p>Expanded</p></td>
<td><p>To find a node with a role in an expanded run-list, search within the <code>roles</code> field (and escaping any special characters with the slash symbol) using the following syntax:</p>
<pre><code>roles:ROLE_NAME</code></pre>
<p>where <code>roles</code> (plural!) indicates the expanded run-list.</p></td>
</tr>
</tbody>
</table>

To search a top-level run-list for a role named `load_balancer` use the
`knife search` subcommand from the command line or the `search` method
in a recipe. For example:

```bash
knife search node role:load_balancer
```

and from within a recipe:

```ruby
search(:node, 'role:load_balancer')
```

To search an expanded run-list for all nodes with the role
`load_balancer` use the `knife search` subcommand from the command line
or the `search` method in a recipe. For example:

```bash
knife search node roles:load_balancer
```

and from within a recipe:

```ruby
search(:node, 'roles:load_balancer')
```

### Nodes

A node can be searched from a recipe by using the following syntax:

```ruby
search(:node, "key:attribute")
```

A wildcard can be used to replace characters within the search query.

Expanded lists of roles (all of the roles that apply to a node,
including nested roles) and recipes to the role and recipe attributes on
a node are saved on the Chef Infra Server. The expanded lists of roles
allows for searching within nodes that run a given recipe, even if that
recipe is included by a role.

{{< note >}}

The `recipes` field is with each Chef Infra Client run; changes to a
run-list won't affect `recipes` until the next Chef Infra Client run
on the node.

{{< /note >}}

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Node Location</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><p>In a specified recipe</p></td>
<td><p>To find a node with a specified recipe in the run-list, search within the <code>run_list</code> field (and escaping any special characters with the slash symbol) using the following syntax:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>search(<span class="st">:node</span>, <span class="st">&#39;run_list:recipe\[foo\:\:bar\]&#39;</span>)</span></code></pre></div>
<p>where <code>recipe</code> (singular!) indicates the top-level run-list. Variables can be interpolated into search strings using the Ruby alternate quoting syntax:</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb2-1"><a href="#cb2-1"></a>search(<span class="st">:node</span>,<span class="ot"> %Q{</span><span class="st">run_list:&quot;recipe[</span><span class="ot">#{</span>the_recipe<span class="ot">}</span><span class="st">]&quot;</span><span class="ot">}</span> )</span></code></pre></div></td>
</tr>
<tr>
<td><p>In an expanded run-list</p></td>
<td><p>To find a node with a recipe in an expanded run-list, search within the <code>recipes</code> field (and escaping any special characters with the slash symbol) using the following syntax:</p>
<div class="sourceCode" id="cb3"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb3-1"><a href="#cb3-1"></a>recipes<span class="st">:RECIPE_NAME</span></span></code></pre></div>
<p>where <code>recipes</code> (plural!) indicates to search within an expanded run-list.</p></td>
</tr>
</tbody>
</table>

If you just want to use each result of the search and don't care about
the aggregate result you can provide a code block to the search method.
Each result is then passed to the block:

```ruby
# Print every node matching the search pattern
search(:node, "*:*").each do |matching_node|
  puts matching_node.to_s
end
```

### API Clients

An API client is any machine that has permission to use the Chef Infra
Server API to communicate with the Chef Infra Server. An API client is
typically a node (that runs Chef Infra Client) or a workstation (that
runs knife), but can also be any other machine configured to use the
Chef Infra Server API.

Sometimes when a role isn't fully defined (or implemented), it may be
necessary for a machine to connect to a database, search engine, or some
other service within an environment by using the settings located on
another machine, such as a host name, IP address, or private IP address.
The following example shows a simplified settings file:

```ruby
username: "mysql"
password: "MoveAlong"
host:     "10.40.64.202"
port:     "3306"
```

where `host` is the private IP address of the database server. Use the
following knife query to view information about the node:

```bash
knife search node "name:name_of_database_server" --long
```

To access these settings as part of a recipe that's run on the web
server, use code similar to:

```ruby
db_server = search(:node, "name:name_of_database_server")
private_ip = "#{db_server[0][:rackspace][:private_ip]}"
puts private_ip
```

where the "\[0\]" is the 0 (zero) index for the `db_server` identifier.
A single document is returned because the node is being searched on its
unique name. The identifier `private_ip` will now have the value of the
private IP address of the database server (`10.40.64.202`) and can then
be used in templates as a variable, among other possible uses.

### Environments

{{< readfile file="content/reusable/md/environment.md" >}}

{{< readfile file="content/reusable/md/search_environment.md" >}}

### Data Bags

{{< readfile file="content/reusable/md/data_bag.md" >}}

{{< readfile file="content/reusable/md/search_data_bag.md" >}}
