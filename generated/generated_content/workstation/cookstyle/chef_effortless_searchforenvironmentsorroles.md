+++
title = "SearchForEnvironmentsOrRoles"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `SearchForEnvironmentsOrRoles`

The full name of the cop is: `Chef/Effortless/SearchForEnvironmentsOrRoles`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
search(:node, 'chef_environment:foo')
search(:node, 'role:bar')
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
<td style="text-align:center">5.11.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
