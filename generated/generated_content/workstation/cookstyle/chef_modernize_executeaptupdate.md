+++
title = "ExecuteAptUpdate"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ExecuteAptUpdate`

The full name of the cop is: `Chef/Modernize/ExecuteAptUpdate`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Instead of using the execute resource to run the `apt-get update` use Chef Infra Client's built-n apt_update resource which is available in Chef Infra Client 12.7 and later.

## Examples


#### incorrect

```ruby
execute 'apt-get update'

execute 'Apt all the apt cache' do
  command 'apt-get update'
end

execute 'some execute resource' do
  notifies :run, 'execute[apt-get update]', :immediately
end
```

#### correct

```ruby
apt_update

apt_update 'update apt cache'

execute 'some execute resource' do
  notifies :update, 'apt_update[update apt cache]', :immediately
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
<td style="text-align:center">5.3.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
