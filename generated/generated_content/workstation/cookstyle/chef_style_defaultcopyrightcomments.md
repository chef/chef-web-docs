+++
title = "DefaultCopyrightComments"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DefaultCopyrightComments`

The full name of the cop is: `Chef/Style/DefaultCopyrightComments`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
Copyright:: 2019 YOUR_NAME
Copyright:: 2019 YOUR_COMPANY_NAME
```

#### correct

```ruby
Copyright:: 2019 Tim Smith
Copyright:: 2019 Chef Software, Inc.
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
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
