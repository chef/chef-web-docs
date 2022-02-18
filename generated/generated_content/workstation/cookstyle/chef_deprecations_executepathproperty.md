+++
title = "ExecutePathProperty"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ExecutePathProperty`

The full name of the cop is: `Chef/Deprecations/ExecutePathProperty`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
execute 'some_cmd' do
  path '/foo/bar'
end
```

#### correct

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
