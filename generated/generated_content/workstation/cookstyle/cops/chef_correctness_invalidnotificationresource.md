+++
title = "Chef/Correctness/InvalidNotificationResource"
aliases = ["/workstation/cookstyle/chef_correctness_invalidnotificationresource/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The resource to notify when calling `notifies` or `subscribes` must be a string.

## Examples

### incorrect

```ruby

template '/etc/www/configures-apache.conf' do
  notifies :restart, service['apache'], :immediately
end

template '/etc/www/configures-apache.conf' do
  notifies :restart, service[apache], :immediately
end
```

### correct

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
<td style="text-align:center">7.28</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
