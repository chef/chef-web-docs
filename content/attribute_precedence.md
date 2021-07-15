+++
title = "Attribute Precedence"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Attribute Precedence"
    identifier = "chef_infra/cookbook_reference/attributes/attribute_precedence"
    parent = "chef_infra/cookbook_reference/attributes"
+++

{{% node_attribute_precedence %}}

## Examples

The following examples are listed from low to high precedence.

**Default attribute in /attributes/default.rb**

```ruby
default['apache']['dir'] = '/etc/apache2'
```

**Default attribute in node object in recipe**

```ruby
node.default['apache']['dir'] = '/etc/apache2'
```

**Default attribute in /environments/environment_name.rb**

```ruby
default_attributes({ 'apache' => {'dir' => '/etc/apache2'}})
```

**Default attribute in /roles/role_name.rb**

```ruby
default_attributes({ 'apache' => {'dir' => '/etc/apache2'}})
```

**Normal attribute set as a cookbook attribute**

```ruby
normal['apache']['dir'] = '/etc/apache2'
```

**Normal attribute set in a recipe**

```ruby
node.normal['apache']['dir'] = '/etc/apache2'
```

**Override attribute in /attributes/default.rb**

```ruby
override['apache']['dir'] = '/etc/apache2'
```

**Override attribute in /roles/role_name.rb**

```ruby
override_attributes({ 'apache' => {'dir' => '/etc/apache2'}})
```

**Override attribute in /environments/environment_name.rb**

```ruby
override_attributes({ 'apache' => {'dir' => '/etc/apache2'}})
```

**Override attribute in a node object (from a recipe)**

```ruby
node.override['apache']['dir'] = '/etc/apache2'
```

**Ensure that a default attribute has precedence over other attributes**

When a default attribute is set like this:

```ruby
default['attribute'] = 'value'
```

any value set by a role or an environment will replace it. To prevent
this value from being replaced, use the `force_default` attribute
precedence:

```ruby
force_default['attribute'] = 'I will crush you, role or environment attribute'
```

or:

```ruby
default!['attribute'] = "The '!' means I win!"
```

**Ensure that an override attribute has precedence over other
attributes**

When an override attribute is set like this:

```ruby
override['attribute'] = 'value'
```

any value set by a role or an environment will replace it. To prevent
this value from being replaced, use the `force_override` attribute
precedence:

```ruby
force_override['attribute'] = 'I will crush you, role or environment attribute'
```

or:

```ruby
override!['attribute'] = "The '!' means I win!"
```

## Change Attributes

Attribute precedence levels may be:

- Removed for a specific, named attribute precedence level.
- Removed for all attribute precedence levels.
- Fully assigned attributes.

### Remove Precedence Level

A specific attribute precedence level for default, normal, and override
attributes may be removed by using one of the following syntax patterns.

For default attributes:

- `node.rm_default('foo', 'bar')`

For normal attributes:

- `node.rm_normal('foo', 'bar')`

For override attributes:

- `node.rm_override('foo', 'bar')`

These patterns return the computed value of the key being deleted for
the specified precedence level.

#### Examples

The following examples show how to remove a specific, named attribute
precedence level.

**Delete a default value when only default values exist**

Given the following code structure under `'foo'`:

```ruby
node.default['foo'] = {
  'bar' => {
    'baz' => 52,
    'thing' => 'stuff',
  },
  'bat' => {
    'things' => [5, 6],
  },
}
```

And some role attributes:

```ruby
# Please don't ever do this in real code :)
node.role_default['foo']['bar']['thing'] = 'otherstuff'
```

And a force attribute:

```ruby
node.force_default['foo']['bar']['thing'] = 'allthestuff'
```

When the default attribute precedence `node['foo']['bar']` is removed:

```ruby
node.rm_default('foo', 'bar') #=> {'baz' => 52, 'thing' => 'allthestuff'}
```

What is left under `'foo'` is only `'bat'`:

```ruby
node.attributes.combined_default['foo'] #=> {'bat' => { 'things' => [5,6] } }
```

**Delete default without touching higher precedence attributes**

Given the following code structure:

```ruby
node.default['foo'] = {
  'bar' => {
    'baz' => 52,
    'thing' => 'stuff',
  },
  'bat' => {
    'things' => [5, 6],
  },
}
```

And some role attributes:

```ruby
# Please don't ever do this in real code :)
node.role_default['foo']['bar']['thing'] = 'otherstuff'
```

And a force attribute:

```ruby
node.force_default['foo']['bar']['thing'] = 'allthestuff'
```

And also some override attributes:

```ruby
node.override['foo']['bar']['baz'] = 99
```

Same delete as before:

```ruby
node.rm_default('foo', 'bar') #=> { 'baz' => 52, 'thing' => 'allthestuff' }
```

The other attribute precedence levels are unaffected:

```ruby
node.attributes.combined_override['foo'] #=> { 'bar' => {'baz' => 99} }
node['foo'] #=> { 'bar' => {'baz' => 99}, 'bat' => { 'things' => [5,6] }
```

**Delete override without touching lower precedence attributes**

Given the following code structure, which has an override attribute:

