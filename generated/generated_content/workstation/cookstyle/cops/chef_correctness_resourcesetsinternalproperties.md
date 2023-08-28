+++
title = "Chef/Correctness/ResourceSetsInternalProperties"
aliases = ["/workstation/cookstyle/chef_correctness_resourcesetsinternalproperties/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Chef Infra Client uses properties in several resources to track state. These should not be set in recipes as they break the internal workings of the Chef Infra Client

## Examples

### incorrect

```ruby
service 'foo' do
  running true
  action [:start, :enable]
end
```

### correct

```ruby
service 'foo' do
  action [:start, :enable]
end
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
