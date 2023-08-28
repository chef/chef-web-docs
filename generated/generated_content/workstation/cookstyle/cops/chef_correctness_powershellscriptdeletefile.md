+++
title = "Chef/Correctness/PowershellScriptDeleteFile"
aliases = ["/workstation/cookstyle/chef_correctness_powershellscriptdeletefile/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Use the `file` or `directory` resources built into Chef Infra Client with the :delete action to remove files/directories instead of using Remove-Item in a powershell_script resource

 ### correct
 file 'C:\Windows\foo\bar.txt' do
   action :delete
 end

## Examples

### incorrect

```ruby
powershell_script 'Cleanup old files' do
  code 'Remove-Item C:\Windows\foo\bar.txt'
  only_if { ::File.exist?('C:\\Windows\\foo\\bar.txt') }
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
<td style="text-align:center">6.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
