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

Use the `azure_express_route_providers` InSpec audit resource to test properties related to azure_express_route for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_express_route_providers` resource block returns all Azure azure_express_route, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_express_route_providers do
  #...
end
```
or
```ruby
describe azure_express_route_providers(resource_group: 'my-rg') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`names`
: A list of the unique resource ids.

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
: A list of status of request.

: **Field**: `provisioning_state`

`peering_locations_list`
: A list of `peering locations` pairs defined on the resources.

: **Field**: `locations`

`bandwidths_offered_list`
: A list of `bandwidths offered` pairs defined on the resources.

: **Field**: `bandwidths`

{{% inspec_filter_table %}}

## Examples

**Test If Any azure_express_route Exist in the Resource Group.**

```ruby
describe azure_express_route_providers(resource_group: 'MyResourceGroup') do
  it { should exist }
end
describe azure_express_route_providers do
  it { should exist }
end
``` 
**Test that There are express_route that Includes a Certain String in their Names (Server Side Filtering via Generic Resource - Recommended)   .**

```ruby
describe azure_generic_resources(resource_group: 'MyResourceGroup') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).


```ruby
# Should not exist if no azure_express_route are in the resource group

describe azure_express_route_providers(resource_group: 'MyResourceGroup') do
  its('provisioning_states') { should include('Succeeded') }
  its('peering_locations_list') { should include(["Melbourne", "Sydney"]) }
  its('bandwidths_offered_list') { should include('bandwidths_offered') }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
