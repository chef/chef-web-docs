+++
title = "ResourceInheritsFromCompatResource"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ResourceInheritsFromCompatResource`

The full name of the cop is: `Chef/Deprecations/ResourceInheritsFromCompatResource`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Resources written in the class based HWRP style should inherit from the 'Chef::Resource' class and not the 'ChefCompat::Resource' class from the deprecated compat_resource cookbook.

## Examples


#### incorrect

```ruby
class AptUpdate < ChefCompat::Resource
  # some resource code
end
```

#### correct

```ruby
class AptUpdate < Chef::Resource
  # some resource code
end

# better
Write a custom resource using the custom resource DSL and avoid class based HWRPs entirely
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
<td style="text-align:center">5.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
