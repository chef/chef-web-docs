+++
title = "Chef/Deprecations/WindowsVersionHelpers"
aliases = ["/workstation/cookstyle/chef_deprecations_windowsversionhelpers/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.0+ |

Use node['platform_version'] and node['kernel'] data instead of the deprecated Windows::VersionHelper helpers from the Windows cookbook.

## Examples

### incorrect

```ruby
Windows::VersionHelper.nt_version
Windows::VersionHelper.server_version?
Windows::VersionHelper.core_version?
Windows::VersionHelper.workstation_version?
```

### correct

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
