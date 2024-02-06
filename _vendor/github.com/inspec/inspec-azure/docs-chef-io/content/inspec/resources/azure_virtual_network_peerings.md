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

Use the `azure_virtual_network_peerings` InSpec audit resource to test the properties related to virtual network peerings of a virtual network.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `vnet` are required parameters.

```ruby
describe azure_virtual_network_peerings(resource_group: 'RESOURCE_GROUP', vnet: 'VIRTUAL-NETWORK-NAME') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`vnet`
: The virtual network where the network PEERING you wish to test is part.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of all the resources being interrogated.

: **Field**: `name`

`etags`
: A list of etags defined on the resources.

: **Field**: `etag`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Exists if any Virtual Network Peerings exist for a given Virtual Network in the resource group

```ruby
describe azure_virtual_network_peerings(resource_group: 'MyResourceGroup', vnet: 'virtual-network-name') do
  it { should exist }
end
```

**Filters the Results to Only Those that Match the Given Name.**

```ruby
describe azure_virtual_network_peerings(resource_group: 'RESOURCE_GROUP', vnet: 'VIRTUAL-NETWORK-NAME') do
  .where(name: 'MyVirtualNetworkPeering') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no virtual network peerings are in the virtual network.

describe azure_virtual_network_peerings(resource_group: 'RESOURCE_GROUP', vnet: 'VIRTUAL-NETWORK-NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
