+++
title = "Chef/Modernize/NodeInitPackage"
aliases = ["/workstation/cookstyle/chef_modernize_nodeinitpackage/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'

## Examples

### incorrect

```ruby
::File.open('/proc/1/comm').gets.chomp == 'systemd'
::File.open('/proc/1/comm').chomp == 'systemd'
File.open('/proc/1/comm').gets.chomp == 'systemd'
File.open('/proc/1/comm').chomp == 'systemd'
IO.read('/proc/1/comm').chomp == 'systemd'
IO.read('/proc/1/comm').gets.chomp == 'systemd'
::IO.read('/proc/1/comm').chomp == 'systemd'
::IO.read('/proc/1/comm').gets.chomp == 'systemd'
File.exist?('/proc/1/comm') && File.open('/proc/1/comm').chomp == 'systemd'
only_if 'test -f /bin/systemctl && /bin/systemctl'
```

### correct

```ruby
node['init_package'] == 'systemd'
only_if { node['init_package'] == 'systemd' }
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
<td style="text-align:center">5.22.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
