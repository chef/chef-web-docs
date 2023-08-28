+++
title = "Chef/Correctness/ChefApplicationFatal"
aliases = ["/workstation/cookstyle/chef_correctness_chefapplicationfatal/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use `raise` to force Chef Infra Client to fail instead of using `Chef::Application.fatal`, which masks the full stack trace of the failure and makes debugging difficult.

## Examples

### incorrect

```ruby
Chef::Application.fatal!('Something horrible happened!')
```

### correct

```ruby
raise "Something horrible happened!"
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
<td style="text-align:center">6.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
