+++
title = "Chef/Deprecations/NodeSetWithoutLevel"
aliases = ["/workstation/cookstyle/chef_deprecations_nodesetwithoutlevel/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

When setting a node attribute in Chef Infra Client 11 and later you must specify the precedence level.

## Examples

### incorrect

```ruby
node['foo']['bar'] = 1
node['foo']['bar'] << 1
node['foo']['bar'] += 1
node['foo']['bar'] -= 1
```

### correct

```ruby
node.default['foo']['bar'] = 1
node.default['foo']['bar'] << 1
node.default['foo']['bar'] += 1
node.default['foo']['bar'] -= 1
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
<td style="text-align:center">5.13.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
