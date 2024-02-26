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

Use the `azure_virtual_network` InSpec audit resource to test the properties related to a virtual network.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and virtual network `name` or the `resource_id` are required parameters.

```ruby
describe azure_virtual_network(resource_group: 'RESOURCE_GROUP', name: 'VNET_NAME') do
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
: Azure resource group where the targeted resource resides.

`name`
: Name of the virtual network to test.

`resource_id`
: The unique resource ID.

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

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/virtualnetworks/get#virtualnetwork) for other properties available. Any property in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Ensure that the Virtual Network exists in the east US region

```ruby
describe azure_virtual_network(resource_group: 'RESOURCE_GROUP', name: 'VNET_NAME') do
  it               { should exist }
  its('location')  { should eq 'eastus' }
end
```

### Ensure that the Virtual Network's DNS servers are configured as expected

```ruby
describe azure_virtual_network(resource_group: 'RESOURCE_GROUP', name: 'VNET_NAME') do
    its('dns_servers') { should eq ["192.168.0.6"] }
end
```

### Ensure that the Virtual Network's address space is configured as expected

```ruby
describe azure_virtual_network(resource_group: 'RESOURCE_GROUP', name: 'VNET_NAME') do
    its('address_space') { should eq ["192.168.0.0/24"] }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a virtual network is found, it will exist.

describe azure_virtual_network(resource_group: 'RESOURCE_GROUP', name: 'VNET_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# Virtual networks that are not found, will not exist.

describe azure_virtual_network(resource_group: 'RESOURCE_GROUP', name: 'DOESNOTEXIST') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
