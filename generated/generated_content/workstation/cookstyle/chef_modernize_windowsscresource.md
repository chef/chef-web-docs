+++
title = "WindowsScResource"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `WindowsScResource`

The full name of the cop is: `Chef/Modernize/WindowsScResource`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 14.0+ |

## Examples


#### incorrect

```ruby
sc_windows 'chef-client' do
  path "C:\\opscode\\chef\\bin"
  action :create
end
```

#### correct

```ruby
windows_service 'chef-client' do
  action :create
  binary_path_name "C:\\opscode\\chef\\bin"
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
<td style="text-align:center">5.16.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
