+++
title = "Attribute Sources"
draft = false

[menu]
  [menu.infra]
    title = "Attribute Sources"
    identifier = "chef_infra/cookbook_reference/attributes/attribute_sources Attributes"
    parent = "chef_infra/cookbook_reference/attributes"
+++
<!-- markdownlint-disable-file MD036 -->

Chef Infra Client evaluates attributes in the order that they're defined in the
run-list, including any attributes that are in the run-list as
cookbook dependencies.

Attributes are provided to Chef Infra Client from the following
locations:

- JSON files passed using the `chef-client -j`
- Nodes (collected by Ohai at the start of each Chef Infra Client run)
- Attribute files (in cookbooks)
- Recipes (in cookbooks)
- Environments
- Roles
- Policyfiles

Notes:

- Many attributes are maintained in the chef-repo for Policyfiles,
    environments, roles, and cookbooks (attribute files and recipes)
- Many attributes are collected by Ohai on each individual node at the
    start of every Chef Infra Client run
- The attributes that are maintained in the chef-repo are uploaded to
    the Chef Infra Server from the workstation, periodically
- Chef Infra Client will pull down the node object from the Chef Infra
    Server and then reset all the attributes except `normal`. The node
    object will contain the attribute data from the previous Chef Infra
    Client run including attributes set with JSON files using `-j`.
- Chef Infra Client will update the cookbooks on the node (if
    required), which updates the attributes contained in attribute files
    and recipes
- Chef Infra Client will update the role and environment data (if
    required)
- Chef Infra Client will rebuild the attribute list and apply
    attribute precedence while configuring the node
- Chef Infra Client pushes the node object to the Chef Infra Server at
    the end of a Chef Infra Client run; the updated node object on the
    Chef Infra Server is then indexed for search and is stored until the
    next Chef Infra Client run

## Automatic Attributes (Ohai)

{{< readfile file="content/reusable/md/ohai_automatic_attribute.md" >}}

{{< readfile file="content/reusable/md/ohai_attribute_list.md" >}}

## Attribute Files

An attribute file is located in the `attributes/` sub-directory for a
cookbook. When a cookbook is run against a node, the attributes
contained in all attribute files are evaluated in the context of the
node object. Node methods (when present) are used to set attribute
values on a node. For example, the `apache2` cookbook contains an
attribute file called `default.rb`, which contains the following
attributes:

```ruby
default['apache']['dir']          = '/etc/apache2'
default['apache']['listen_ports'] = [ '80','443' ]
```

The use of the node object (`node`) is implicit in the previous example;
the following example defines the node object itself as part of the
attribute:

```ruby
node.default['apache']['dir']          = '/etc/apache2'
node.default['apache']['listen_ports'] = [ '80','443' ]
```

Another (much less common) approach is to set a value only if an
attribute has no value. This can be done by using the `_unless` variants
of the attribute priority methods:

- `default_unless`
- `normal_unless`

Use the `_unless` variants carefully (and only when necessary) because
when they're used, attributes applied to nodes may become out of sync
with the values in the cookbooks as these cookbooks are updated. This
approach can create situations where two otherwise identical nodes end
up having slightly different configurations and can also be a challenge
to debug.

### File Methods

Use the following methods within the attributes file for a cookbook or within a recipe. These methods correspond to the attribute type of the same name:

- `override`
- `default`
- `normal`
- `_unless`

### attribute?

A useful method that's related to attributes is the `attribute?`
method. This method will check for the existence of an attribute, so
that processing can be done in an attributes file or recipe, but only if
a specific attribute exists.

Using `attribute?()` in an attributes file:

```ruby
if attribute?('ec2')
  # ... set stuff related to EC2
end
```

Using `attribute?()` in a recipe:

```ruby
if node.attribute?('ec2')
  # ... do stuff on EC2 nodes
end
```

## Attributes from Recipes

{{< readfile file="content/reusable/md/cookbooks_recipe.md" >}}

{{< readfile file="content/reusable/md/cookbooks_attribute.md" >}}

## Attributes from Roles

{{< readfile file="content/reusable/md/role.md" >}}

{{< readfile file="content/reusable/md/role_attribute.md" >}}

## Attributes from Environments

{{< readfile file="content/reusable/md/environment.md" >}}

{{< readfile file="content/reusable/md/environment_attribute.md" >}}
