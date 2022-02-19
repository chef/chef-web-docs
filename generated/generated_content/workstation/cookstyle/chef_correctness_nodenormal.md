+++
title = "NodeNormal"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `NodeNormal`

The full name of the cop is: `Chef/Correctness/NodeNormal`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
node.normal['foo'] = true
```

#### correct

```ruby
node.default['foo'] = true
node.override['foo'] = true
node.force_default['foo'] = true
node.force_override['foo'] = true
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
