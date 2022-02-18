+++
title = "PowershellFileExists"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `PowershellFileExists`

The full name of the cop is: `Chef/Correctness/PowershellFileExists`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
powershell_out('Test-Path "C:\\Program Files\\LAPS\\CSE\\AdmPwd.dll"').stdout.strip == 'True'
```

#### correct

```ruby
::File.exist?('C:\Program Files\LAPS\CSE\AdmPwd.dll')
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
<td style="text-align:center">7.19</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
