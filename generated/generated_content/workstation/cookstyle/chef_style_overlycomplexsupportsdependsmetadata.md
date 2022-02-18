+++
title = "OverlyComplexSupportsDependsMetadata"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `OverlyComplexSupportsDependsMetadata`

The full name of the cop is: `Chef/Style/OverlyComplexSupportsDependsMetadata`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby

%w( debian ubuntu ).each do |os|
  supports os
end

%w( apt yum ).each do |cb|
  depends cb
end
```

#### correct

```ruby

supports 'debian'
supports 'ubuntu'

depends 'apt'
depends 'yum'
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
<td style="text-align:center">5.19.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
