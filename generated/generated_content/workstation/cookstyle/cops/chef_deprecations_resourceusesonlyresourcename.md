+++
title = "Chef/Deprecations/ResourceUsesOnlyResourceName"
aliases = ["/workstation/cookstyle/chef_deprecations_resourceusesonlyresourcename/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Starting with Chef Infra Client 16, using `resource_name` without also using `provides` will result in resource failures. Make sure to use both `resource_name` and `provides` to change the name of the resource. You can also omit `resource_name` entirely if the value set matches the name Chef Infra Client automatically assigns based on COOKBOOKNAME_FILENAME.

## Examples

### incorrect

```ruby
mycookbook/resources/myresource.rb:
resource_name :mycookbook_myresource
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
<td style="text-align:center">6.7.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
