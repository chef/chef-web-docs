+++
title = "InvalidPlatformValueForPlatformHelper"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `InvalidPlatformValueForPlatformHelper`

The full name of the cop is: `Chef/Correctness/InvalidPlatformValueForPlatformHelper`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
value_for_platform(
  %w(rhel mac_os_x_server) => { 'default' => 'foo' },
  %w(sles) => { 'default' => 'bar' }
)```

#### correct

```ruby
value_for_platform(
  %w(redhat mac_os_x) => { 'default' => 'foo' },
  %w(opensuseleap) => { 'default' => 'bar' }
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
