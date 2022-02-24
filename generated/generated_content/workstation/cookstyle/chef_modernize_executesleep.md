+++
title = "ExecuteSleep"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ExecuteSleep`

The full name of the cop is: `Chef/Modernize/ExecuteSleep`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 15.5+ |

Chef Infra Client 15.5 and later include a chef_sleep resource that should be used to sleep between executing resources if necessary instead of using the bash or execute resources to run the sleep command.

## Examples


#### incorrect

```ruby
execute "sleep 60" do
  command "sleep 60"
  action :run
end

bash 'sleep' do
  user 'root'
  cwd '/tmp'
  code 'sleep 60'
end
```

#### correct

```ruby
chef_sleep '60'
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
