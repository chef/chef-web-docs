+++
title = "Chef/Modernize/IncludingOhaiDefaultRecipe"
aliases = ["/workstation/cookstyle/chef_modernize_includingohaidefaultrecipe/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The Ohai default recipe previously allowed a user to ship custom Ohai plugins to a system by including them in a directory in the Ohai cookbook. This functionality was replaced with the ohai_plugin resource, which should be used instead as it doesn't require forking the ohai cookbook.

## Examples

### incorrect

```ruby
include_recipe 'ohai::default'
include_recipe 'ohai'
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
<td style="text-align:center">5.4.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
