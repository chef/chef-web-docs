+++
title = "Chef/Modernize/UseChefLanguageSystemdHelper"
aliases = ["/workstation/cookstyle/chef_modernize_usecheflanguagesystemdhelper/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 15.5+ |

Chef Infra Client 15.5 and later include a `systemd?` helper for checking if a Linux system uses systemd.

## Examples

### incorrect

```ruby
node['init_package'] == 'systemd'
```

### correct

```ruby
systemd?
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
<td style="text-align:center">7.24.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
