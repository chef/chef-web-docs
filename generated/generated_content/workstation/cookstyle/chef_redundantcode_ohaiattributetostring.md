+++
title = "OhaiAttributeToString"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `OhaiAttributeToString`

The full name of the cop is: `Chef/RedundantCode/OhaiAttributeToString`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Many Ohai node attributes are already strings and don't need to be cast to strings again

## Examples


#### incorrect

```ruby
node['platform'].to_s
node['platform_family'].to_s
node['platform_version'].to_s
node['fqdn'].to_s
node['hostname'].to_s
node['os'].to_s
node['name'].to_s
```

#### correct

```ruby
node['platform']
node['platform_family']
node['platform_version']
node['fqdn']
node['hostname']
node['os']
node['name']
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
<td style="text-align:center">6.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
