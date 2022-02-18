+++
title = "ShellOutToChocolatey"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ShellOutToChocolatey`

The full name of the cop is: `Chef/Modernize/ShellOutToChocolatey`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

## Examples


#### incorrect

```ruby
execute 'install package foo' do
  command "choco install --source=artifactory \"foo\" -y --no-progress --ignore-package-exit-codes"
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
<td style="text-align:center">5.5.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
