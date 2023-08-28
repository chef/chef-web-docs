+++
title = "Chef/Correctness/NotifiesActionNotSymbol"
aliases = ["/workstation/cookstyle/chef_correctness_notifiesactionnotsymbol/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

When notifying or subscribing actions within a resource the action should always be a symbol. In Chef Infra Client releases before 14.0, this may result in double notification.

## Examples

### incorrect

```ruby
execute 'some command' do
  notifies 'restart', 'service[httpd]', 'delayed'
end

execute 'some command' do
  subscribes 'restart', 'service[httpd]', 'delayed'
end
```

### correct

```ruby
execute 'some command' do
  notifies :restart, 'service[httpd]', 'delayed'
end

execute 'some command' do
  subscribes :restart, 'service[httpd]', 'delayed'
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
<td style="text-align:center">5.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
