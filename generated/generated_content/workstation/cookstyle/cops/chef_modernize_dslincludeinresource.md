+++
title = "Chef/Modernize/DslIncludeInResource"
aliases = ["/workstation/cookstyle/chef_modernize_dslincludeinresource/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Chef Infra Client 12.4+ includes the Chef::DSL::Recipe in the resource and provider classed by default so there is no need to include this DSL in your resources or providers.

## Examples

### incorrect

```ruby
include Chef::DSL::Recipe
include Chef::DSL::IncludeRecipe
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
<td style="text-align:center">5.17.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
