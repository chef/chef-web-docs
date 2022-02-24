+++
title = "ReplacesMetadata"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ReplacesMetadata`

The full name of the cop is: `Chef/RedundantCode/ReplacesMetadata`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The replaces metadata.rb method is not used and is unnecessary in cookbooks. Replacements for existing cookbooks should be documented in the cookbook's README.md file instead.

## Examples


#### incorrect

```ruby in metadata.rb:

replaces "another_cookbook"
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
<td style="text-align:center">5.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
