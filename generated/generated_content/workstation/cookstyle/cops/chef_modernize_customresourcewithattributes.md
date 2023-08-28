+++
title = "Chef/Modernize/CustomResourceWithAttributes"
aliases = ["/workstation/cookstyle/chef_modernize_customresourcewithattributes/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

In HWRPs and LWRPs you defined attributes, but custom resources changed the name to be properties to avoid confusion with chef recipe attributes. When writing a custom resource they should be called properties even though the two are aliased.

## Examples

### incorrect

```ruby
attribute :something, String

action :create do
  # some action code because we're in a custom resource
end
```

### correct

```ruby
property :something, String

action :create do
  # some action code because we're in a custom resource
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
<td style="text-align:center">5.2.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
