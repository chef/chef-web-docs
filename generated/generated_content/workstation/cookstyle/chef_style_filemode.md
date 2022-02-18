+++
title = "FileMode"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `FileMode`

The full name of the cop is: `Chef/Style/FileMode`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby
remote_directory '/etc/my.conf' do
  content 'some content'
  mode 0600
  action :create
end

remote_directory 'handler' do
  source 'handlers'
  recursive true
  files_mode 644
  action :create
end
```

#### correct

```ruby
remote_directory '/etc/my.conf' do
  content 'some content'
  mode '600'
  action :create
end

remote_directory 'handler' do
  source 'handlers'
  recursive true
  files_mode '644'
  action :create
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
<td style="text-align:center">5.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
