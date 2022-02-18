+++
title = "WindowsVersionHelpers"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `WindowsVersionHelpers`

The full name of the cop is: `Chef/Deprecations/WindowsVersionHelpers`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.0+ |

## Examples


#### incorrect

```ruby
Windows::VersionHelper.nt_version
Windows::VersionHelper.server_version?
Windows::VersionHelper.core_version?
Windows::VersionHelper.workstation_version?
```

#### correct

```ruby
node['platform_version'].to_f
node['kernel']['product_type'] == 'Server'
node['kernel']['server_core']
node['kernel']['product_type'] == 'Workstation'
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
<td style="text-align:center">5.4.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
