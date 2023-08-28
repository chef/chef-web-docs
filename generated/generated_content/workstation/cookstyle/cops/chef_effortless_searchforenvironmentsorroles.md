+++
title = "Chef/Effortless/SearchForEnvironmentsOrRoles"
aliases = ["/workstation/cookstyle/chef_effortless_searchforenvironmentsorroles/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Effortless`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | All Versions |

Policyfiles (and Effortless) do not use environments or roles so searching for those will need to be refactored before migrating to Policyfiles and the Effortless pattern.

## Examples

### incorrect

```ruby
search(:node, 'chef_environment:foo')
search(:node, 'role:bar')
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
<td style="text-align:center">5.11.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
