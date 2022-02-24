+++
title = "IfProvidesDefaultAction"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `IfProvidesDefaultAction`

The full name of the cop is: `Chef/Modernize/IfProvidesDefaultAction`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

if defined?(default_action) is no longer necessary in Chef Resources as default_action shipped in Chef 10.8.

## Examples


#### incorrect

```ruby
default_action :foo if defined?(default_action)
```

#### correct

```ruby
default_action :foo
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
<td style="text-align:center">5.12.0</td>
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
