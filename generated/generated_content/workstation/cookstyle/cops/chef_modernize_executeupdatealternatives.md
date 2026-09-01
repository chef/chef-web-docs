+++
title = "Chef/Modernize/ExecuteUpdateAlternatives"
aliases = ["/workstation/cookstyle/chef_modernize_executeupdatealternatives/"]

[menu]
  [menu.workstation]
    title = "ExecuteUpdateAlternatives"
    identifier = "chef_workstation/cookstyle/cops/Chef/Modernize/ExecuteUpdateAlternatives"
    parent = "chef_workstation/cookstyle/cops/Chef/Modernize"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 16.0+ |

Chef Infra Client 16.0 and later includes an `alternatives` resource that should be used to
manage alternatives links instead of shelling out to `update-alternatives` or `alternatives`.
The resource is idempotent and handles both the Debian and RHEL flavours of the command, where
an `execute` re-runs on every converge and reports the resource as updated every time.

## Examples

```ruby
# bad
execute 'install java alternative' do
  command 'update-alternatives --install /usr/bin/java java /usr/lib/jvm/jre-11/bin/java 1'
end

execute 'alternatives --set java /usr/lib/jvm/jre-11/bin/java'

# good
alternatives 'java' do
  link '/usr/bin/java'
  path '/usr/lib/jvm/jre-11/bin/java'
  priority 1
  action :install
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
