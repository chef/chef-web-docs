+++
title = "DependsOnWindowsFirewallCookbook"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DependsOnWindowsFirewallCookbook`

The full name of the cop is: `Chef/Modernize/DependsOnWindowsFirewallCookbook`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.7+ |

do not depend on the windows_firewall cookbook made obsolete by Chef Infra Client 14.7. The windows_firewall resource is now included in Chef Infra Client itself.

## Examples


#### incorrect

```ruby
depends 'windows_firewall'
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
