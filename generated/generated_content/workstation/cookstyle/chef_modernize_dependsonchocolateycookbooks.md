+++
title = "DependsOnChocolateyCookbooks"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DependsOnChocolateyCookbooks`

The full name of the cop is: `Chef/Modernize/DependsOnChocolateyCookbooks`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.3+ |

Don't depend on the chocolatey_source or chocolatey_config cookbooks made obsolete by Chef Infra Client 14.3. The chocolatey_source and chocolatey_config resources are now included in Chef Infra Client itself.

## Examples


#### incorrect

```ruby
depends 'chocolatey_source'
depends 'chocolatey_config'
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
<td style="text-align:center">7.20.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
