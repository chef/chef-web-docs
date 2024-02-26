+++
title = "azure_virtual_network_peering Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_network_peering"
identifier = "inspec/resources/azure/azure_virtual_network_peering Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_network_peering` InSpec audit resource to test the properties related to peering for a virtual network.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

This resource requires either the `resource_id` parameter or the `resource_group`, `vnet,` and `name` parameters.

```ruby
describe azure_virtual_network_peering(resource_group: 'RESOURCE_GROUP',vnet: 'VIRTUAL-NETWORK-NAME' name: 'VIRTUAL-NETWORK-PEERING-NAME') do
  it { should exist }
end
```

```ruby
describe azure_virtual_network_peering(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/virtualNetworks/{vnName}/virtualNetworkPeerings/{virtualNetworkPeeringName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`vnet`
: Name of the Azure virtual network where the virtual network peering is created.

`name`
: Name of the Azure virtual network peering to test.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group`, `vnet` and `name`

## Properties

`peering_state`
: The peering state for the virtual network peering. `its('peering_state') { should eq "Connected" }`.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/virtual-network-peerings/get#virtualnetworkpeering) for other properties available. Any property in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Ensure that the Virtual Network Peering state is connected

```ruby
describe azure_virtual_network_peering(resource_group: 'RESOURCE_GROUP',vnet: 'VIRTUAL-NETWORK-NAME' name: 'VIRTUAL-NETWORK-PEERING-NAME') do
    its('peering_state') { should eq 'Connected' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Virtual Network Peering is found, it will exist.

describe azure_virtual_network_peering(resource_group: 'RESOURCE_GROUP',vnet: 'VIRTUAL-NETWORK-NAME' name: 'VIRTUAL-NETWORK-PEERING-NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# Virtual Network Peerings that are not found, will not exist.

describe azure_virtual_network_peering(resource_group: 'RESOURCE_GROUP',vnet: 'VIRTUAL-NETWORK-NAME' name: 'VIRTUAL-NETWORK-PEERING-NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
