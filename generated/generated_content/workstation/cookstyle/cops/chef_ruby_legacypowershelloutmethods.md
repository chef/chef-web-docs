+++
title = "Chef/Ruby/LegacyPowershellOutMethods"
aliases = ["/workstation/cookstyle/chef_ruby_legacypowershelloutmethods/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Ruby`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | All Versions |

Use powershell_exec!/powershell_exec instead of powershell_out!/powershell_out. The new
methods don't spawn 2 shells per shellout and instead use .NET bindings to call PS directly.

## Examples
<nil>

## Configurable attributes

<table>
<tbody><tr>
<th>Name</th>
<th>Default value</th>
<th>Configurable values</th>
</tr>
<tr>
<td style="text-align:center">Version Added</td>
<td style="text-align:center"><nil></td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
