+++
title = "UnnecessaryDependsChef14"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UnnecessaryDependsChef14`

The full name of the cop is: `Chef/Modernize/UnnecessaryDependsChef14`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.0+ |

## Examples


#### incorrect

```ruby
depends 'build-essential'
depends 'chef_handler'
depends 'chef_hostname'
depends 'dmg'
depends 'mac_os_x'
depends 'swap'
depends 'sysctl'
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
<td style="text-align:center">5.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
