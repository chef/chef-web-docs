+++
title = "DependsOnOpensslCookbook"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DependsOnOpensslCookbook`

The full name of the cop is: `Chef/Modernize/DependsOnOpensslCookbook`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.4+ |

Don't depend on the `openssl` cookbook which was made obsolete by Chef Infra Client 14.4. All `openssl_*` resources are now included directly in Chef Infra Client.

## Examples


#### incorrect

```ruby
depends 'openssl'
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
