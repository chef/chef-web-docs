+++
title = "Chef/Modernize/WindowsScResource"
aliases = ["/workstation/cookstyle/chef_modernize_windowsscresource/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 14.0+ |

The sc_windows resource from the sc cookbook allowed for the creation of windows services on legacy Chef Infra Client releases. Chef Infra Client 14.0 and later includes :create, :delete, and :configure actions without the need for additional cookbook dependencies. See the windows_service documentation at https://docs.chef.io/resources/windows_service for additional details on creating services with the windows_service resource.

## Examples

### incorrect

```ruby
sc_windows 'chef-client' do
  path "C:\\opscode\\chef\\bin"
  action :create
end
```

### correct

```ruby
windows_service 'chef-client' do
  action :create
  binary_path_name "C:\\opscode\\chef\\bin"
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
<td style="text-align:center">5.16.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
