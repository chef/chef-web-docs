+++
title = "DependsOnChefVaultCookbook"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DependsOnChefVaultCookbook`

The full name of the cop is: `Chef/Modernize/DependsOnChefVaultCookbook`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 16.0+ |

Don't depend on the chef-vault cookbook made obsolete by Chef Infra Client 16.0. The chef-vault gem and helpers are now included in Chef Infra Client itself.

## Examples


#### incorrect

```ruby
depends 'chef-vault'
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
<td style="text-align:center">7.20.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
