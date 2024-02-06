+++
title = "azure_service_fabric_mesh_replica Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_fabric_mesh_replica"
identifier = "inspec/resources/azure/azure_service_fabric_mesh_replica Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_fabric_mesh_replica` InSpec audit resource to test the properties of an Azure Service Fabric Mesh replica.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_service_fabric_mesh_replica(resource_group: 'RESOURCE_GROUP', application_name: 'SERVICE_FABRIC_MESH_APPLICATION_NAME', service_name: 'SERVICE_FABRIC_MESH_SERVICE_NAME', name: 'SERVICE_FABRIC_MESH_SERVICE_REPLICA_NAME') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.ServiceFabricMesh/applications' }
  its('location')                         { should eq 'eastus' }
end
```

```ruby
describe azure_service_fabric_mesh_replica(resource_group: 'RESOURCE_GROUP', application_name: 'SERVICE_FABRIC_MESH_APPLICATION_NAME', service_name: 'SERVICE_FABRIC_MESH_SERVICE_NAME', name: 'SERVICE_FABRIC_MESH_SERVICE_REPLICA_NAME') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: Name of the Azure Service Fabric Mesh replicas to test.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

`application_name` _(required)_
: The identity of the application.

`service_name` _(required)_
: The identity of the service.

## Properties

`osType`
: The Operating system type required by the code in service.

`codePackages`
: Describes the set of code packages that form the service.

`networkRefs`
: The names of the private networks that this service needs to be part.

`replicaName`
: Name of the replica.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/servicefabric/sfmeshrp-api-replica_get) for other properties available.

## Examples

### Test that the Service Fabric Mesh replica Replica is equal to 1

```ruby
describe azure_service_fabric_mesh_replica(resource_group: 'RESOURCE_GROUP', application_name: 'SERVICE_FABRIC_MESH_APPLICATION_NAME', service_name: 'SERVICE_FABRIC_MESH_SERVICE_NAME', name: 'SERVICE_FABRIC_MESH_SERVICE_REPLICA_NAME') do
  its('replicaName') { should eq '1' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Service Fabric Mesh replica is found, it will exist.

describe azure_service_fabric_mesh_replica(resource_group: 'RESOURCE_GROUP', application_name: 'SERVICE_FABRIC_MESH_APPLICATION_NAME', service_name: 'SERVICE_FABRIC_MESH_SERVICE_NAME', name: 'SERVICE_FABRIC_MESH_SERVICE_REPLICA_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If a Service Fabric Mesh replica is not found, it will not exist.

describe azure_service_fabric_mesh_replica(resource_group: 'RESOURCE_GROUP', application_name: 'SERVICE_FABRIC_MESH_APPLICATION_NAME', service_name: 'SERVICE_FABRIC_MESH_SERVICE_NAME', name: 'SERVICE_FABRIC_MESH_SERVICE_REPLICA_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
