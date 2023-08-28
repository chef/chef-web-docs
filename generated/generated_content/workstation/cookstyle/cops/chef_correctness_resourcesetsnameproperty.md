+++
title = "Chef/Correctness/ResourceSetsNameProperty"
aliases = ["/workstation/cookstyle/chef_correctness_resourcesetsnameproperty/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Use name properties instead of setting the name property in a resource. Setting the name property directly causes notification and reporting issues.

## Examples

### incorrect

```ruby
service 'foo' do
 name 'bar'
end
```

### correct

```ruby
service 'foo' do
 service_name 'bar'
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
<td style="text-align:center">5.5.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
