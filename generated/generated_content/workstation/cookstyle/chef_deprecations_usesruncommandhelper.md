+++
title = "UsesRunCommandHelper"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UsesRunCommandHelper`

The full name of the cop is: `Chef/Deprecations/UsesRunCommandHelper`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
require 'chef/mixin/command'
include Chef::Mixin::Command

run_command('/bin/foo')
run_command_with_systems_locale('/bin/foo')
```

#### correct

```ruby
shell_out!('/bin/foo')
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
<td style="text-align:center">5.9.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
