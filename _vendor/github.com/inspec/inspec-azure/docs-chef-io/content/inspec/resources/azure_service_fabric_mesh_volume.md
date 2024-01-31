+++
title = "azure_service_fabric_mesh_volume Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_fabric_mesh_volume"
identifier = "inspec/resources/azure/azure_service_fabric_mesh_volume Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_fabric_mesh_volume` InSpec audit resource to test the properties of an Azure Service Fabric Mesh volume.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_service_fabric_mesh_volume(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_VOLUME_NAME') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.ServiceFabricMesh/applications' }
  its('location')                         { should eq 'eastus' }
end
```

```ruby
describe azure_service_fabric_mesh_volume(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_VOLUME_NAME') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: Name of the Azure Service Fabric Mesh volumes to test.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

## Properties

`id`
: Resource ID.

`name`
: Resource name.

`type`
: Resource type. `Microsoft.ServiceFabricMesh/applications`.

`location`
: The Geo-location where the resource lives.

`properties`
: The properties of the Service Fabric Mesh volume.

`properties.description`
: User-readable description of the application.

`properties.provisioningState`
: State of the resource.

`properties.azureFileParameters.shareName`
: Name of the Azure Files file share that provides storage for the volume.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/servicefabric/sfmeshrp-api-volume_get) for other properties available.

## Examples

### Test that the Service Fabric Mesh volume is provisioned successfully

```ruby
describe azure_service_fabric_mesh_volume(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_VOLUME_NAME') do
  its('properties.provisioningState') { should eq 'Succeeded' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Service Fabric Mesh volume is found, it will exist.

describe azure_service_fabric_mesh_volume(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_VOLUME_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If Service Fabric Mesh volume is not found, it will not exist.

describe azure_service_fabric_mesh_volume(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_VOLUME_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
