+++
title = "Chef/RedundantCode/AptRepositoryDistributionDefault"
aliases = ["/workstation/cookstyle/chef_redundantcode_aptrepositorydistributiondefault/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/RedundantCode`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

There is no need to pass `distribution node['lsb']['codename']` to an apt_repository resource as this is done automatically by the apt_repository resource.

## Examples

### incorrect

```ruby
apt_repository 'my repo' do
  uri 'http://packages.example.com/debian'
  components %w(stable main)
  deb_src false
  distribution node['lsb']['codename']
end
```

### correct

```ruby
apt_repository 'my repo' do
  uri 'http://packages.example.com/debian'
  components %w(stable main)
  deb_src false
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
<td style="text-align:center">5.17.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
