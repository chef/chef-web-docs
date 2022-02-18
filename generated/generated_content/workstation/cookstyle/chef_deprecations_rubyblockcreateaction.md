+++
title = "RubyBlockCreateAction"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `RubyBlockCreateAction`

The full name of the cop is: `Chef/Deprecations/RubyBlockCreateAction`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby
ruby_block 'my special ruby block' do
  block do
    puts 'running'
  end
  action :create
end
```

#### correct

```ruby
ruby_block 'my special ruby block' do
  block do
    puts 'running'
  end
  action :run
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
<td style="text-align:center">5.16.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
