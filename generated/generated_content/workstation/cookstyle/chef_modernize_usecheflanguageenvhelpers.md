+++
title = "UseChefLanguageEnvHelpers"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UseChefLanguageEnvHelpers`

The full name of the cop is: `Chef/Modernize/UseChefLanguageEnvHelpers`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 15.5+ |

Chef Infra Client 15.5 and later include a large number of new helpers in the Chef Infra Language to simplify checking the system configuration in recipes and resources. These should be used when possible over more complex attributes or ENV var comparisons.

## Examples


#### incorrect

```ruby
ENV['CI']
ENV['TEST_KITCHEN']
```

#### correct

```ruby
ci?
kitchen?
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
<td style="text-align:center">7.21.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
<li><code>**/recipes/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
