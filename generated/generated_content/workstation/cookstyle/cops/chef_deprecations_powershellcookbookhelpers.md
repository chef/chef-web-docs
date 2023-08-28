+++
title = "Chef/Deprecations/PowershellCookbookHelpers"
aliases = ["/workstation/cookstyle/chef_deprecations_powershellcookbookhelpers/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use `node['powershell']['version']` or the new `powershell_version` helper available in Chef Infra Client 15.8+ instead of the deprecated PowerShell cookbook helpers

## Examples

### incorrect

```ruby
Powershell::VersionHelper.powershell_version?('4.0')
```

### correct

```ruby
node['powershell']['version'].to_f == 4.0

# better (Chef Infra Client 15.8+)
powershell_version == 4.0
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
<td style="text-align:center">6.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
