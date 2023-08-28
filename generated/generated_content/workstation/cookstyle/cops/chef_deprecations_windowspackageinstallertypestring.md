+++
title = "Chef/Deprecations/WindowsPackageInstallerTypeString"
aliases = ["/workstation/cookstyle/chef_deprecations_windowspackageinstallertypestring/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

In Chef Infra Client 13 and later the `windows_package` resource's `installer_type` property must be a symbol.

## Examples

### incorrect

```ruby
windows_package 'AppveyorDeploymentAgent' do
  source 'https://www.example.com/appveyor.msi'
  installer_type 'msi'
  options "/quiet /qn /norestart /log install.log"
end
```

### correct

```ruby
windows_package 'AppveyorDeploymentAgent' do
  source 'https://www.example.com/appveyor.msi'
  installer_type :msi
  options "/quiet /qn /norestart /log install.log"
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
<td style="text-align:center">6.17.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
