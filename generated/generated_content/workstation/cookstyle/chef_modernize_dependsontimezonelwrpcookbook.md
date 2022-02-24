+++
title = "DependsOnTimezoneLwrpCookbook"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DependsOnTimezoneLwrpCookbook`

The full name of the cop is: `Chef/Modernize/DependsOnTimezoneLwrpCookbook`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.6+ |

Don't depend on the timezone_lwrp cookbook made obsolete by Chef Infra Client 14.6. The timezone resource is now included in Chef Infra Client itself.

## Examples


#### incorrect

```ruby
depends 'timezone_lwrp'
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
