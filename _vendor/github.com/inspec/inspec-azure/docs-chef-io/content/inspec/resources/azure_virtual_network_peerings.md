+++
title = "azure_virtual_network_peerings Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_network_peerings"
identifier = "inspec/resources/azure/azure_virtual_network_peerings Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_network_peerings` InSpec audit resource to test properties related to virtual network peerings of a virtual network.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and `vnet` are required parameters.
```ruby
describe azure_virtual_network_peerings(resource_group: 'MyResourceGroup', vnet: 'virtual-network-name') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`vnet`
: The virtual network that the network peering that you wish to test is a part of.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`names`
: A list of all the resources being interrogated.

: **Field**: `name`

`etags`
: A list of etags defined on the resources.

: **Field**: `etag`

{{% inspec_filter_table %}}

## Examples

**Exists if Any Virtual Network Peerings Exist for a Given Virtual Network in the Resource Group.**

```ruby
describe azure_virtual_network_peerings(resource_group: 'MyResourceGroup', vnet: 'virtual-network-name') do
  it { should exist }
end
```
**Filters the Results to Only Those that Match the Given Name.**

```ruby
describe azure_virtual_network_peerings(resource_group: 'MyResourceGroup', vnet: 'virtual-network-name') do
  .where(name: 'MyVirtualNetworkPeering') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no virtual network peerings are in the virtual network

describe azure_virtual_network_peerings(resource_group: 'MyResourceGroup', vnet: 'virtual-network-name') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
