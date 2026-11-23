+++
title = "Chef/Correctness/ServiceResource"
aliases = ["/workstation/cookstyle/chef_correctness_serviceresource/"]

[menu]
  [menu.workstation]
    title = "ServiceResource"
    identifier = "chef_workstation/cookstyle/cops/Chef/Correctness/ServiceResource"
    parent = "chef_workstation/cookstyle/cops/Chef/Correctness"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Use the `service` resource to manage services instead of shelling out. The resource is
idempotent, picks the right init system for the platform, and reports correctly on what it
changed. A shelled out command runs on every converge whether or not anything needed to
change, so the run reports the resource as updated every time.

## Examples

```ruby
# bad
execute 'restart apache' do
  command 'systemctl restart httpd'
end

execute '/etc/init.d/httpd start'

# good
service 'httpd' do
  action :restart
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
<td style="text-align:center">5.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
