+++
title = "azure_service_fabric_mesh_services Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_fabric_mesh_services"
identifier = "inspec/resources/azure/azure_service_fabric_mesh_services Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_fabric_mesh_services` InSpec audit resource to test the properties of all Azure Service Fabric Mesh services within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_service_fabric_mesh_services` resource block returns all Azure service Fabric Mesh services within a project.

```ruby
describe azure_service_fabric_mesh_services do
  #...
end
```

## Parameters

`resource_group` _(optional)_
: Azure resource group where the targeted resource resides.

## Properties

`ids`
: A list of resource IDs.

: **Field**: `id`

`names`
: A list of resource names.

: **Field**: `name`

`types`
: A list of the resource types.

: **Field**: `type`

`properties`
: A list of Properties for all the service Fabric Mesh services.

: **Field**: `properties`

`osTypes`
: The Operating system type required by the code in services.

: **Field**: `replicaCount`

`replicaCounts`
: The number of replicas of the service to create. Defaults to 1 if not specified.

: **Field**: `metricId`

`healthStates`
: The health state of a services resource.

: **Field**: `healthState`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through service Fabric Mesh services by their names

```ruby
azure_service_fabric_mesh_services(resource_group: 'RESOURCE_GROUP').names.each do |name|
  describe azure_service_fabric_mesh_service(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

### Test that there are service Fabric Mesh services that are healthy

```ruby
describe azure_service_fabric_mesh_services(resource_group: 'RESOURCE_GROUP').where(replicaCounts: 2) do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no service Fabric Mesh services are present.

describe azure_service_fabric_mesh_services(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one service Fabric Mesh services.

describe azure_service_fabric_mesh_services(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
