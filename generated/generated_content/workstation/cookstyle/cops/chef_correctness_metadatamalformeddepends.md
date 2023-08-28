+++
title = "Chef/Correctness/MetadataMalformedDepends"
aliases = ["/workstation/cookstyle/chef_correctness_metadatamalformeddepends/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

metadata.rb cookbook dependencies and version constraints should be comma separated.

## Examples

### incorrect

```ruby
depends 'some_awesome_cookbook' '= 4.5.5'
depends 'some_other_cool_cookbook' '< 8.0'
```

### correct

```ruby
depends 'some_awesome_cookbook', '= 4.5.5'
depends 'some_other_cool_cookbook', '< 8.0'
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
<td style="text-align:center">7.16</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
