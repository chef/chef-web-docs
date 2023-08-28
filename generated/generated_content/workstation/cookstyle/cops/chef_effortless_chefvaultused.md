+++
title = "Chef/Effortless/ChefVaultUsed"
aliases = ["/workstation/cookstyle/chef_effortless_chefvaultuse/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Effortless`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | All Versions |

Chef Vault is not supported in the Effortless pattern, so usage of Chef Vault must be shifted to another secrets management solution before leveraging the Effortless pattern.

## Examples

### incorrect

```ruby
require 'chef-vault'

### incorrect

```ruby
ChefVault::Item

### incorrect

```ruby
include_recipe 'chef-vault'

### incorrect

```ruby
chef_gem 'chef-vault'

### incorrect

```ruby
chef_vault_item_for_environment(arg, arg1)

### incorrect

```ruby
chef_vault_item(arg, arg1)
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
<td style="text-align:center">6.19</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