```ruby
node.override['foo'] = {
  'bar' => {
    'baz' => 52,
    'thing' => 'stuff',
  },
  'bat' => {
    'things' => [5, 6],
  },
}
```

with a single default value:

```ruby
node.default['foo']['bar']['baz'] = 11
```

and a force at each attribute precedence:

```ruby
node.force_default['foo']['bar']['baz'] = 55
node.force_override['foo']['bar']['baz'] = 99
```

Delete the override:

```ruby
node.rm_override('foo', 'bar') #=> { 'baz' => 99, 'thing' => 'stuff' }
```

The other attribute precedence levels are unaffected:

```ruby
node.attributes.combined_default['foo'] #=> { 'bar' => {'baz' => 55} }
```

**Non-existent key deletes return nil**

```ruby
node.rm_default("no", "such", "thing") #=> nil
```

### Remove All Levels

All attribute precedence levels may be removed by using the following
syntax pattern:

- `node.rm('foo', 'bar')`

{{< note >}}

Using `node['foo'].delete('bar')` will throw an exception that points to
the new API.

{{< /note >}}

#### Examples

The following examples show how to remove all attribute precedence
levels.

**Delete all attribute precedence levels**

Given the following code structure:

```ruby
node.default['foo'] = {
  'bar' => {
    'baz' => 52,
    'thing' => 'stuff',
  },
  'bat' => {
    'things' => [5, 6],
  },
}
```

With override attributes:

```ruby
node.override['foo']['bar']['baz'] = 999
```

Removing the `'bar'` key returns the computed value:

```ruby
node.rm('foo', 'bar') #=> {'baz' => 999, 'thing' => 'stuff'}
```

Looking at `'foo'`, all that's left is the `'bat'` entry:

```ruby
node['foo'] #=> {'bat' => { 'things' => [5,6] } }
```

**Non-existent key deletes return nil**

```ruby
node.rm_default("no", "such", "thing") #=> nil
```

### Full Assignment

Use `!` to clear out the key for the named attribute precedence level,
and then complete the write by using one of the following syntax
patterns:

- `node.default!['foo']['bar'] = {...}`
- `node.force_default!['foo']['bar'] = {...}`
- `node.normal!['foo']['bar'] = {...}`
- `node.override!['foo']['bar'] = {...}`
- `node.force_override!['foo']['bar'] = {...}`

#### Examples

The following examples show how to remove all attribute precedence
levels.

**Just one component**

Given the following code structure:

```ruby
node.default['foo']['bar'] = {'a' => 'b'}
node.default!['foo']['bar'] = {'c' => 'd'}
```

The `'!'` caused the entire 'bar' key to be overwritten:

```ruby
node['foo'] #=> {'bar' => {'c' => 'd'}
```

**Multiple components; one "after"**

Given the following code structure:

```ruby
node.default['foo']['bar'] = {'a' => 'b'}
# Please don't ever do this in real code :)
node.role_default['foo']['bar'] = {'c' => 'd'}
node.default!['foo']['bar'] = {'d' => 'e'}
```

The `'!'` write overwrote the "cookbook-default" value of `'bar'`, but
since role data is later in the resolution list, it was unaffected:

```ruby
node['foo'] #=> {'bar' => {'c' => 'd', 'd' => 'e'}
```

**Multiple components; all "before"**

Given the following code structure:

```ruby
node.default['foo']['bar'] = {'a' => 'b'}
# Please don't ever do this in real code :)
node.role_default['foo']['bar'] = {'c' => 'd'}
node.force_default!['foo']['bar'] = {'d' => 'e'}
```

With `force_default!` there is no other data under `'bar'`:

```ruby
node['foo'] #=> {'bar' => {'d' => 'e'}
```

**Multiple precedence levels**

Given the following code structure:

```ruby
node.default['foo'] = {
  'bar' => {
    'baz' => 52,
    'thing' => 'stuff',
  },
  'bat' => {
   'things' => [5, 6],
  },
}
```

And some attributes:

```ruby
# Please don't ever do this in real code :)
node.role_default['foo']['bar']['baz'] = 55
node.force_default['foo']['bar']['baz'] = 66
```

And other precedence levels:

```ruby
node.normal['foo']['bar']['baz'] = 88
node.override['foo']['bar']['baz'] = 99
```

With a full assignment:

```ruby
node.default!['foo']['bar'] = {}
```

Role default and force default are left in default, plus other
precedence levels:

```ruby
node.attributes.combined_default['foo'] #=> {'bar' => {'baz' => 66}, 'bat'=>{'things'=>[5, 6]}}
node.attributes.normal['foo'] #=> {'bar' => {'baz' => 88}}
node.attributes.combined_override['foo'] #=> {'bar' => {'baz' => 99}}
node['foo']['bar'] #=> {'baz' => 99}
```

If `force_default!` is written:

```ruby
node.force_default!['foo']['bar'] = {}
```

the difference is:

```ruby
node.attributes.combined_default['foo'] #=> {'bat'=>{'things'=>[5, 6]}, 'bar' => {}}
node.attributes.normal['foo'] #=> {'bar' => {'baz' => 88}}
node.attributes.combined_override['foo'] #=> {'bar' => {'baz' => 99}}
node['foo']['bar'] #=> {'baz' => 99}
```
