+++
title = "BlockGuardWithOnlyString"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `BlockGuardWithOnlyString`

The full name of the cop is: `Chef/Correctness/BlockGuardWithOnlyString`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby
template '/etc/foo' do
  mode '0644'
  source 'foo.erb'
  only_if { 'test -f /etc/foo' }
end
```

#### correct

```ruby
template '/etc/foo' do
  mode '0644'
  source 'foo.erb'
  only_if 'test -f /etc/foo'
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
<td style="text-align:center">5.2.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
