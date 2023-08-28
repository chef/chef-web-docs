+++
title = "Chef/Modernize/RespondToCompileTime"
aliases = ["/workstation/cookstyle/chef_modernize_respondtocompiletime/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.1+ |

There is no need to check if the chef_gem resource supports compile_time as Chef Infra Client 12.1 and later support the compile_time property.

## Examples

### incorrect

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

### correct

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
