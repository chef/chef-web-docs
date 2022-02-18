+++
title = "UseCreateIfMissing"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UseCreateIfMissing`

The full name of the cop is: `Chef/RedundantCode/UseCreateIfMissing`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby
cookbook_file '/logs/foo/error.log' do
  source 'error.log'
  owner 'root'
  group 'root'
  mode '0644'
  not_if { ::File.exists?('/logs/foo/error.log') }
end

remote_file 'Download file' do
  path '/foo/bar'
  source 'https://foo.com/bar'
  owner 'root'
  group 'root'
  mode '0644'
  not_if { ::File.exist?('/foo/bar') }
end
```

#### correct

```ruby
cookbook_file '/logs/foo/error.log' do
  source 'error.log'
  owner 'root'
  group 'root'
  mode '0644'
  action :create_if_missing
end

remote_file 'Download file' do
  path '/foo/bar'
  source 'https://foo.com/bar'
  owner 'root'
  group 'root'
  mode '0644'
  action :create_if_missing
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
<td style="text-align:center">6.2.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
