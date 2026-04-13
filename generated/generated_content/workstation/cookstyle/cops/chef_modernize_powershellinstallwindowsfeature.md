+++
title = "Chef/Modernize/PowershellInstallWindowsFeature"
aliases = ["/workstation/cookstyle/chef_modernize_powershellinstallwindowsfeature/"]

[menu]
  [menu.workstation]
    title = "PowershellInstallWindowsFeature"
    identifier = "chef_workstation/cookstyle/cops/Chef/Modernize/PowershellInstallWindowsFeature"
    parent = "chef_workstation/cookstyle/cops/Chef/Modernize"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 14.0+ |

Use the windows_feature resource built into Chef Infra Client 14+ instead of the powershell_script resource to run Install-WindowsFeature or Add-WindowsFeature

## Examples

```ruby
# bad
powershell_script 'Install Feature' do
  code 'Install-WindowsFeature -Name "Net-framework-Core"'
end

# good
windows_feature 'Net-framework-Core' do
  action :install
  install_method :windows_feature_powershell
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
