+++
title = "IncludeRecipeWithParentheses"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `IncludeRecipeWithParentheses`

The full name of the cop is: `Chef/Style/IncludeRecipeWithParentheses`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

There is no need to wrap the recipe in parentheses when using the include_recipe helper.

## Examples


#### incorrect

```ruby
include_recipe('foo::bar')
```

#### correct

```ruby
include_recipe 'foo::bar'
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
<td style="text-align:center">6.11.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
