+++
title = "UsesDeprecatedMixins"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UsesDeprecatedMixins`

The full name of the cop is: `Chef/Deprecations/UsesDeprecatedMixins`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

do not use deprecated Mixins no longer included in Chef Infra Client 14 and later.

## Examples


#### incorrect

```ruby
include Chef::Mixin::LanguageIncludeAttribute
include Chef::Mixin::RecipeDefinitionDSLCore
include Chef::Mixin::LanguageIncludeRecipe
include Chef::Mixin::Language
include Chef::DSL::Recipe::FullDSL
require 'chef/mixin/language'
require 'chef/mixin/language_include_attribute'
require 'chef/mixin/language_include_recipe'
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
<td style="text-align:center">5.4.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
