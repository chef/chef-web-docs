+++
title = "Chef/Correctness/PowershellFileExists"
aliases = ["/workstation/cookstyle/chef_correctness_powershellfileexists/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Use Ruby's built-in `File.exist?('C:\somefile')` method instead of executing PowerShell's `Test-Path` cmdlet, which takes longer to load.

## Examples

### incorrect

```ruby
powershell_out('Test-Path "C:\\Program Files\\LAPS\\CSE\\AdmPwd.dll"').stdout.strip == 'True'
```

### correct

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
