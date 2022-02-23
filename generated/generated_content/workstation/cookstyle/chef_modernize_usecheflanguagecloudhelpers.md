+++
title = "UseChefLanguageCloudHelpers"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `UseChefLanguageCloudHelpers`

The full name of the cop is: `Chef/Modernize/UseChefLanguageCloudHelpers`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 15.5+ |

## Examples


#### incorrect

```ruby
node['cloud']['provider'] == 'alibaba'
node['cloud']['provider'] == 'ec2'
node['cloud']['provider'] == 'gce'
node['cloud']['provider'] == 'rackspace'
node['cloud']['provider'] == 'eucalyptus'
node['cloud']['provider'] == 'linode'
node['cloud']['provider'] == 'openstack'
node['cloud']['provider'] == 'azure'
node['cloud']['provider'] == 'digital_ocean'
node['cloud']['provider'] == 'softlayer'
```

#### correct

```ruby
alibaba?
ec2?
gce?
rackspace?
eucalyptus?
linode?
openstack?
azure?
digital_ocean?
softlayer?
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
<td style="text-align:center">7.22.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
<li><code>**/recipes/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
