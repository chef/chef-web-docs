+++
title = "UseAutomaticResourceName"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UseAutomaticResourceName`

The full name of the cop is: `Chef/Deprecations/UseAutomaticResourceName`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The use_automatic_resource_name method was removed in Chef Infra Client 16. The resource name/provides should be set explicitly instead.

## Examples


#### incorrect

```ruby
module MyCookbook
  class MyCookbookService < Chef::Resource
    use_automatic_resource_name
    provides :mycookbook_service

    # some additional code
  end
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
<td style="text-align:center">6.12.0</td>
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
