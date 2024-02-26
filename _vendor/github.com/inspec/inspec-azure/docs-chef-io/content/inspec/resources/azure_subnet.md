+++
title = "azure_subnet Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_subnet"
identifier = "inspec/resources/azure/azure_subnet Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_subnet` InSpec audit resource to test the properties related to a subnet for a given virtual network.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group`, `vnet`, and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_subnet(resource_group: 'RESOURCE_GROUP', vnet: 'VNET_NAME', name: 'SUBNET_NAME') do
  it { should exist }
end
```

```ruby
describe azure_subnet(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/virtualNetworks/{vnName}/subnets/{subnetName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`vnet`
: Name of the Azure virtual network where the subnet is created.

`name`
: Name of the Azure subnet to test.

`resource_id`
: The unique resource ID.

Provide one of the following parameter sets for a valid query:

- `resource_id`
- `resource_group`, `vnet`, and `name`

## Properties

`address_prefix`

: The address prefix for the subnet.

`nsg`

: The network security group attached to the subnet.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/subnets/get#subnet) for other properties available.
Any property in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Ensure that the subnets address prefix is configured as expected

```ruby
describe azure_subnet(resource_group: 'RESOURCE_GROUP', vnet: 'VNET_NAME', name: 'SUBNET_NAME') do
    its('address_prefix') { should eq '192.168.0.0/24' }
end
```

### Ensure that the subnet is attached to the right network security group

```ruby
describe azure_subnet(resource_group: 'RESOURCE_GROUP', vnet: 'VNET_NAME', name: 'SUBNET_NAME') do
    its('nsg') { should eq 'NetworkSecurityGroupName'}
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a subnet is found, it will exist.

describe azure_subnet(resource_group: 'RESOURCE_GROUP', vnet: 'VNET_NAME', name: 'SUBNET_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# subnets that aren't found, will not exist.

describe azure_subnet(resource_group: 'RESOURCE_GROUP', vnet: 'VNET_NAME', name: 'SUBNET_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
