+++
title = "Chef/Modernize/ConditionalUsingTest"
aliases = ["/workstation/cookstyle/chef_modernize_conditionalusingtest/"]

[menu]
  [menu.workstation]
    title = "ConditionalUsingTest"
    identifier = "chef_workstation/cookstyle/cops/Chef/Modernize/ConditionalUsingTest"
    parent = "chef_workstation/cookstyle/cops/Chef/Modernize"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use `::File.exist?('/foo/bar')` in an `only_if` or `not_if` guard instead of the slower `'test -f /foo/bar'`, which requires shelling out. The Ruby check has to be passed as a block. Passing it directly, as `not_if ::File.exist?('/foo/bar')`, raises `ArgumentError: Invalid only_if/not_if command, expected a string`.

## Examples

```ruby
# bad
only_if 'test -f /bin/foo'
not_if 'test -f /bin/foo'

# bad - a Ruby guard has to be a block, this raises at converge time
only_if ::File.exist?('/bin/foo')

# good
only_if { ::File.exist?('/bin/foo') }
not_if { ::File.exist?('/bin/foo') }
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
<td style="text-align:center">6.11.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
