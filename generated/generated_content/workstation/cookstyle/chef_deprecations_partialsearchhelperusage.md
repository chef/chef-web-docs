+++
title = "PartialSearchHelperUsage"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `PartialSearchHelperUsage`

The full name of the cop is: `Chef/Deprecations/PartialSearchHelperUsage`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
partial_search(:node, 'role:web',
  keys: { 'name' => [ 'name' ],
          'ip' => [ 'ipaddress' ],
          'kernel_version' => %w(kernel version),
            }
).each do |result|
  puts result['name']
  puts result['ip']
  puts result['kernel_version']
end
```

#### correct

```ruby
search(:node, 'role:web',
  filter_result: { 'name' => [ 'name' ],
                   'ip' => [ 'ipaddress' ],
                   'kernel_version' => %w(kernel version),
            }
).each do |result|
  puts result['name']
  puts result['ip']
  puts result['kernel_version']
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
<td style="text-align:center">5.11.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
