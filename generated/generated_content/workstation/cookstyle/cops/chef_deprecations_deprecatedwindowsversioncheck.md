+++
title = "Chef/Deprecations/DeprecatedWindowsVersionCheck"
aliases = ["/workstation/cookstyle/chef_deprecations_deprecatedwindowsversioncheck/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Don't use the deprecated `older_than_win_2012_or_8?` helper. Windows versions before 2012 and 8 are now end of life and this helper will always return false.

## Examples

### incorrect

```ruby
if older_than_win_2012_or_8?
  # do some legacy things
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
<td style="text-align:center">6.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
