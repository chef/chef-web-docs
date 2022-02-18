+++
title = "IncorrectLibraryInjection"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `IncorrectLibraryInjection`

The full name of the cop is: `Chef/Correctness/IncorrectLibraryInjection`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby
::Chef::Recipe.send(:include, Filebeat::Helpers)
::Chef::Provider.send(:include, Filebeat::Helpers)
::Chef::Recipe.include Filebeat::Helpers
::Chef::Provider.include Filebeat::Helpers
```

#### correct

```ruby
::Chef::DSL::Recipe.send(:include, Filebeat::Helpers) # covers previous Recipe & Provider classes
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
<td style="text-align:center">5.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
