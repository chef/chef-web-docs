+++
title = "StringPropertyWithNilDefault"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `StringPropertyWithNilDefault`

The full name of the cop is: `Chef/RedundantCode/StringPropertyWithNilDefault`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Properties have a nil value by default so there is no need to set the default value to nil.

## Examples


#### incorrect

```ruby
property :config_file, String, default: nil
property :config_file, [String, NilClass], default: nil
```

#### correct

```ruby
property :config_file, String
property :config_file, [String, NilClass]
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