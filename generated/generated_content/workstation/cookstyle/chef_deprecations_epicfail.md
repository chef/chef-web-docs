+++
title = "EpicFail"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `EpicFail`

The full name of the cop is: `Chef/Deprecations/EpicFail`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use `ignore_failure` in resources to continue when failures occur instead of the deprecated `epic_fail` property.

## Examples


#### incorrect

```ruby
package "foo" do
  epic_fail true
end
```

#### correct

```ruby
package "foo" do
  ignore_failure true
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
<td style="text-align:center">5.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
