+++
title = "Chef/Deprecations/ChefDKGenerators"
aliases = ["/workstation/cookstyle/chef_deprecations_chefdkgenerators/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Chef Workstation 0.8 and later renamed the `ChefDK` module used when writing custom cookbook generators from `ChefDK` to `ChefCLI`. For compatibility with the latest Chef Workstation releases you'll need to reference the new class names.

## Examples

### incorrect

```ruby
ChefDK::CLI
ChefDK::Generator::TemplateHelper
module ChefDK
  # some additional code
end
```

### correct

```ruby
ChefCLI::CLI
ChefCLI::Generator::TemplateHelper
module ChefCLI
  # some additional code
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
<td style="text-align:center">6.12.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
