+++
title = "MultiplePlatformChecks"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `MultiplePlatformChecks`

The full name of the cop is: `Chef/RedundantCode/MultiplePlatformChecks`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

You can pass multiple values to the platform? and platform_family? helpers instead of calling the helpers multiple times.

## Examples


#### incorrect

```ruby
platform?('redhat') || platform?('ubuntu')
platform_family?('debian') || platform_family?('rhel')
```

#### correct

```ruby
platform?('redhat', 'ubuntu')
platform_family?('debian', 'rhel')
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
<td style="text-align:center">6.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
