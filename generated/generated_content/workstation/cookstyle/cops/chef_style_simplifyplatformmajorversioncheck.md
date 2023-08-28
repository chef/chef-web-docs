+++
title = "Chef/Style/SimplifyPlatformMajorVersionCheck"
aliases = ["/workstation/cookstyle/chef_style_simplifyplatformmajorversioncheck/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Style`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

When checking the major version number of a platform you can take the node['platform_version'] attribute and transform it to an integer to strip it down to just the major version number. This simple way of determining the major version number of a platform should be used instead of splitting the platform into multiple fields with '.' as the delimiter.

## Examples

### incorrect

```ruby
node['platform_version'].split('.').first
node['platform_version'].split('.')[0]
node['platform_version'].split('.').first.to_i
node['platform_version'].split('.')[0].to_i
```

### correct

```ruby

# check to see if we're on RHEL 7 on a RHEL 7.6 node where node['platform_version] is 7.6.1810
if node['platform_version'].to_i == 7
  # some code
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
<td style="text-align:center">5.8.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
