+++
title = "Chef/Modernize/MacOsXUserdefaults"
aliases = ["/workstation/cookstyle/chef_modernize_macosxuserdefaults/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.0+ |

The mac_os_x_userdefaults resource was renamed to macos_userdefaults when it was added to Chef Infra Client 14.0. The new resource name should be used.

## Examples

### incorrect

```ruby
mac_os_x_userdefaults 'full keyboard access to all controls' do
  domain 'AppleKeyboardUIMode'
  global true
  value '2'
end
```

### correct

```ruby
macos_userdefaults 'full keyboard access to all controls' do
  domain 'AppleKeyboardUIMode'
  global true
  value '2'
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
<td style="text-align:center">5.6.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
