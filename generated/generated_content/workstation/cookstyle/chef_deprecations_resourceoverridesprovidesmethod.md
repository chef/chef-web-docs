+++
title = "ResourceOverridesProvidesMethod"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ResourceOverridesProvidesMethod`

The full name of the cop is: `Chef/Deprecations/ResourceOverridesProvidesMethod`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Some providers in resources override the provides? method, used to check whether they are a valid provider on the current platform. In Chef Infra Client 13, this will cause an error. Instead use `provides :SOME_PROVIDER_NAME` to register the provider.

## Examples


#### incorrect

```ruby
def provides?
 true
end
```

#### correct

```ruby
provides :SOME_PROVIDER_NAME
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
<td style="text-align:center">5.7.0</td>
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
