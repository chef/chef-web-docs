+++
title = "Chef/Modernize/UseMultipackageInstalls"
aliases = ["/workstation/cookstyle/chef_modernize_usemultipackageinstalls/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Pass an array of packages to package resources instead of iterating over an array of packages when using multi-package capable package subsystem such as apt, yum, chocolatey, dnf, or zypper. Multi-package installs are faster and simplify logs.

## Examples

### incorrect

```ruby
%w(bmon htop vim curl).each do |pkg|
  package pkg do
    action :install
  end
end
```

### correct

```ruby
package %w(bmon htop vim curl)
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
