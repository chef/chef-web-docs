+++
title = "IncludePropertyDescriptions"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `IncludePropertyDescriptions`

The full name of the cop is: `Chef/Sharing/IncludePropertyDescriptions`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | 13.9+ |

Resource properties should include description fields to allow automated documentation. Requires Chef Infra Client 13.9 or later.

## Examples


#### incorrect

```ruby
property :foo, String
```

#### correct

```ruby
property :foo, String, description: "Set the important thing to..."
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
<li><code>**/libraries/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
