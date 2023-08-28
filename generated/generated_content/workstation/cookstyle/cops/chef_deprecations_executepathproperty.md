+++
title = "Chef/Deprecations/ExecutePathProperty"
aliases = ["/workstation/cookstyle/chef_deprecations_executepathproperty/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

In Chef Infra Client 13 and later you must set path env vars in execute resources using the `environment` property not the legacy `path` property.

## Examples

### incorrect

```ruby
execute 'some_cmd' do
  path '/foo/bar'
end
```

### correct

```ruby
execute 'some_cmd' do
  environment {path: '/foo/bar'}
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
<td style="text-align:center">6.17.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
