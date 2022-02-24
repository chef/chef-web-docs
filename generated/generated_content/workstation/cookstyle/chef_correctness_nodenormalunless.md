+++
title = "NodeNormalUnless"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `NodeNormalUnless`

The full name of the cop is: `Chef/Correctness/NodeNormalUnless`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Normal attributes are discouraged since their semantics differ importantly from the default and override levels. Their values persist in the node object even after all code referencing them has been deleted, unlike default and override.

Code should be updated to use default or override levels, but this will change attribute merging behavior so needs to be validated manually and force_default or force_override levels may need to be used in recipe code.

## Examples


#### incorrect

```ruby
node.normal_unless['foo'] = true
```

#### correct

```ruby
node.default_unless['foo'] = true
node.override_unless['foo'] = true
node.force_default_unless['foo'] = true
node.force_override_unless['foo'] = true
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
