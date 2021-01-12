+++
title = "Chef Infra Language: Cookbook Execution"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Cookbook Execution"
    identifier = "chef_infra/cookbook_reference/infra_language/cookbook_execution.md Cookbook Execution"
    parent = "chef_infra/cookbook_reference/infra_language"
    weight = 20
+++

### cookbook_name

Use the `cookbook_name` method to return the name of a cookbook.

The syntax for the `cookbook_name` method is as follows:

```ruby
cookbook_name
```

This method is often used as part of a log entry. For example:

```ruby
Chef::Log.info('I am a message from the #{recipe_name} recipe in the #{cookbook_name} cookbook.')
```

### recipe_name

Use the `recipe_name` method to return the name of a recipe.

The syntax for the `recipe_name` method is as follows:

```ruby
recipe_name
```

This method is often used as part of a log entry. For example:

```ruby
Chef::Log.info('I am a message from the #{recipe_name} recipe in the #{cookbook_name} cookbook.')
```

### resources

Use the `resources` method to look up a resource in the resource
collection. The `resources` method returns the value for the resource
that it finds in the resource collection. The preferred syntax for the
`resources` method is as follows:

```ruby
resources('resource_type[resource_name]')
```

but the following syntax can also be used:

```ruby
resources(resource_type: 'resource_name')
```

where in either approach `resource_type` is the name of a resource and
`resource_name` is the name of a resource that can be configured by Chef
Infra Client.

The `resources` method can be used to modify a resource later on in a
recipe. For example:

```ruby
file '/etc/hosts' do
  content '127.0.0.1 localhost.localdomain localhost'
end
```

and then later in the same recipe, or elsewhere:

```ruby
f = resources('file[/etc/hosts]')
f.mode '0644'
```

where `file` is the type of resource, `/etc/hosts` is the name, and
`f.mode` is used to set the `mode` property on the **file** resource.

### with_run_context

Use the `with_run_context` method to define a block that has a pointer
to a location in the `run_context` hierarchy. Resources in recipes
always run at the root of the `run_context` hierarchy, whereas custom
resources and notification blocks always build a child `run_context`
which contains their sub-resources.

The syntax for the `with_run_context` method is as follows:

```ruby
with_run_context :type do
  # some arbitrary pure Ruby stuff goes here
end
```

where `:type` may be one of the following:

-   `:root` runs the block as part of the root `run_context` hierarchy
-   `:parent` runs the block as part of the parent process in the
    `run_context` hierarchy

For example:

```ruby
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

### include_recipe

{{% cookbooks_recipe_include_in_recipe %}}

### attribute?

Use the `attribute?` method to ensure that certain actions only execute
in the presence of a particular node attribute. The `attribute?` method
will return true if one of the listed node attributes matches a node
attribute that is detected by Ohai during every Chef Infra Client run.

The syntax for the `attribute?` method is as follows:

```ruby
attribute?('name_of_attribute')
```

For example:

```ruby
if node.attribute?('ipaddress')
  # the node has an ipaddress
end
```

### reboot_pending?

Use the `reboot_pending?` method to test if a node needs a reboot, or is
expected to reboot. `reboot_pending?` returns `true` when the node needs
a reboot.

The syntax for the `reboot_pending?` method is as follows:

```ruby
reboot_pending?
```