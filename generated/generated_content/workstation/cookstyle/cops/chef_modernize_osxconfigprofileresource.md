+++
title = "Chef/Modernize/OsxConfigProfileResource"
aliases = ["/workstation/cookstyle/chef_modernize_osxconfigprofileresource/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The osx_config_profile resource was renamed to osx_profile. The new resource name should be used.

## Examples

### incorrect

```ruby
osx_config_profile 'Install screensaver profile' do
  profile 'screensaver/com.company.screensaver.mobileconfig'
end
```

### correct

```ruby
osx_profile 'Install screensaver profile' do
  profile 'screensaver/com.company.screensaver.mobileconfig'
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
<td style="text-align:center">5.6.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
