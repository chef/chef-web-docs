+++
title = "Chef/Style/ChefWhaaat"
aliases = ["/workstation/cookstyle/chef_style_chefwhaaat/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Style`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | All Versions |

Checks for comments that mention "Chef" without context. Do you mean Chef Infra or Chef Software?

## Examples

### incorrect

```ruby
Chef makes software
Chef configures your systems
```

### correct

```ruby
Chef Software makes software
Chef Infra configures your systems
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
<td style="text-align:center">5.20.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
