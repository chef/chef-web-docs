+++
title = "PropertySplatRegex"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `PropertySplatRegex`

The full name of the cop is: `Chef/RedundantCode/PropertySplatRegex`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

When a property has a type of String it can accept any string. There is no need to also validate string inputs against a regex that accept all values.

## Examples


#### incorrect

```ruby
property :config_file, String, regex: /.*/
attribute :config_file, String, regex: /.*/
```

#### correct

```ruby
property :config_file, String
attribute :config_file, String
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
<td style="text-align:center">5.21.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
