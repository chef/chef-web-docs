+++
title = "DnfPackageAllowDowngrades"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DnfPackageAllowDowngrades`

The full name of the cop is: `Chef/Correctness/DnfPackageAllowDowngrades`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The `dnf_package` resource does not support the `allow_downgrades` property.

## Examples


#### incorrect

```ruby
dnf_package 'nginx' do
  version '1.2.3'
  allow_downgrades true
end
```

#### correct

```ruby
dnf_package 'nginx' do
  version '1.2.3'
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
<td style="text-align:center">5.16.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
