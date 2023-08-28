+++
title = "Chef/Modernize/ShellOutHelper"
aliases = ["/workstation/cookstyle/chef_modernize_shellouthelper/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.11+ |

Use the built-in `shell_out` helper available in Chef Infra Client 12.11+ instead of calling `Mixlib::ShellOut.new('foo').run_command`.

## Examples

### incorrect

```ruby
Mixlib::ShellOut.new('foo').run_command
```

### correct

```ruby
shell_out('foo')
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
