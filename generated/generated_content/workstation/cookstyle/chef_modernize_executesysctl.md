+++
title = "ExecuteSysctl"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ExecuteSysctl`

The full name of the cop is: `Chef/Modernize/ExecuteSysctl`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 14.0+ |

Chef Infra Client 14.0 and later includes a sysctl resource that should be used to idempotently load sysctl values instead of templating files and using execute to load them.

## Examples


#### incorrect

```ruby
file '/etc/sysctl.d/ipv4.conf' do
  notifies :run, 'execute[sysctl -p /etc/sysctl.d/ipv4.conf]', :immediately
  content '9000 65500'
end

execute 'sysctl -p /etc/sysctl.d/ipv4.conf' do
  action :nothing
end
```

#### correct

```ruby
sysctl 'net.ipv4.ip_local_port_range' do
  value '9000 65500'
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
<td style="text-align:center">5.18.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
