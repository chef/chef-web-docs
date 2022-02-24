+++
title = "OctalModeAsString"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `OctalModeAsString`

The full name of the cop is: `Chef/Correctness/OctalModeAsString`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Don't represent file modes as Strings containing octal values.

## Examples


#### incorrect

```ruby
file '/etc/some_file' do
  mode '0o755'
end
```

#### correct

```ruby
file '/etc/some_file' do
  mode '0755'
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
<td style="text-align:center">6.21.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
