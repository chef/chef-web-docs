+++
title = "UseRequireRelative"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UseRequireRelative`

The full name of the cop is: `Chef/Modernize/UseRequireRelative`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Instead of using require with a File.expand_path and __FILE__ use the simpler require_relative method.

## Examples


#### incorrect

```ruby
require File.expand_path('../../libraries/helpers', __FILE__)
```

#### correct

```ruby
require_relative '../libraries/helpers'
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
<td style="text-align:center">5.22.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
