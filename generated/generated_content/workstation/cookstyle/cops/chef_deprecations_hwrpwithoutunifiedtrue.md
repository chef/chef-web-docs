+++
title = "Chef/Deprecations/HWRPWithoutUnifiedTrue"
aliases = ["/workstation/cookstyle/chef_deprecations_hwrpwithoutunifiedtrue/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 15.3+ |

Chef Infra Client 15.3 and later include a new Unified Mode that simplifies the execution of resources by replace the traditional compile and converge phases with a single phase. Unified mode simplifies writing advanced resources and avoids confusing errors that often occur when mixing ruby and Chef Infra resources. Chef Infra Client 17.0 and later will begin warning that `unified_mode true` should be set in all resources to validate that they will continue to function in Chef Infra Client 18.0 (April 2022) when Unified Mode becomes the default.

## Examples

### incorrect

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

### correct

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
