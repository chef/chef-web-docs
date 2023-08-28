+++
title = "Chef/Deprecations/Ruby27KeywordArgumentWarnings"
aliases = ["/workstation/cookstyle/chef_deprecations_ruby27keywordargumentwarnings/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Pass options to shell_out helpers without the brackets to avoid Ruby 2.7 deprecation warnings.

## Examples

### incorrect

```ruby
shell_out!('hostnamectl status', { returns: [0, 1] })
shell_out('hostnamectl status', { returns: [0, 1] })
```

### correct

```ruby
shell_out!('hostnamectl status', returns: [0, 1])
shell_out('hostnamectl status', returns: [0, 1])
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
<td style="text-align:center">6.5.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
