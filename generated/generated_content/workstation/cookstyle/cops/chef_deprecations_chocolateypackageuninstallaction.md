+++
title = "Chef/Deprecations/ChocolateyPackageUninstallAction"
aliases = ["/workstation/cookstyle/chef_deprecations_chocolateypackageuninstallaction/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use the `:remove` action in the `chocolatey_package` resource instead of `:uninstall` which was removed in Chef Infra Client 14+.

## Examples

### incorrect

```ruby
chocolatey_package 'nginx' do
  action :uninstall
end
```

### correct

```ruby
chocolatey_package 'nginx' do
  action :remove
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
