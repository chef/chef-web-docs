+++
title = "IncludingAptDefaultRecipe"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `IncludingAptDefaultRecipe`

The full name of the cop is: `Chef/Modernize/IncludingAptDefaultRecipe`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 12.7+ |

## Examples


#### incorrect

```ruby
include_recipe 'apt::default'
include_recipe 'apt'
```

#### correct

```ruby
apt_update
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
<td style="text-align:center">5.3.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
