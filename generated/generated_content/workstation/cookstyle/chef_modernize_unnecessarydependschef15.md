+++
title = "UnnecessaryDependsChef15"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UnnecessaryDependsChef15`

The full name of the cop is: `Chef/Modernize/UnnecessaryDependsChef15`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 15.0+ |

do not depend on cookbooks made obsolete by Chef Infra Client 15.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.

## Examples


#### incorrect

```ruby
depends 'libarchive'
depends 'windows_dns'
depends 'windows_uac'
depends 'windows_dfs'
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
<td style="text-align:center">7.19.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
