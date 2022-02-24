+++
title = "ChefHandlerUsesSupports"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ChefHandlerUsesSupports`

The full name of the cop is: `Chef/Deprecations/ChefHandlerUsesSupports`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use the type `property` instead of the deprecated `supports` property in the `chef_handler` resource. The `supports` property was removed in `chef_handler` cookbook version 3.0 (June 2017) and Chef Infra Client 14.0.

## Examples


#### incorrect

```ruby
chef_handler 'whatever' do
  supports start: true, report: true, exception: true
end0
```

#### correct

```ruby
chef_handler 'whatever' do
  type start: true, report: true, exception: true
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
<td style="text-align:center">5.9.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
