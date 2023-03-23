+++
title = "CookbookDependsOnCompatResource"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `CookbookDependsOnCompatResource`

The full name of the cop is: `Chef/Deprecations/CookbookDependsOnCompatResource`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.19+ |

Don't depend on the deprecated `compat_resource` cookbook made obsolete by Chef Infra Client 12.19+.

## Examples


#### incorrect

```ruby
depends 'compat_resource'
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
<td style="text-align:center">5.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
