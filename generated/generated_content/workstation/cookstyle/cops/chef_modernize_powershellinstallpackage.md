+++
title = "Chef/Modernize/PowershellInstallPackage"
aliases = ["/workstation/cookstyle/chef_modernize_powershellinstallpackage/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 12.16+ |

Use the powershell_package resource built into Chef Infra Client instead of the powershell_script resource to run Install-Package

 ### correct
 powershell_package 'docker'

## Examples

### incorrect

```ruby
powershell_script 'Expand website' do
  code 'Install-Package -Name docker'
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
