+++
title = "Chef/RedundantCode/UnnecessaryNameProperty"
aliases = ["/workstation/cookstyle/chef_redundantcode_unnecessarynameproperty/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/RedundantCode`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.

## Examples

### incorrect

```ruby
property :name, String
property :name, String, name_property: true
attribute :name, kind_of: String
attribute :name, kind_of: String, name_attribute: true
attribute :name, name_attribute: true, kind_of: String
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
<td style="text-align:center">5.8.0</td>
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
