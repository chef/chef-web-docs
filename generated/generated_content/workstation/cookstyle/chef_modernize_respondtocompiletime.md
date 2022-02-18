+++
title = "RespondToCompileTime"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `RespondToCompileTime`

The full name of the cop is: `Chef/Modernize/RespondToCompileTime`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.1+ |

## Examples


#### incorrect

```ruby
chef_gem 'ultradns-sdk' do
  compile_time true if Chef::Resource::ChefGem.method_defined?(:compile_time)
  action :nothing
end

chef_gem 'ultradns-sdk' do
  compile_time true if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  action :nothing
end

chef_gem 'ultradns-sdk' do
  compile_time true if respond_to?(:compile_time)
  action :nothing
end
```

#### correct

```ruby
chef_gem 'ultradns-sdk' do
  compile_time true
  action :nothing
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
<td style="text-align:center">6.3.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
