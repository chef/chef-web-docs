+++
title = "Chef/Deprecations/ChefShellout"
aliases = ["/workstation/cookstyle/chef_deprecations_chefshellout/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Don't use the deprecated `Chef::ShellOut` class which was removed in Chef Infra Client 13. Use the `Mixlib::ShellOut` class instead, which behaves identically or convert to the simpler `shell_out` helper.

## Examples

### incorrect

```ruby
include Chef::ShellOut
require 'chef/shellout'
Chef::ShellOut.new('some_command')
```

### correct

```ruby
include Mixlib::ShellOut
require 'mixlib/shellout'
Mixlib::ShellOut.new('some_command')
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
<td style="text-align:center">6.17.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
