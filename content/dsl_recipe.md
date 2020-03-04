+++
title = "About the Recipe DSL"
draft = false

aliases = ["/dsl_recipe.html"]

[menu]
  [menu.docs]
    title = "DSL Overview"
    identifier = "chef_infra/cookbook_reference/recipe_dsl/dsl_recipe.md DSL Overview"
    parent = "chef_infra/cookbook_reference/recipe_dsl"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/dsl_recipe.md)

{{% dsl_recipe_summary %}}

Because the Chef Infra Recipe DSL is a Ruby DSL, anything that can be done using
Ruby can also be done in a recipe or custom resource, including `if` and
`case` statements, using the `include?` Ruby method, including recipes
in recipes, and checking for dependencies. See the [Ruby
Guide](/ruby/) for further information on built-in Ruby
functionality.

Include Recipes
===============

{{% cookbooks_recipe_include_in_recipe %}}

Reload Attributes
-----------------

{{% cookbooks_attribute_file_reload_from_recipe %}}

Recipe DSL Methods
==================

The Recipe DSL provides support for using attributes, data bags (and
encrypted data), and search results in a recipe, as well as helper
methods that can be used to check for a node's platform from the recipe
to ensure that specific actions are taken for specific platforms.

attribute?
----------

Use the `attribute?` method to ensure that certain actions only execute
in the presence of a particular node attribute. The `attribute?` method
will return true if one of the listed node attributes matches a node
attribute that is detected by Ohai during every Chef Infra Client run.

The syntax for the `attribute?` method is as follows:

``` ruby
attribute?('name_of_attribute')
```

For example:

``` ruby
if node.attribute?('ipaddress')
  # the node has an ipaddress
end
```

cookbook_name
--------------

Use the `cookbook_name` method to return the name of a cookbook.

The syntax for the `cookbook_name` method is as follows:

``` ruby
cookbook_name
```

This method is often used as part of a log entry. For example:

``` ruby
Chef::Log.info('I am a message from the #{recipe_name} recipe in the #{cookbook_name} cookbook.')
```

data_bag
---------

{{% data_bag %}}

Use the `data_bag` method to get a list of the contents of a data bag.

The syntax for the `data_bag` method is as follows:

``` ruby
data_bag(bag_name)
```

**Examples**

The following example shows how the `data_bag` method can be used in a
recipe.

**Get a data bag, and then iterate through each data bag item**

{{% dsl_recipe_data_bag %}}

data_bag_item
---------------

{{% data_bag %}}

The `data_bag_item` method can be used in a recipe to get the contents
of a data bag item.

The syntax for the `data_bag_item` method is as follows:

``` ruby
data_bag_item(bag_name, item, secret)
```

where `secret` is the secret used to load an encrypted data bag. If
`secret` is not specified, Chef Infra Client looks for a secret at the
path specified by the `encrypted_data_bag_secret` setting in the
client.rb file.

**Examples**

The following examples show how the `data_bag_item` method can be used
in a recipe.

**Get a data bag, and then iterate through each data bag item**

{{% dsl_recipe_data_bag %}}

**Use the contents of a data bag in a recipe**

The following example shows how to use the `data_bag` and
`data_bag_item` methods in a recipe, also using a data bag named
`sea-power`):

``` ruby
package 'sea-power' do
  action :install
end

directory node['sea-power']['base_path'] do
  # attributes for owner, group, mode
end

gale_warnings = data_bag('sea-power').map do |viking_north|
  data_bag_item('sea-power', viking_north)['source']
end

template '/etc/seattle/power.list' do
  source 'seattle-power.erb'
  # attributes for owner, group, mode
  variables(
    :base_path => node['sea-power']['base_path'],
    # more variables
    :repo_location => gale_warnings
  )
end
```

For a more complete version of the previous example, see the default
recipe in the <https://github.com/hw-cookbooks/apt-mirror> community
cookbook.

reboot_pending?
----------------

Use the `reboot_pending?` method to test if a node needs a reboot, or is
expected to reboot. `reboot_pending?` returns `true` when the node needs
a reboot.

The syntax for the `reboot_pending?` method is as follows:

``` ruby
reboot_pending?
```

recipe_name
------------

Use the `recipe_name` method to return the name of a recipe.

The syntax for the `recipe_name` method is as follows:

``` ruby
recipe_name
```

This method is often used as part of a log entry. For example:

``` ruby
Chef::Log.info('I am a message from the #{recipe_name} recipe in the #{cookbook_name} cookbook.')
```

search
------

{{% search %}}

Use the `search` method to perform a search query against the Chef Infra
Server from within a recipe.

The syntax for the `search` method is as follows:

``` ruby
search(:index, 'query')
```

where:

-   `:index` is of name of the index on the Chef Infra Server against
    which the search query will run: `:client`, `:data_bag_name`,
    `:environment`, `:node`, and `:role`
-   `'query'` is a valid search query against an object on the Chef
    Infra Server (see below for more information about how to build the
    query)

For example, using the results of a search query within a variable:

``` ruby
webservers = search(:node, 'role:webserver')
```

and then using the results of that query to populate a template:

``` ruby
template '/tmp/list_of_webservers' do
  source 'list_of_webservers.erb'
  variables(:webservers => webservers)
end
```

### :filter_result

{{% dsl_recipe_method_search_filter_result %}}

### Query Syntax

{{% search_query_syntax %}}

#### Keys

{{% search_key %}}

**Nested Fields**

{{% search_key_nested %}}

#### Patterns

{{% search_pattern %}}

**Exact Match**

{{% search_pattern_exact %}}

**Wildcard Match**

{{% search_pattern_wildcard %}}

**Range Match**

{{% search_pattern_range %}}

**Fuzzy Match**

{{% search_pattern_fuzzy %}}

#### Operators

{{% search_boolean_operators %}}

#### Special Characters

{{% search_special_characters %}}

### Examples

The following examples show how the `search` method can be used in a
recipe.

**Use the search recipe DSL method to find users**

{{% resource_execute_use_search_dsl_method %}}

tag, tagged?, untag
-------------------

{{% chef_tags %}}

{{% cookbooks_recipe_tags %}}

with_run_context
------------------

Use the `with_run_context` method to define a block that has a pointer
to a location in the `run_context` hierarchy. Resources in recipes
always run at the root of the `run_context` hierarchy, whereas custom
resources and notification blocks always build a child `run_context`
which contains their sub-resources.

The syntax for the `with_run_context` method is as follows:

``` ruby
with_run_context :type do
  # some arbitrary pure Ruby stuff goes here
end
```

where `:type` may be one of the following:

-   `:root` runs the block as part of the root `run_context` hierarchy
-   `:parent` runs the block as part of the parent process in the
    `run_context` hierarchy

For example:

``` ruby
action :run do
  with_run_context :root do
    edit_resource(:my_thing, "accumulated state") do
      action :nothing
      my_array_property << accumulate_some_stuff
    end
  end
  log "kick it off" do
    notifies :run, "my_thing[accumulated state]", :delayed
  end
end
```

Log Entries
===========

{{% ruby_style_basics_chef_log %}}

The following examples show using `Chef::Log` entries in a recipe.

{{% ruby_class_chef_log_fatal %}}

{{% ruby_class_chef_log_multiple %}}
