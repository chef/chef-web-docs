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

Chef Infra Client evaluates attributes in the order that they are defined in the
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

{{% ohai_automatic_attribute %}}

{{% ohai_attribute_list %}}

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

{{% node_attribute_when_to_use_unless_variants %}}

**File Methods**

{{% cookbooks_attribute_file_methods %}}

**attribute?**

A useful method that is related to attributes is the `attribute?`
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

{{% cookbooks_recipe %}}

{{% cookbooks_attribute %}}

## Attributes from Roles

{{% role %}}

{{% role_attribute %}}

## Attributes from Environments

{{% environment %}}

{{% environment_attribute %}}
