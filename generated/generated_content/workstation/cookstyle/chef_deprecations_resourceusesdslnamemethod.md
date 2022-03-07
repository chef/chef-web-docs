+++
title = "ResourceUsesDslNameMethod"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ResourceUsesDslNameMethod`

The full name of the cop is: `Chef/Deprecations/ResourceUsesDslNameMethod`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

do not use the dsl_name method in a resource to find the name of the resource. Use the resource_name method instead. dsl_name was removed in Chef Infra Client 13 and will now result in an error.

## Examples


#### incorrect

```ruby
my_resource = MyResource.dsl_name
```

#### correct

```ruby
my_resource = MyResource.resource_name
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
<td style="text-align:center">5.7.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
