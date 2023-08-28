+++
title = "Chef/Correctness/InvalidPlatformValueForPlatformFamilyHelper"
aliases = ["/workstation/cookstyle/chef_correctness_invalidplatformvalueforplatformfamilyhelper/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Pass valid platform families to the value_for_platform_family helper. See [Infra Language: Platform Family](https://docs.chef.io/infra_language/checking_platforms/#platform_family-values) for a complete list of platform families.

## Examples

### incorrect

```ruby
value_for_platform_family(
  %w(rhel sles) => 'foo',
  %w(mac) => 'foo'
)
```

### correct

```ruby
value_for_platform_family(
  %w(rhel suse) => 'foo',
  %w(mac_os_x) => 'foo'
)
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
<td style="text-align:center">5.15.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
