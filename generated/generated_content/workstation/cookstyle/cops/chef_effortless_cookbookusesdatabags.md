+++
title = "Chef/Effortless/CookbookUsesDatabags"
aliases = ["/workstation/cookstyle/chef_effortless_cookbookusesdatabags/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Effortless`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | All Versions |

Data bags cannot be used with the Effortless Infra pattern

## Examples

### incorrect

```ruby
data_bag_item('admins', login)
data_bag(data_bag_name)
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
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
