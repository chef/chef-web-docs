+++
title = "ResourceWithoutUnifiedTrue"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ResourceWithoutUnifiedTrue`

The full name of the cop is: `Chef/Deprecations/ResourceWithoutUnifiedTrue`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 15.3+ |

Chef Infra Client 15.3 and later include a new Unified Mode that simplifies the execution of resources by replace the traditional compile and converge phases with a single phase. Unified mode simplifies writing advanced resources and avoids confusing errors that often occur when mixing ruby and Chef Infra resources. Chef Infra Client 17.0 and later will begin warning that `unified_mode true` should be set in all resources to validate that they will continue to function in Chef Infra Client 18.0 (April 2022) when Unified Mode becomes the default.

## Examples


#### incorrect

```ruby
 resource_name :foo
 provides :foo

 action :create do
   # some action code
 end
```

#### correct

```ruby
 resource_name :foo
 provides :foo
 unified_mode true

 action :create do
   # some action code
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
<td style="text-align:center">7.12.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
