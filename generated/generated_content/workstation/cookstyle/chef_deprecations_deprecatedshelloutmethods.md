+++
title = "DeprecatedShelloutMethods"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DeprecatedShelloutMethods`

The full name of the cop is: `Chef/Deprecations/DeprecatedShelloutMethods`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 14.3+ |

## Examples


#### incorrect

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

#### correct

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
