+++
title = "UseBuildEssentialResource"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UseBuildEssentialResource`

The full name of the cop is: `Chef/Modernize/UseBuildEssentialResource`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use the build_essential resource from the build-essential cookbook 5.0+ or Chef Infra Client 14+ instead of using the build-essential::default recipe.

## Examples


#### incorrect

```ruby
depends 'build-essential'
include_recipe 'build-essential::default'
include_recipe 'build-essential'
```

#### correct

```ruby
build_essential 'install compilation tools'
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
<td style="text-align:center">5.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
