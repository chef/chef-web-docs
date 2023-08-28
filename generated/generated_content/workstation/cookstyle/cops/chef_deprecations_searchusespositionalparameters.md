+++
title = "Chef/Deprecations/SearchUsesPositionalParameters"
aliases = ["/workstation/cookstyle/chef_deprecations_searchusespositionalparameters/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

correct

query(:node, '*:*')
 search(:node, '*:*', start: 0, rows: 1000, filter_result: { :ip_address => ["ipaddress"] })
 search(:node, '*:*', start: 0, rows: 1000)
 search(:node, '*:*', start: 0)

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
<td style="text-align:center">5.11.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
