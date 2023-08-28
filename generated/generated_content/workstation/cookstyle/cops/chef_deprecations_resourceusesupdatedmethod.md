+++
title = "Chef/Deprecations/ResourceUsesUpdatedMethod"
aliases = ["/workstation/cookstyle/chef_deprecations_resourceusesupdatedmetho/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | All Versions |

Don't call the deprecated `updated=` method in a resource to set the resource to updated. This method was removed from Chef Infra Client 13 and this will now cause an error. Instead wrap code that updated the state of the node in a `converge_by` block. Documentation on using the `converge_by` block can be found at https://docs.chef.io/custom_resources/.

## Examples

### incorrect

```ruby
action :foo do
  updated = true
end
```

### correct

```ruby
action :foo do
  converge_by('resource did something') do
    # code that causes the resource to converge
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
