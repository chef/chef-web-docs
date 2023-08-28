+++
title = "InSpec/Deprecations/AttributeHelper"
aliases = ["/workstation/cookstyle/inspec_deprecations_attributehelper/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `InSpec/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Chef InSpec attributes have been renamed to inputs. Use the `input` method not the deprecation `attribute` method to access these values.

## Examples

### incorrect

```ruby
login_defs_umask = attribute('login_defs_umask', value: '077', description: 'Default umask to set in login.defs')
```

### correct

```ruby
login_defs_umask = input('login_defs_umask', value: '077', description: 'Default umask to set in login.defs')
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
<td style="text-align:center">7.14.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/controls/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
