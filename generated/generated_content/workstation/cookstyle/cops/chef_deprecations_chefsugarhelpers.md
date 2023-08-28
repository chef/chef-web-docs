+++
title = "Chef/Deprecations/ChefSugarHelpers"
aliases = ["/workstation/cookstyle/chef_deprecations_chefsugarhelpers/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started

## Examples

### incorrect

```ruby
vagrant_key?
vagrant_domain?
vagrant_user?
require_chef_gem
best_ip_for(node)
nexus?
ios_xr?
ruby_20?
ruby_19?
includes_recipe?('foo::bar')
wrlinux?
dev_null
nexentacore_platform?
opensolaris_platform?
nexentacore?
opensolaris?
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
<td style="text-align:center">7.3.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
