+++
title = "Chef/Modernize/ResourceForcingCompileTime"
aliases = ["/workstation/cookstyle/chef_modernize_resourceforcingcompiletime/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The hostname, build_essential, chef_gem, and ohai_hint resources include 'compile_time' properties, which should be used to force the resources to run at compile time by setting `compile_time true`.

## Examples

### incorrect

```ruby
build_essential 'install build tools' do
 action :nothing
end.run_action(:install)
```

### correct

```ruby
build_essential 'install build tools' do
 compile_time true
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
<td style="text-align:center">5.18.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
