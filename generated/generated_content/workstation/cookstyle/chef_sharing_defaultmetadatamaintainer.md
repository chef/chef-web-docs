+++
title = "DefaultMetadataMaintainer"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DefaultMetadataMaintainer`

The full name of the cop is: `Chef/Sharing/DefaultMetadataMaintainer`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Metadata contains default maintainer information from the `chef generate cookbook` command. This should be updated to reflect that actual maintainer of the cookbook.

## Examples


#### incorrect

```ruby
maintainer 'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
maintainer 'The Authors'
maintainer_email 'you@example.com'```

#### correct

```ruby
maintainer 'Bob Bobberson'
maintainer_email 'bob@bobberson.com'
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
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
