+++
title = "NamePropertyWithDefaultValue"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `NamePropertyWithDefaultValue`

The full name of the cop is: `Chef/Deprecations/NamePropertyWithDefaultValue`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

A resource property (or attribute) can't be marked as a name_property (or name_attribute) and also have a default value. The name property is a special property that is derived from the name of the resource block in and thus always has a value passed to the resource. For example if you define `my_resource 'foo'` in recipe, then the name property of `my_resource` will automatically be set to `foo`. Setting a property to be both a name_property and have a default value will cause Chef Infra Client failures in 13.0 and later releases.

## Examples


#### incorrect

```ruby
property :config_file, String, default: 'foo', name_property: true
attribute :config_file, String, default: 'foo', name_attribute: true
```

#### correct

```ruby
property :config_file, String, name_property: true
attribute :config_file, String, name_attribute: true
```

## Configurable attributes

<table>
<tbody><tr>
<th>Name</th>
<th>Default value</th>
<th>Configurable values</th>
</tr>
<tr>
<td style="text-align:center">Version Added</td>
<td style="text-align:center">5.7.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
