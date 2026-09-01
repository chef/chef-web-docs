+++
title = "Chef/Modernize/PowershellDownloadFile"
aliases = ["/workstation/cookstyle/chef_modernize_powershelldownloadfile/"]

[menu]
  [menu.workstation]
    title = "PowershellDownloadFile"
    identifier = "chef_workstation/cookstyle/cops/Chef/Modernize/PowershellDownloadFile"
    parent = "chef_workstation/cookstyle/cops/Chef/Modernize"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Use the `remote_file` resource to download files instead of shelling out to PowerShell.
`remote_file` is idempotent, supports checksum verification, proxies, and conditional
downloads with etags and last-modified headers, none of which a script gets for free.

## Examples

```ruby
# bad
powershell_script 'download the installer' do
  code 'Invoke-WebRequest -Uri https://example.com/foo.msi -OutFile C:\foo.msi'
end

# good
remote_file 'C:\foo.msi' do
  source 'https://example.com/foo.msi'
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
<td style="text-align:center">9.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
