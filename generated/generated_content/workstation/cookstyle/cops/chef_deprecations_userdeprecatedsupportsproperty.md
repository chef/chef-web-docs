+++
title = "Chef/Deprecations/UserDeprecatedSupportsProperty"
aliases = ["/workstation/cookstyle/chef_deprecations_userdeprecatedsupportsproperty/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The supports property was removed in Chef Infra Client 13 in favor of individual 'manage_home' and 'non_unique' properties.

## Examples

### incorrect

```ruby
user "betty" do
  supports({
    manage_home: true,
    non_unique: true
  })
end

user 'betty' do
  supports :manage_home => true
end
```

### correct

```ruby
user "betty" do
  manage_home true
  non_unique true
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
