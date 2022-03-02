+++
title = "ChefRewind"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ChefRewind`

The full name of the cop is: `Chef/Deprecations/ChefRewind`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.10+ |

Use `delete_resource` or `edit_resource` helpers introduced in Chef Infra Client 12.10 instead of functionality in the deprecated `chef-rewind` gem

## Examples


chef_gem 'chef-rewind'

require 'chef/rewind'

rewind "user[postgres]" do
  home '/var/lib/pgsql/9.2'
  cookbook 'my-postgresql'
end

unwind "user[postgres]"
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
<td style="text-align:center">5.14.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
