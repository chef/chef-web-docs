+++
title = "Chef/Deprecations/NodeDeepFetch"
aliases = ["/workstation/cookstyle/chef_deprecations_nodedeepfetch/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The node.deep_fetch method has been removed from Chef-Sugar, and must be replaced by the node.read API.

## Examples

### incorrect

```ruby
node.deep_fetch("foo")
```

### correct

```ruby
node.read("foo")

### incorrect

```ruby
node.deep_fetch!("foo")
```

### correct

```ruby
node.read!("foo")
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
<td style="text-align:center">5.12.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
