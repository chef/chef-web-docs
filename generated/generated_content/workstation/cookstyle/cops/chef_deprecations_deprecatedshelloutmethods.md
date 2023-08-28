+++
title = "Chef/Deprecations/DeprecatedShelloutMethods"
aliases = ["/workstation/cookstyle/chef_deprecations_deprecatedshelloutmethods/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 14.3+ |

The large number of `shell_out` helper methods in Chef Infra Client has been reduced to just `shell_out` and `shell_out!` methods. The legacy methods were removed in Chef Infra Client and cookbooks using these legacy helpers will need to be updated.

## Examples

### incorrect

```ruby
shell_out_compact('foo')
shell_out_compact!('foo')
shell_out_with_timeout('foo')
shell_out_with_timeout!('foo')
shell_out_with_systems_locale('foo')
shell_out_with_systems_locale!('foo')
shell_out_compact_timeout('foo')
shell_out_compact_timeout!('foo')
```

### correct

```ruby
shell_out('foo')
shell_out!('foo')
shell_out!('foo', default_env: false) # replaces shell_out_with_systems_locale
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
<td style="text-align:center">6.3.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
