+++
title = "ResourceUsesProviderBaseMethod"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ResourceUsesProviderBaseMethod`

The full name of the cop is: `Chef/Deprecations/ResourceUsesProviderBaseMethod`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The Resource.provider_base allows the developer to specify within a resource a module to load the resource's provider from. Instead, the provider should call provides to register itself, or the resource should call provider to specify the provider to use.

## Examples


#### incorrect

```ruby
provider_base ::Chef::Provider::SomethingSomething
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
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
