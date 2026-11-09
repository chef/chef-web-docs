+++
title = "Chef/Correctness/ChefApplicationFatal"
aliases = ["/workstation/cookstyle/chef_correctness_chefapplicationfatal/"]

[menu]
  [menu.workstation]
    title = "ChefApplicationFatal"
    identifier = "chef_workstation/cookstyle/cops/Chef/Correctness/ChefApplicationFatal"
    parent = "chef_workstation/cookstyle/cops/Chef/Correctness"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use `raise` to force Chef Infra Client to fail instead of using `Chef::Application.fatal`, which masks the full stack trace of the failure and makes debugging difficult.

`Chef::Application.fatal!` optionally takes an exit code as a second argument. That form is
reported but not autocorrected, since `raise` has no way to express a specific exit code and
rewriting it would silently change how the run terminates.

## Examples

```ruby
# bad
Chef::Application.fatal!('Something horrible happened!')
Chef::Application.fatal!('Something horrible happened!', 1)

# good
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
