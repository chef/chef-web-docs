+++
title = "Chef/Modernize/SetOrReturnInResources"
aliases = ["/workstation/cookstyle/chef_modernize_setorreturninresources/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

set_or_return within a method should not be used to define property in a resource. Instead use the property method which properly validates and defines properties in a way that works with reporting and documentation functionality in Chef Infra Client

## Examples

### incorrect

```ruby
 def severity(arg = nil)
   set_or_return(
     :severity, arg,
     :kind_of => String,
     :default => nil
   )
 end
```

### correct

```ruby
property :severity, String
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
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
