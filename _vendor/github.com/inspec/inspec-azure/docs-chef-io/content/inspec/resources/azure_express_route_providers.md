+++
title = "azure_express_route_providers Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_express_route_providers"
identifier = "inspec/resources/azure/azure_express_route_providers Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_express_route_providers` InSpec audit resource to test the properties related to azure_express_route for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_express_route_providers` resource block returns all Azure azure_express_route, either within a resource group (if provided) or an entire Subscription.

```ruby
describe azure_express_route_providers do
  #...
end
```

Or

```ruby

describe azure_express_route_providers(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`names`
: A list of the unique resource IDs.

: **Field**: `name`

`types`
: A list of all the azure_express_route.

: **Field**: `type`

`ids`
: A list of id for all the azure_express_route.

: **Field**: `id`

`tags`
: A list of all the express_route names.

: **Field**: `tag`

`provisioning_states`
: A list of the status of the request.

: **Field**: `provisioning_state`

`peering_locations_list`
: A list of `peering locations` pairs defined on the resources.

: **Field**: `locations`

`bandwidths_offered_list`
: A list of `bandwidths offered` pairs defined on the resources.

: **Field**: `bandwidths`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test if any azure_express_route exists in the resource group

```ruby
describe azure_express_route_providers(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
describe azure_express_route_providers do
  it { should exist }
end
```

### Test that there are express_route that includes a string in names (Server Side Filtering via Generic Resource - Recommended)

```ruby
describe azure_generic_resources(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

```ruby
# Should not exist if no azure_express_route is in the resource group.

describe azure_express_route_providers(resource_group: 'RESOURCE_GROUP') do
  its('provisioning_states') { should include('Succeeded') }
  its('peering_locations_list') { should include(["Melbourne", "Sydney"]) }
  its('bandwidths_offered_list') { should include('bandwidths_offered') }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
