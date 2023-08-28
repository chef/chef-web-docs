+++
title = "Chef/Deprecations/DeprecatedSudoActions"
aliases = ["/workstation/cookstyle/chef_deprecations_deprecatedsudoactions/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.0+ |

The `sudo` resource in the sudo cookbook 5.0 (2018) or Chef Infra Client 14 and later have replaced the existing `:install` and `:remove` actions with `:create` and `:delete` actions to better match other resources in Chef Infra.

## Examples

### incorrect

```ruby
sudo 'admins' do
  users 'bob'
  groups 'sysadmins, superusers'
  action :remove
end
```

### correct

```ruby
sudo 'admins' do
  users 'bob'
  groups 'sysadmins, superusers'
  action :delete
end
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
<td style="text-align:center">7.18.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
