+++
title = "IncludeResourceDescriptions"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `IncludeResourceDescriptions`

The full name of the cop is: `Chef/Sharing/IncludeResourceDescriptions`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | 13.9+ |

Resources should include description fields to allow automated documentation. Requires Chef Infra Client 13.9 or later.

## Examples

```

#### correct

```ruby
resource_name :foo
description "The foo resource is used to do..."
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
<td style="text-align:center">6.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
