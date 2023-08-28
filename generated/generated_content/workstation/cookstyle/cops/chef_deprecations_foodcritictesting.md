+++
title = "Chef/Deprecations/FoodcriticTesting"
aliases = ["/workstation/cookstyle/chef_deprecations_foodcritictesting/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The Foodcritic cookbook linter has been deprecated and should no longer be used for validating cookbooks.

## Examples

### incorrect

```ruby
gem 'foodcritic'
require 'foodcritic'
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
<td style="text-align:center">7.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/Rakefile</code></li>
<li><code>**/Gemfile</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
