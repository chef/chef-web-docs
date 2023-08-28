+++
title = "InSpec/Deprecations/AttributeDefault"
aliases = ["/workstation/cookstyle/inspec_deprecations_attributedefault/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `InSpec/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The Chef InSpec inputs `default` option has been replaced with the `value` option.

## Examples

### incorrect

```ruby
login_defs_umask = input('login_defs_umask', default: '077', description: 'Default umask to set in login.defs')
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
