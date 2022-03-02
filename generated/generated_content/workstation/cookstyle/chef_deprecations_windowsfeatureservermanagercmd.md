+++
title = "WindowsFeatureServermanagercmd"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `WindowsFeatureServermanagercmd`

The full name of the cop is: `Chef/Deprecations/WindowsFeatureServermanagercmd`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The `windows_feature` resource no longer supports setting the `install_method` to `:servermanagercmd`. `:windows_feature_dism` or `:windows_feature_powershell` should be used instead.

## Examples


#### incorrect

```ruby
windows_feature 'DHCP' do
  install_method :servermanagercmd
end
```

#### correct

```ruby
windows_feature 'DHCP' do
  install_method :windows_feature_dism
end

windows_feature 'DHCP' do
  install_method :windows_feature_powershell
end

windows_feature_dism 'DHCP'

windows_feature_powershell 'DHCP'
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
<td style="text-align:center">5.22.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
