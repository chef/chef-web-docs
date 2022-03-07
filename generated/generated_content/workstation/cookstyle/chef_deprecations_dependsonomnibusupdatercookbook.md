+++
title = "DependsOnOmnibusUpdaterCookbook"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DependsOnOmnibusUpdaterCookbook`

The full name of the cop is: `Chef/Deprecations/DependsOnOmnibusUpdaterCookbook`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

do not depend on the EOL `omnibus_updater` cookbook. This cookbook no longer works with newer Chef Infra Client releases and has been replaced with the more reliable `chef_client_updater` cookbook.

## Examples


#### incorrect

```ruby
depends 'omnibus_updater'
```

#### correct

```ruby
depends 'chef_client_updater'
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
<td style="text-align:center">7.20.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
