+++
title = "Chef/RedundantCode/PropertyWithRequiredAndDefault"
aliases = ["/workstation/cookstyle/chef_redundantcode_propertywithrequiredanddefault/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/RedundantCode`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

When using properties in a custom resource you shouldn't set a property to
required and then provide a default value. If a property is required the
user will always pass in a value and the default will never be used. In Chef
Infra Client 13+ this became an error.

## Examples

### incorrect

```ruby
property :bob, String, required: true, default: 'foo'
```

### correct

```ruby
property :bob, String, required: true
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
<td style="text-align:center">5.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
