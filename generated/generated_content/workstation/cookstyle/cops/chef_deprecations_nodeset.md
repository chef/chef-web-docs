+++
title = "Chef/Deprecations/NodeSet"
aliases = ["/workstation/cookstyle/chef_deprecations_nodeset/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The `node.set` method has been removed in Chef Infra Client 13 and usage must be replaced with `node.normal`.

This cop will autocorrect code to use node.normal, which is functionally identical to node.set, but we also discourage the use of that method as normal level attributes persist on the node even if the code setting the attribute is later removed.

## Examples

### incorrect

```ruby
node.set['foo'] = true
```

### correct

```ruby
node.normal['foo'] = true
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
<td style="text-align:center">5.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
