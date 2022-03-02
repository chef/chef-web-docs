+++
title = "LibarchiveFileResource"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `LibarchiveFileResource`

The full name of the cop is: `Chef/Modernize/LibarchiveFileResource`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 15.0+ |

Use the archive_file resource built into Chef Infra Client 15+ instead of the libarchive_file resource from the libarchive cookbook.

## Examples


#### incorrect

```ruby
depends 'libarchive'

libarchive_file "C:\file.zip" do
  path 'C:\expand_here'
end
```

#### correct

```ruby
archive_file "C:\file.zip" do
  path 'C:\expand_here'
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
<td style="text-align:center">5.5.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
