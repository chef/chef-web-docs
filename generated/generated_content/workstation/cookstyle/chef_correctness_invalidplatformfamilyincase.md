+++
title = "InvalidPlatformFamilyInCase"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `InvalidPlatformFamilyInCase`

The full name of the cop is: `Chef/Correctness/InvalidPlatformFamilyInCase`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use valid platform family values in case statements. See [Infra Language: Platform Family](https://docs.chef.io/infra_language/checking_platforms/#platform_family-values) for a complete list of platform families.

## Examples


#### incorrect

```ruby
case node['platform_family']
when 'redhat'
  puts "I'm on a RHEL-like system"
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
<td style="text-align:center">6.6.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
