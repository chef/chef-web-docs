+++
title = "ResourceForcingCompileTime"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ResourceForcingCompileTime`

The full name of the cop is: `Chef/Modernize/ResourceForcingCompileTime`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
build_essential 'install build tools' do
 action :nothing
end.run_action(:install)
```

#### correct

```ruby
build_essential 'install build tools' do
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
<td style="text-align:center">5.18.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
