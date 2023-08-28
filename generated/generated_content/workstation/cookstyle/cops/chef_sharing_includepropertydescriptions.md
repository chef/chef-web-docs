+++
title = "Chef/Sharing/IncludePropertyDescriptions"
aliases = ["/workstation/cookstyle/chef_sharing_includepropertydescriptions/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Sharing`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | 13.9+ |

Resource properties should include description fields to allow automated documentation. Requires Chef Infra Client 13.9 or later.

## Examples

### incorrect

```ruby
property :foo, String
```

### correct

```ruby
property :foo, String, description: "Set the important thing to..."
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
<td style="text-align:center">6.1.0</td>
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
