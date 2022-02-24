+++
title = "PowershellScriptExpandArchive"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `PowershellScriptExpandArchive`

The full name of the cop is: `Chef/Modernize/PowershellScriptExpandArchive`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 15.0+ |

Use the archive_file resource built into Chef Infra Client 15+ instead of using the powershell_script resource to run Expand-Archive

## Examples


#### incorrect

```ruby
powershell_script 'Expand website' do
  code 'Expand-Archive "C:\\file.zip" -DestinationPath "C:\\inetpub\\wwwroot\\" -Force'
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
