+++
title = "HWRPWithoutUnifiedTrue"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `HWRPWithoutUnifiedTrue`

The full name of the cop is: `Chef/Deprecations/HWRPWithoutUnifiedTrue`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 15.3+ |

## Examples


#### incorrect

```ruby
 class Chef
   class Resource
     class UlimitRule < Chef::Resource
       provides :ulimit_rule

       property :type, [Symbol, String], required: true
       property :item, [Symbol, String], required: true

       # additional resource code
     end
   end
 end
```

#### correct

```ruby
 class Chef
   class Resource
     class UlimitRule < Chef::Resource
       provides :ulimit_rule
       unified_mode true

       property :type, [Symbol, String], required: true
       property :item, [Symbol, String], required: true

       # additional resource code
     end
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
<td style="text-align:center">7.12.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
