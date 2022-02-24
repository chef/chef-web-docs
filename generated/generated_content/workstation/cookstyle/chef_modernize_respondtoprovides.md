+++
title = "RespondToProvides"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `RespondToProvides`

The full name of the cop is: `Chef/Modernize/RespondToProvides`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

In Chef Infra Client 12+ is is no longer necessary to gate the use of the provides methods in resources with `if respond_to?(:provides)` or `if defined? provides`.

## Examples


#### incorrect

```ruby
provides :foo if respond_to?(:provides)

provides :foo if defined? provides
```

#### correct

```ruby
provides :foo
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
<td style="text-align:center">5.2.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/providers/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
