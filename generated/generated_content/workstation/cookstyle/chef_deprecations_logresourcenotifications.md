+++
title = "LogResourceNotifications"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `LogResourceNotifications`

The full name of the cop is: `Chef/Deprecations/LogResourceNotifications`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 15.8+ |

In Chef Infra Client 16 the log resource no longer notifies when logging so notifications should not be triggered from log resources. Use the notify_group resource introduced in Chef Infra Client 15.8 instead to aggregate notifications.

## Examples


#### incorrect

```ruby
template '/etc/foo' do
  source 'bar.erb'
  notifies :write, 'log[Aggregate notifications using a single log resource]', :immediately
end

log 'Aggregate notifications using a single log resource' do
  notifies :restart, 'service[foo]', :delayed
end
```

#### correct

```ruby
template '/etc/foo' do
  source 'bar.erb'
  notifies :run, 'notify_group[Aggregate notifications using a single notify_group resource]', :immediately
end

notify_group 'Aggregate notifications using a single notify_group resource' do
  notifies :restart, 'service[foo]', :delayed
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
<td style="text-align:center">6.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
