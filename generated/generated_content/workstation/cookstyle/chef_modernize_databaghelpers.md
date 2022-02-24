+++
title = "DatabagHelpers"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DatabagHelpers`

The full name of the cop is: `Chef/Modernize/DatabagHelpers`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use the `data_bag_item` helper instead of `Chef::DataBagItem.load` or `Chef::EncryptedDataBagItem.load`.

## Examples


#### incorrect

```ruby
plain_text_data = Chef::DataBagItem.load('foo', 'bar')
encrypted_data = Chef::EncryptedDataBagItem.load('foo2', 'bar2')
```

#### correct

```ruby
plain_text_data = data_bag_item('foo', 'bar')
encrypted_data = data_bag_item('foo2', 'bar2')
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
<td style="text-align:center">6.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
