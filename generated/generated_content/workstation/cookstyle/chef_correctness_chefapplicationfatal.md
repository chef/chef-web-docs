+++
title = "ChefApplicationFatal"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ChefApplicationFatal`

The full name of the cop is: `Chef/Correctness/ChefApplicationFatal`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use `raise` to force Chef Infra Client to fail instead of using `Chef::Application.fatal`, which masks the full stack trace of the failure and makes debugging difficult.

## Examples


#### incorrect

```ruby
Chef::Application.fatal!('Something horrible happened!')
```

#### correct

```ruby
raise "Something horrible happened!"
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
<td style="text-align:center">6.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
