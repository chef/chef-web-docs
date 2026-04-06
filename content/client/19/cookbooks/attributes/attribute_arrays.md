+++
title = "Attribute Arrays"
description = "Define multiple attributes in an array or hash and deep merge"
draft = false

[menu]
  [menu.cookbooks]
    title = "Attributes Arrays"
    identifier = "cookbooks/attributes/attribute_arrays Attribute Arrays"
    parent = "cookbooks/attributes"
+++

<!-- vale proselint.But = NO -->

Attributes are typically defined in cookbooks, recipes, roles, and environments.
These attributes are rolled up to the node level during a Chef Infra Client run.
A recipe can store attribute values using a multi-level hash or array.

For example, a group of attributes for web servers might be:

```ruby
override_attributes(
  :apache => {
    :listen_ports => [ 80 ],
    :prefork => {
      :startservers => 20,
      :minspareservers => 20,
      :maxspareservers => 40
    }
  }
)
```

But, what if all of the web servers aren't the same or require a single attribute to have a different value?
You could store these settings in two locations: one like the preceding example and one like the following:

```ruby
override_attributes(
  :apache => {
    :listen_ports => [ 80 ],
    :prefork => {
      :startservers => 30,
      :minspareservers => 20,
      :maxspareservers => 40
    }
  }
)
```

But that isn't efficient, especially because most of them are identical.

Chef Infra Client's deep merge capabilities allow you to layer attributes across cookbooks, recipes, roles, and environments.
This allows an attribute to be reused across nodes, making use of default attributes set at the cookbook level, while also providing a way for certain attributes (with a higher attribute precedence) to be applied only when they're needed.

For example, you can have a role named `baseline.rb`:

```ruby
name "baseline"
description "The most basic role for all configurations"
run_list "recipe[baseline]"

override_attributes(
  :apache => {
    :listen_ports => [ 80 ],
    :prefork => {
      :startservers => 20,
      :minspareservers => 20,
      :maxspareservers => 40
    }
  }
)
```

and a role named `web.rb`:

```ruby
name 'web'
description 'Web server config'
run_list 'role[baseline]'

override_attributes(
  :apache => {
    :prefork => {
      :startservers => 30
    }
  }
)
```

The `web.rb` role references the `baseline.rb` role.
The `web.rb` file only provides a value for one attribute: `:startservers`.
When Chef Infra Client compares these attributes, the deep merge feature ensures that `:startservers` (and its value of `30`) is applied to any node for which the `web.rb` attribute structure should be applied.

This approach allows a recipe like this:

```ruby
include_recipe 'apache2'
Chef::Log.info(node['apache']['prefork'].to_hash)
```

and a `run_list` like this:

```ruby
run_list/web.json
{
  "run_list": [ "role[web]" ]
}
```

to produce results like this:

```ruby
[Tue, 16 Aug 2011 14:44:26 -0700] INFO:
         {
           "startservers"=>30,
           "minspareservers"=>20,
           "maxspareservers"=>40,
           "serverlimit"=>400,
           "maxclients"=>400,
           "maxrequestsperchild"=>10000
         }
```

Even though the `web.rb` file doesn't contain attributes and values for `minspareservers`, `maxspareservers`, `serverlimit`, `maxclients`, and `maxrequestsperchild`, the deep merge capabilities pulled them in.

## Attribute array logic

The following sections show how the logic works for using deep merge to perform substitutions and additions of attributes.

When an attribute value is a hash, that data is merged.
When an attribute value is an array, if the attribute precedence levels are the same, then that data is merged.
If the attribute value precedence levels in an array are different, then that data is replaced.
For all other value types (such as strings or integers), that data is replaced.

### Substitution

The following examples show how the logic works for substituting an existing string using a hash:

```text
role_or_environment 1 { :x => '1', :y => '2' }
+
role_or_environment 2 { :y => '3' }
=
{ :x => '1', :y => '3' }
```

For substituting an existing boolean using a hash:

```text
role_or_environment 1 { :x => true, :y => false }
+
role_or_environment 2 { :y => true }
=
{ :x => true, :y => true }
```

For substituting an array with a hash:

```text
role_or_environment 1 [ '1', '2', '3' ]
+
role_or_environment 2 { :x => '1' , :y => '2' }
=
{ :x => '1', :y => '2' }
```

When items can't be merged through substitution, the original data is overwritten.

### Addition

The following examples show how the logic works for adding a string
using a hash:

```text
role_or_environment 1 { :x => '1', :y => '2' }
+
role_or_environment 2 { :z => '3' }
=
{ :x => '1', :y => '2', :z => '3' }
```

For adding a string using an array:

```text
role_or_environment 1 [ '1', '2' ]
+
role_or_environment 2 [ '3' ]
=
[ '1', '2', '3' ]
```

For adding a string using a multi-level hash:

```text
role_or_environment 1 { :x => { :y => '2' } }
+
role_or_environment 2 { :x => { :z => '3' } }
=
{ :x => { :y => '2', :z => '3' } }
```

For adding a string using a multi-level array:

```text
role_or_environment 1 [ [ 1, 2 ] ]
+
role_or_environment 2 [ [ 3 ] ]
=
[ [ 1, 2 ], [ 3 ] ]
```
