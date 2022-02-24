+++
title = "DoubleCompileTime"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DoubleCompileTime`

The full name of the cop is: `Chef/RedundantCode/DoubleCompileTime`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

If a resource includes the `compile_time` property there's no need to also use `.run_action(:some_action)` on the resource block

## Examples


#### incorrect

```ruby
chef_gem 'deep_merge' do
  action :nothing
  compile_time true
end.run_action(:install)
```

#### correct

```ruby
chef_gem 'deep_merge' do
  action :install
  compile_time true
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
<td style="text-align:center">6.13.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
