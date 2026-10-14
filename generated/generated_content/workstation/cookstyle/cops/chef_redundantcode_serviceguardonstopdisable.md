+++
title = "Chef/RedundantCode/ServiceGuardOnStopDisable"
aliases = ["/workstation/cookstyle/chef_redundantcode_serviceguardonstopdisable/"]

[menu]
  [menu.workstation]
    title = "ServiceGuardOnStopDisable"
    identifier = "chef_workstation/cookstyle/cops/Chef/RedundantCode/ServiceGuardOnStopDisable"
    parent = "chef_workstation/cookstyle/cops/Chef/RedundantCode"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/RedundantCode`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The `:stop` and `:disable` actions of the `service` resource are already no-ops when the service
isn't installed, so guarding them with a check for the init script or unit file adds nothing. The
base provider only converges these actions when `current_resource.running`/`current_resource.enabled`
is set, and the platform providers never set that state for a service they can't find.

The guard is also actively harmful because it hardcodes a single path while the provider searches
several. A guard on `/usr/local/etc/rc.d/snmpd` skips a FreeBSD host running the service out of
`/etc/rc.d`, and the run then reports success while leaving the service enabled.

This cop only fires when every action is `:stop` or `:disable`. Actions like `:start`, `:enable`,
`:restart`, and `:reload` are asserted against the init script, so a guard there is meaningful. The
`systemd_unit` resource shells out unconditionally, so its guards are meaningful as well and are
never flagged.

## Examples

```ruby
# bad
service 'snmpd' do
  action %i(stop disable)
  only_if { ::File.exist?('/usr/local/etc/rc.d/snmpd') }
end

# good
service 'snmpd' do
  action %i(stop disable)
end
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
