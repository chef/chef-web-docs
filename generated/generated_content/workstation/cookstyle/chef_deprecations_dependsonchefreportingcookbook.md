+++
title = "DependsOnChefReportingCookbook"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DependsOnChefReportingCookbook`

The full name of the cop is: `Chef/Deprecations/DependsOnChefReportingCookbook`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

do not depend on the chef-reporting cookbook made obsolete by Chef Infra Client 11.6. This cookbook installs a gem that is not compatible with newer Chef Infra Client releases.

## Examples


#### incorrect

```ruby
depends 'chef-reporting'
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
