+++
title = "Chef/Style/NegatingOnlyIf"
aliases = ["/workstation/cookstyle/chef_style_negatingonlyif/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Style`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Instead of using only_if conditionals with ! to negate the returned value, use not_if which is easier to read

## Examples

### incorrect

```ruby
package 'legacy-sysv-deps' do
  only_if { !systemd }
end
```

### correct

```ruby
package 'legacy-sysv-deps' do
  not_if { systemd }
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
<td style="text-align:center">6.2.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
