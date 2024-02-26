+++
title = "azure_service_fabric_mesh_network Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_fabric_mesh_network"
identifier = "inspec/resources/azure/azure_service_fabric_mesh_network Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_fabric_mesh_network` InSpec audit resource to test the properties of an Azure Service Fabric Mesh network.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` and `resource_group` are required parameters.

```ruby
describe azure_service_fabric_mesh_network(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_NETWORK_NAME') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.ServiceFabricMesh/networks' }
  its('location')                         { should eq 'eastus' }
end
```

```ruby
describe azure_service_fabric_mesh_network(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_NETWORK_NAME') do
  it  { should exist }
end
```

## Parameters

`name`
: Name of the Azure Service Fabric Mesh networks to test.

`resource_group`
: Azure resource group where the targeted resource resides.

The parameter set that should be provided for a valid query is `resource_group` and `name`.

## Properties

`id`
: Resource ID.

`name`
: Resource name.

`type`
: Resource type. `Microsoft.ServiceFabricMesh/networks`.

`location`
: The Geo-location where the resource lives.

`properties`
: The properties of the Service Fabric Mesh network.

`properties.addressPrefix`
: the address prefix for this network.

`properties.provisioningState`
: State of the resource.

`properties.ingressConfig.qosLevel`
: The QoS tier for ingress.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/servicefabric/sfmeshrp-api-network_get) for other properties available.

## Examples

### Test that the Service Fabric Mesh network is provisioned successfully

```ruby
describe azure_service_fabric_mesh_network(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_NETWORK_NAME') do
  its('properties.provisioningState') { should eq 'Succeeded' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Service Fabric Mesh network is found, it will exist.

describe azure_service_fabric_mesh_network(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_NETWORK_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If a Service Fabric Mesh network is not found, it will not exist.

describe azure_service_fabric_mesh_network(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_NETWORK_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
