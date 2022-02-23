+++
title = "DeprecatedSudoActions"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DeprecatedSudoActions`

The full name of the cop is: `Chef/Deprecations/DeprecatedSudoActions`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.0+ |

## Examples


#### incorrect

```ruby
sudo 'admins' do
  users 'bob'
  groups 'sysadmins, superusers'
  action :remove
end
```

#### correct

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
