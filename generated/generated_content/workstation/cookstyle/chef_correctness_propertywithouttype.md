+++
title = "PropertyWithoutType"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `PropertyWithoutType`

The full name of the cop is: `Chef/Correctness/PropertyWithoutType`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Resource properties or attributes should always define a type to help users understand the correct allowed values.

## Examples


#### incorrect

```ruby
property :size, regex: /^\d+[KMGTP]$/
attribute :size, regex: /^\d+[KMGTP]$/
```

#### correct

```ruby
property :size, String, regex: /^\d+[KMGTP]$/
attribute :size, kind_of: String, regex: /^\d+[KMGTP]$/
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
<td style="text-align:center">6.18.0</td>
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
