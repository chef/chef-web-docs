+++
title = "Chef/Modernize/CronManageResource"
aliases = ["/workstation/cookstyle/chef_modernize_cronmanageresource/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.4+ |

The cron_manage resource was renamed to cron_access in the 6.1 release of the cron cookbook, and later shipped in Chef Infra Client 14.4. The new resource name should be used.

## Examples

### incorrect

```ruby
cron_manage 'mike'
```

### correct

```ruby
cron_access 'mike'
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
<td style="text-align:center">5.6.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
