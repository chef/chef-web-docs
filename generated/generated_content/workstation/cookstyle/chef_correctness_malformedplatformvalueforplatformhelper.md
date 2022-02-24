+++
title = "MalformedPlatformValueForPlatformHelper"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `MalformedPlatformValueForPlatformHelper`

The full name of the cop is: `Chef/Correctness/MalformedPlatformValueForPlatformHelper`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

When using the value_for_platform helper you must include a hash of possible platforms where each platform contains a hash of versions and potential values. If you don't wish to match on a particular version you can instead use the key 'default'.

## Examples


#### incorrect

```ruby
value_for_platform(
  %w(redhat oracle) => 'baz'
)
```

#### correct

```ruby
value_for_platform(
  %w(redhat oracle) => {
    '5' => 'foo',
    '6' => 'bar',
    'default'd => 'baz',
  }
)

value_for_platform(
  %w(redhat oracle) => {
    'default' => 'foo',
  },
  'default' => 'bar'
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
<td style="text-align:center">5.16.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
