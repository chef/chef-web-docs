+++
title = "MacosUserdefaultsInvalidType"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `MacosUserdefaultsInvalidType`

The full name of the cop is: `Chef/Correctness/MacosUserdefaultsInvalidType`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The macos_userdefaults resource prior to Chef Infra Client 16.3 would silently continue if invalid types were passed resulting in unexpected behavior. Valid values are: "array", "bool", "dict", "float", "int", and "string".

## Examples


#### incorrect

```ruby
macos_userdefaults 'set a value' do
  global true
  key 'key'
  type 'boolean'
end
```

#### correct

```ruby
macos_userdefaults 'set a value' do
  global true
  key 'key'
  type 'bool'
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
<td style="text-align:center">6.14.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
