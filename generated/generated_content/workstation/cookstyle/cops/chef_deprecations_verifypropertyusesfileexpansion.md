+++
title = "Chef/Deprecations/VerifyPropertyUsesFileExpansion"
aliases = ["/workstation/cookstyle/chef_deprecations_verifypropertyusesfileexpansion/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.5+ |

In Chef Infra Client 13 the "file" variable for use within the verify property was replaced with the "path" variable.

## Examples

### incorrect

```ruby
file '/etc/nginx.conf' do
  verify 'nginx -t -c %{file}'
end
```

### correct

```ruby
file '/etc/nginx.conf' do
  verify 'nginx -t -c %{path}'
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
<td style="text-align:center">5.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
