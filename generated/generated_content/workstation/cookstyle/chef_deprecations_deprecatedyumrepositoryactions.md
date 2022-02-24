+++
title = "DeprecatedYumRepositoryActions"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DeprecatedYumRepositoryActions`

The full name of the cop is: `Chef/Deprecations/DeprecatedYumRepositoryActions`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.14+ |

With the release of Chef Infra Client 12.14 and the yum cookbook 3.0 the actions the `yum_repository` resource actions were renamed. The `add` action became `create` and `delete` became `remove` to better match other resources in Chef Infra Client.

## Examples


#### incorrect

```ruby
yum_repository 'OurCo' do
  description 'OurCo yum repository'
  baseurl 'http://artifacts.ourco.org/foo/bar'
  gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
  action :add
end
```

#### correct

```ruby
yum_repository 'OurCo' do
  description 'OurCo yum repository'
  baseurl 'http://artifacts.ourco.org/foo/bar'
  gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
  action :create
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
<td style="text-align:center">7.3.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
