+++
title = "Chef Infra Language: Editing Resources"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Editing Resources"
    identifier = "chef_infra/cookbook_reference/infra_language/editing_resources.md Editing Resources"
    parent = "chef_infra/cookbook_reference/infra_language"
    weight = 80
+++

## declare_resource

Use the `declare_resource` method to instantiate a resource and then add it to the resource collection.

The syntax for the `declare_resource` method is as follows:

```ruby
declare_resource(:resource_type, 'resource_name', resource_attrs_block)
```

where:

- `:resource_type` is the resource type, such as `:file` (for the **file** resource), `:template` (for the **template** resource), and so on. Any resource available to Chef may be declared.
- `resource_name` the property that is the default name of the resource, typically the string that appears in the `resource 'name' do` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
- `resource_attrs_block` is a block in which properties of the instantiated resource are declared.

For example:

```ruby
declare_resource(:file, '/x/y.txy', caller[0]) do
  action :delete
end
```

is equivalent to:

```ruby
file '/x/y.txt' do
  action :delete
end
```

## delete_resource

Use the `delete_resource` method to find a resource in the resource collection, and then delete it.

The syntax for the `delete_resource` method is as follows:

```ruby
delete_resource(:resource_type, 'resource_name')
```

where:

- `:resource_type` is the resource type, such as `:file` (for the **file** resource), `:template` (for the **template** resource), and so on. Any resource available to Chef may be declared.
- `resource_name` the property that is the default name of the resource, typically the string that appears in the `resource 'name' do` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

```ruby
delete_resource(:template, '/x/y.erb')
```

## delete_resource!

Use the `delete_resource!` method to find a resource in the resource
collection, and then delete it. If the resource is not found, an
exception is returned.

The syntax for the `delete_resource!` method is as follows:

```ruby
delete_resource!(:resource_type, 'resource_name')
```

where:

- `:resource_type` is the resource type, such as `:file` (for the **file** resource), `:template` (for the **template** resource), and so on. Any resource available to Chef Infra may be declared.
- `resource_name` the property that is the default name of the resource, typically the string that appears in the `resource 'name' do` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

```ruby
delete_resource!(:file, '/x/file.txt')
```

## edit_resource

Use the `edit_resource` method to:

- Find a resource in the resource collection, and then edit it.
- Define a resource block. If a resource block with the same name exists in the resource collection, it will be updated with the contents of the resource block defined by the `edit_resource` method. If a resource block does not exist in the resource collection, it will be created.

The syntax for the `edit_resource` method is as follows:

```ruby
edit_resource(:resource_type, 'resource_name', resource_attrs_block)
```

where:

- `:resource_type` is the resource type, such as `:file` (for the **file** resource), `:template` (for the **template** resource), and so on. Any resource available to Chef may be declared.
- `resource_name` the property that is the default name of the resource, typically the string that appears in the `resource 'name' do` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
- `resource_attrs_block` is a block in which properties of the instantiated resource are declared.

For example:

```ruby
edit_resource(:template, '/x/y.txy') do
  cookbook 'cookbook_name'
end
```

and a resource block:

```ruby
edit_resource(:template, '/etc/aliases') do
  source 'aliases.erb'
  cookbook 'aliases'
  variables({:aliases => {} })
  notifies :run, 'execute[newaliases]'
end
```

## edit_resource!

Use the `edit_resource!` method to:

- Find a resource in the resource collection, and then edit it.
- Define a resource block. If a resource with the same name exists in the resource collection, its properties will be updated with the contents of the resource block defined by the `edit_resource` method.

In both cases, if the resource is not found, an exception is returned.

The syntax for the `edit_resource!` method is as follows:

```ruby
edit_resource!(:resource_type, 'resource_name')
```

where:

- `:resource_type` is the resource type, such as `:file` (for the **file** resource), `:template` (for the **template** resource), and so on. Any resource available to Chef may be declared.
- `resource_name` the property that is the default name of the resource, typically the string that appears in the `resource 'name' do` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
- `resource_attrs_block` is a block in which properties of the instantiated resource are declared.

For example:

```ruby
edit_resource!(:file, '/x/y.rst')
```

## find_resource

Use the `find_resource` method to:

- Find a resource in the resource collection.
- Define a resource block. If a resource block with the same name exists in the resource collection, it will be returned. If a resource block does not exist in the resource collection, it will be created.

The syntax for the `find_resource` method is as follows:

```ruby
find_resource(:resource_type, 'resource_name')
```

where:

- `:resource_type` is the resource type, such as `:file` (for the **file** resource), `:template` (for the **template** resource), and so on. Any resource available to Chef may be declared.
- `resource_name` the property that is the default name of the resource, typically the string that appears in the `resource 'name' do` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

```ruby
find_resource(:template, '/x/y.txy')
```

and a resource block:

```ruby
find_resource(:template, '/etc/seapower') do
  source 'seapower.erb'
  cookbook 'seapower'
  variables({:seapower => {} })
  notifies :run, 'execute[newseapower]'
end
```

## find_resource!

Use the `find_resource!` method to find a resource in the resource collection. If the resource is not found, an exception is returned.

The syntax for the `find_resource!` method is as follows:

```ruby
find_resource!(:resource_type, 'resource_name')
```

where:

- `:resource_type` is the resource type, such as `:file` (for the **file** resource), `:template` (for the **template** resource), and so on. Any resource available to Chef may be declared.
- `resource_name` the property that is the default name of the resource, typically the string that appears in the `resource 'name' do` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

```ruby
find_resource!(:template, '/x/y.erb')
```
