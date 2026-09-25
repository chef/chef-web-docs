+++
title = "Chef/Correctness/RubyGuardWithoutBlock"
aliases = ["/workstation/cookstyle/chef_correctness_rubyguardwithoutblock/"]

[menu]
  [menu.workstation]
    title = "RubyGuardWithoutBlock"
    identifier = "chef_workstation/cookstyle/cops/Chef/Correctness/RubyGuardWithoutBlock"
    parent = "chef_workstation/cookstyle/cops/Chef/Correctness"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

A `not_if`/`only_if` guard takes either a string, which is run as a shell command, or a block,
which is run as Ruby. Passing a Ruby expression directly gives the guard the expression's
*result* rather than the expression, because it is evaluated while the recipe is compiled.

A guard that receives `true` or `false` raises at converge time:

  ArgumentError: Invalid only_if/not_if command, expected a string: true (TrueClass)

Worse, an expression that happens to return a string is accepted and then run as a shell
command, so the guard quietly tests something entirely different to what was intended.

Only expressions that clearly produce a boolean are flagged, so a shell command built in Ruby
and held in a variable is left alone.

## Examples

```ruby
# bad
not_if ::File.exist?('/etc/foo')
only_if node['foo']['version'] == '1.0'

# good
not_if { ::File.exist?('/etc/foo') }
only_if { node['foo']['version'] == '1.0' }

# good - a string guard runs as a shell command
not_if 'test -f /etc/foo'
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
<td style="text-align:center">9.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
