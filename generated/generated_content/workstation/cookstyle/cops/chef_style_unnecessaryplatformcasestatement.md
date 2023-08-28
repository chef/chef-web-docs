+++
title = "Chef/Style/UnnecessaryPlatformCaseStatement"
aliases = ["/workstation/cookstyle/chef_style_unnecessaryplatformcasestatement/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Style`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use the platform?() and platform_family?() helpers instead of a case statement that only includes a single when statement.

## Examples

### incorrect

```ruby
case node['platform']
when 'ubuntu'
  log "We're on Ubuntu"
  apt_update
end

case node['platform_family']
when 'rhel'
  include_recipe 'yum'
end
```

### correct

```ruby
if platform?('ubuntu')
  log "We're on Ubuntu"
  apt_update
end

include_recipe 'yum' if platform_family?('rhel')
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
