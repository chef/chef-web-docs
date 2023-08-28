+++
title = "Chef/RedundantCode/RecipeMetadata"
aliases = ["/workstation/cookstyle/chef_redundantcode_recipemetadata/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/RedundantCode`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented in the cookbook's README.md file instead.

## Examples

### incorrect

```ruby
recipe 'openldap::default', 'Install and configure OpenLDAP'
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
<td style="text-align:center">5.6.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
