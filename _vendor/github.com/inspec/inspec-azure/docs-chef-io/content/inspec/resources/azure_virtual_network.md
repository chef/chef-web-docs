+++
title = "azure_virtual_network Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_network"
identifier = "inspec/resources/azure/azure_virtual_network Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_network` InSpec audit resource to test properties related to a virtual network.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and virtual network `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_virtual_network(resource_group: 'MyResourceGroup', name: 'MyVnetName') do
  it { should exist }
end
```
```ruby
describe azure_virtual_network(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/virtualNetworks/{vnName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: Name of the virtual network to test. `MyVNetwork`.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/virtualNetworks/{vnName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group` and `name`

## Properties

`subnets`
: The list of subnet names that are attached to this virtual network. `its('subnets') { should eq ["MySubnetName"] }`.

`address_space`
: The list of address spaces used by the virtual network. `its('address_space') { should eq ["x.x.x.x/x"] }`.

`dns_servers`
: The list of DNS servers configured for the virtual network.  The virtual network returns these IP addresses when virtual machines makes a DHCP request. `its('dns_servers') { should eq ["x.x.x.x", "x.x.x.x"] }`.

`vnet_peerings`
: A mapping of names and the virtual network ids of the virtual network peerings. `its('vnet_peerings') { should eq "MyVnetPeeringConnection"=>"PeeringConnectionID"}`.

`enable_ddos_protection`
: Boolean value showing if Azure DDoS standard protection is enabled on the virtual network. `its('enable_ddos_protection') { should eq true }`.

`enable_vm_protection`
: Boolean value showing if the virtual network has VM protection enabled. `its('enable_vm_protection') { should eq false }`.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/virtualnetworks/get#virtualnetwork) for other properties available. 
Any property in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Ensure that the Virtual Network Exists in the East US Region.**

```ruby
describe azure_virtual_network(resource_group: 'resource_group', name: 'MyVnetName') do
  it               { should exist }
  its('location')  { should eq 'eastus' }
end
```
**Ensure that the Virtual Network's DNS Servers are Configured as Expected.**

```ruby
describe azure_virtual_network(resource_group: 'resource_group', name: 'MyVnetName') do
    its('dns_servers') { should eq ["192.168.0.6"] }
end
```
**Ensure that the Virtual Network's Address Space is Configured as Expected.**

```ruby
describe azure_virtual_network(resource_group: 'resource_group', name: 'MyVnetName') do
    its('address_space') { should eq ["192.168.0.0/24"] }
end
```    

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# If a virtual network is found it will exist

describe azure_virtual_network(resource_group: 'MyResourceGroup', name: 'MyVnetName') do
  it { should exist }
end

# virtual networks that aren't found will not exist
describe azure_virtual_network(resource_group: 'MyResourceGroup', name: 'DoesNotExist') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
