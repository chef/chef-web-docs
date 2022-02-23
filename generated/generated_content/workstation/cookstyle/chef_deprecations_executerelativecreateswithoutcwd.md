+++
title = "ExecuteRelativeCreatesWithoutCwd"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ExecuteRelativeCreatesWithoutCwd`

The full name of the cop is: `Chef/Deprecations/ExecuteRelativeCreatesWithoutCwd`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
execute 'some_cmd' do
  creates 'something'
end
```

#### correct

```ruby
execute 'some_cmd' do
  creates '/tmp/something'
end

execute 'some_cmd' do
  creates 'something'
  cwd '/tmp/'
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
