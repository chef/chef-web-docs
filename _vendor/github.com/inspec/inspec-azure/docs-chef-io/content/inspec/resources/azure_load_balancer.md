+++
title = "azure_load_balancer Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_load_balancer"
identifier = "inspec/resources/azure/azure_load_balancer Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_load_balancer` InSpec audit resource to test properties and configuration of an Azure Load Balancer.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_load_balancer(resource_group: 'inspec-resource-group-9', name: 'example_lb') do
  it { should exist }
end
```
```ruby
describe azure_load_balancer(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: The unique name of the load balancer. `loadBalancerName`.

`loadbalancer_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group` and `name`
- `resource_group` and `loadbalancer_name`


## Properties

`sku.name`
: Name of a load balancer SKU.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/load-balancer/loadbalancers/get#loadbalancer) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test if a Load Balancer has Any Inbound Nat Rules.**

```ruby
describe azure_load_balancer(resource_group: 'my-rg', name: 'lb-1') do
  its('properties.inboundNatRules') { should_not be_empty }
end
```

**Loop through All Load Balancers in a Subscription via `resource_id`.**

```ruby
azure_load_balancers.ids.each do |id|
    describe azure_load_balancer(resource_id: id) do
      its('properties.inboundNatRules') { should_not be_empty }
    end
end 
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist

describe azure_load_balancer(resource_group: 'my-rg', name: 'lb-1') do
  it { should exist }
end

# If we expect the resource to never exist

describe azure_load_balancer(resource_group: 'my-rg', name: 'lb-1') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
