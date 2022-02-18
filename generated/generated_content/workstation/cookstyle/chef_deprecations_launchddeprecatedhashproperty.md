+++
title = "LaunchdDeprecatedHashProperty"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `LaunchdDeprecatedHashProperty`

The full name of the cop is: `Chef/Deprecations/LaunchdDeprecatedHashProperty`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.19+ |

## Examples


#### incorrect

```ruby
launchd 'foo' do
  hash foo: 'bar'
end
```

#### correct

```ruby
launchd 'foo' do
  plist_hash foo: 'bar'
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
<td style="text-align:center">5.5.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
