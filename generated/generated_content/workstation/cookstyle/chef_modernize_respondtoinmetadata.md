+++
title = "RespondToInMetadata"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `RespondToInMetadata`

The full name of the cop is: `Chef/Modernize/RespondToInMetadata`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.15+ |

It is not longer necessary respond_to?(:foo) or defined?(foo) in metadata. This was used to support new metadata methods in Chef 11 and early versions of Chef 12.

## Examples


#### incorrect

```ruby
chef_version '>= 13' if respond_to?(:chef_version)
chef_version '>= 13' if defined?(chef_version)
chef_version '>= 13' unless defined?(Ridley::Chef::Cookbook::Metadata)
if defined(chef_version)
  chef_version '>= 13'
end
```

#### correct

```ruby
chef_version '>= 13'
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
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
