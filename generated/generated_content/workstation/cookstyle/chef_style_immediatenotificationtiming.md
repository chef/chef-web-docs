+++
title = "ImmediateNotificationTiming"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ImmediateNotificationTiming`

The full name of the cop is: `Chef/Style/ImmediateNotificationTiming`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby

template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]', :immediate
end
```

#### correct

```ruby

template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]', :immediately
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
