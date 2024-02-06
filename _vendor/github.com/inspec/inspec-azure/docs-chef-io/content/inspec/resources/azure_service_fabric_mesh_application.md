+++
title = "azure_service_fabric_mesh_application Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_fabric_mesh_application"
identifier = "inspec/resources/azure/azure_service_fabric_mesh_application Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_fabric_mesh_application` InSpec audit resource to test the properties of an Azure Service Fabric Mesh application.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_service_fabric_mesh_application(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_APP_NAME') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.ServiceFabricMesh/applications' }
  its('location')                         { should eq 'eastus' }
end
```

```ruby
describe azure_service_fabric_mesh_application(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_APP_NAME') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: Name of the Azure Service Fabric Mesh applications to test.

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
: The properties of the Service Fabric Mesh application.

`properties.description`
: User-readable description of the application.

`properties.debugParams`
: Internal use.

`properties.provisioningState`
: State of the resource.

`properties.healthState`
: The health state of a resource such as application, Service, or Network.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/servicefabric/sfmeshrp-api-application_get) for other properties available.

## Examples

### Test that the Service Fabric Mesh application is provisioned successfully

```ruby
describe azure_service_fabric_mesh_application(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_APP_NAME') do
  its('properties.provisioningState') { should eq 'Succeeded' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Service Fabric Mesh application is found, it will exist.

describe azure_service_fabric_mesh_application(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_APP_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If a Service Fabric Mesh application is not found, it will not exist.

describe azure_service_fabric_mesh_application(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_FABRIC_MESH_APP_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
