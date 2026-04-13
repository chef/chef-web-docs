+++
title = "Chef/RedundantCode/SensitivePropertyInResource"
aliases = ["/workstation/cookstyle/chef_redundantcode_sensitivepropertyinresource/"]

[menu]
  [menu.workstation]
    title = "SensitivePropertyInResource"
    identifier = "chef_workstation/cookstyle/cops/Chef/RedundantCode/SensitivePropertyInResource"
    parent = "chef_workstation/cookstyle/cops/Chef/RedundantCode"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/RedundantCode`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Every Chef Infra resource already includes a sensitive property with a default value of false.

## Examples

```ruby
# bad
property :sensitive, [true, false], default: false
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
<td style="text-align:center">5.16.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
