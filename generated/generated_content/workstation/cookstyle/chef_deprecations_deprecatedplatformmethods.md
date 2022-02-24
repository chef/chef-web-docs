+++
title = "DeprecatedPlatformMethods"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DeprecatedPlatformMethods`

The full name of the cop is: `Chef/Deprecations/DeprecatedPlatformMethods`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Use `provider_for_action` or provides instead of the deprecated `Chef::Platform` methods in resources, which were removed in Chef Infra Client 13.

## Examples


#### incorrect

```ruby
resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.provider_for_resource(resource, :create)

resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.find_provider("ubuntu", "16.04", resource)

resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.find_provider_for_node(node, resource)

Chef::Platform.set :platform => :mac_os_x, :resource => :package, :provider => Chef::Provider::Package::Homebrew
```

#### correct

```ruby
resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = resource.provider_for_action(:create)

# provides :package, platform_family: 'mac_os_x'
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
<td style="text-align:center">5.16.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
