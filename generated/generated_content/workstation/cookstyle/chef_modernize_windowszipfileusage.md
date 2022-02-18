+++
title = "WindowsZipfileUsage"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `WindowsZipfileUsage`

The full name of the cop is: `Chef/Modernize/WindowsZipfileUsage`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 15.0+ |

## Examples


#### incorrect

```ruby
windows_zipfile 'C:\\files\\' do
  source 'C:\\Temp\\file.zip'
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
<td style="text-align:center">5.4.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
