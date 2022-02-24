+++
title = "UseInlineResourcesDefined"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UseInlineResourcesDefined`

The full name of the cop is: `Chef/Deprecations/UseInlineResourcesDefined`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

use_inline_resources became the default in Chef Infra Client 13+ and no longer needs
to be called in resources

## Examples


#### incorrect

```ruby
use_inline_resources
use_inline_resources if defined?(use_inline_resources)
use_inline_resources if respond_to?(:use_inline_resources)
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
<td style="text-align:center">5.4.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
