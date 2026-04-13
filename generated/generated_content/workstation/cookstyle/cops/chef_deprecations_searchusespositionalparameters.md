+++
title = "Chef/Deprecations/SearchUsesPositionalParameters"
aliases = ["/workstation/cookstyle/chef_deprecations_searchusespositionalparameters/"]

[menu]
  [menu.workstation]
    title = "SearchUsesPositionalParameters"
    identifier = "chef_workstation/cookstyle/cops/Chef/Deprecations/SearchUsesPositionalParameters"
    parent = "chef_workstation/cookstyle/cops/Chef/Deprecations"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

In the cookbook search helper you need to use named parameters (key/value style) other than the first (type) and second (query string) values.

## Examples

```ruby
# bad
search(:node, '*:*', 0, 1000, { :ip_address => ["ipaddress"] })
search(:node, '*:*', 0, 1000)
search(:node, '*:*', 0)

# good
search(:node, '*:*', start: 0, rows: 1000, filter_result: { :ip_address => ["ipaddress"] })
search(:node, '*:*', start: 0, rows: 1000)
search(:node, '*:*', start: 0)
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
<td style="text-align:center">5.11.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
