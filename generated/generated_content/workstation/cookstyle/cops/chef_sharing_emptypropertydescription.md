+++
title = "Chef/Sharing/EmptyPropertyDescription"
aliases = ["/workstation/cookstyle/chef_sharing_emptypropertydescription/"]

[menu]
  [menu.workstation]
    title = "EmptyPropertyDescription"
    identifier = "chef_workstation/cookstyle/cops/Chef/Sharing/EmptyPropertyDescription"
    parent = "chef_workstation/cookstyle/cops/Chef/Sharing"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Sharing`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Resource properties should not set an empty `description`. Automated documentation tools have
nothing to render from it, so it does no more than a missing field would while looking like the
property has been documented.

## Examples

```ruby
# bad
property :site_name, String,
         name_property: true,
         description: ''

# good
property :site_name, String,
         name_property: true,
         description: 'The name of the site'
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
<td style="text-align:center">9.0.0</td>
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
