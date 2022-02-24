+++
title = "CookbookUsesNodeSave"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `CookbookUsesNodeSave`

The full name of the cop is: `Chef/Correctness/CookbookUsesNodeSave`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Don't use node.save to save partial node data to the Chef Infra Server mid-run unless it's a requirement of cookbook design that can't be avoided. Node.save can result in failed Chef Infra runs appearing in search and increases load on the Chef Infra Server."

## Examples


#### incorrect

```ruby
node.save
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
<td style="text-align:center">5.5.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
