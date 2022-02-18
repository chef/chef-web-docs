+++
title = "DefaultActionFromInitialize"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DefaultActionFromInitialize`

The full name of the cop is: `Chef/Modernize/DefaultActionFromInitialize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby
def initialize(*args)
  super
  @action = :create
end

#### incorrect

```ruby
def initialize(*args)
  super
  @default_action = :create
end
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
<td style="text-align:center">5.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
