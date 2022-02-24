+++
title = "InsecureCookbookURL"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `InsecureCookbookURL`

The full name of the cop is: `Chef/Sharing/InsecureCookbookURL`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use secure Github and Gitlab URLs for source_url and issues_url

## Examples


#### incorrect

```ruby
source_url 'http://github.com/something/something'
source_url 'http://www.github.com/something/something'
source_url 'http://www.gitlab.com/something/something'
source_url 'http://gitlab.com/something/something'
```

#### correct

```ruby
source_url 'http://github.com/something/something'
source_url 'http://gitlab.com/something/something'
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
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
