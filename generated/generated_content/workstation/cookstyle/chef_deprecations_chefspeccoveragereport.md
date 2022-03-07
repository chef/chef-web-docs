+++
title = "ChefSpecCoverageReport"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ChefSpecCoverageReport`

The full name of the cop is: `Chef/Deprecations/ChefSpecCoverageReport`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

do not use the deprecated ChefSpec Coverage report functionality in your specs. This feature has been removed as coverage reports encourage cookbook authors to write ineffective specs. Focus on testing your logic instead of achieving 100% code coverage.

## Examples


#### incorrect

```ruby

at_exit { ChefSpec::Coverage.report! }
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
<td style="text-align:center">5.8.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/spec/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
