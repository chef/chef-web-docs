+++
title = "CookbookDependsOnPartialSearch"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `CookbookDependsOnPartialSearch`

The full name of the cop is: `Chef/Deprecations/CookbookDependsOnPartialSearch`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 13.0+ |

Don't depend on the `partial_search` cookbook made obsolete by Chef Infra Client 13.

## Examples


#### incorrect

```ruby
depends 'partial_search'
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
