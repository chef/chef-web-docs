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

Use the `azure_load_balancer` InSpec audit resource to test the properties and configuration of an Azure Load Balancer.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_load_balancer(resource_group: 'RESOURCE_GROUP', name: 'EXAMPLE_LB') do
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
: Azure resource group where the targeted resource resides.

`name`
: The unique name of the load balancer.

`loadbalancer_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `loadbalancer_name`

## Properties

`sku.name`
: Name of a load balancer SKU.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/load-balancer/loadbalancers/get#loadbalancer) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test if a Load Balancer has any inbound nat rules

```ruby
describe azure_load_balancer(resource_group: 'RESOURCE_GROUP', name: 'EXAMPLE_LB') do
  its('properties.inboundNatRules') { should_not be_empty }
end
```

### Loop through all Load Balancers in a subscription via 'resource_id'

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
# If we expect the resource to always exist.

describe azure_load_balancer(resource_group: 'RESOURCE_GROUP', name: 'EXAMPLE_LB') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the resource to never exist.

describe azure_load_balancer(resource_group: 'RESOURCE_GROUP', name: 'EXAMPLE_LB') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
