+++
title = "Chef/Deprecations/NodeSetUnless"
aliases = ["/workstation/cookstyle/chef_deprecations_nodesetunless/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The node.set_unless method has been removed in Chef Infra Client 13 and usage must be replaced with node.normal_unless.

This cop will autocorrect code to use node.normal_unless, which is functionally identical to node.set_unless, but we also discourage the use of that method as normal level attributes persist on the node even if the code setting the attribute is later removed.

## Examples

### incorrect

```ruby
node.set_unless['foo'] = true
```

### correct

```ruby
node.normal_unless['foo'] = true
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
