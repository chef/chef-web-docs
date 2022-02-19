+++
title = "NodeMethodsInsteadofAttributes"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `NodeMethodsInsteadofAttributes`

The full name of the cop is: `Chef/Deprecations/NodeMethodsInsteadofAttributes`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby
node.fqdn
node.platform
node.platform_family
node.platform_version
node.hostname
```

#### correct

```ruby
node['fqdn']
node['platform']
node['platform_family']
node['platform_version']
node['hostname']
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
<td style="text-align:center">5.4.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
