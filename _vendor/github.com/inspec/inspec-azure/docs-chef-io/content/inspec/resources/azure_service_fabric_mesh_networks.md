+++
title = "azure_service_fabric_mesh_networks Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_fabric_mesh_networks"
identifier = "inspec/resources/azure/azure_service_fabric_mesh_networks Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_fabric_mesh_networks` InSpec audit resource to test the properties of all Azure Service Fabric Mesh networks.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_service_fabric_mesh_networks` resource block returns all Azure Service Fabric Mesh networks.

```ruby
describe azure_service_fabric_mesh_networks do
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
: A list of Properties for all the Service Fabric Mesh networks.

: **Field**: `properties`

`locations`
: A list of the Geo-locations.

: **Field**: `location`

`provisioningStates`
: A list of provisioning states of the Service Fabric Mesh networks.

: **Field**: `provisioningState`

`addressPrefixes`
: A list of address prefixes.

: **Field**: `addressPrefix`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through Service Fabric Mesh networks by their names

```ruby
azure_service_fabric_mesh_networks(resource_group: 'RESOURCE_GROUP').names.each do |name|
  describe azure_service_fabric_mesh_network(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

### Test that there are Service Fabric Mesh networks that are successfully provisioned

```ruby
describe azure_service_fabric_mesh_networks(resource_group: 'RESOURCE_GROUP').where(provisioningState: 'Succeeded') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Service Fabric Mesh networks are present.

describe azure_service_fabric_mesh_networks(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Service Fabric Mesh networks.

describe azure_service_fabric_mesh_networks(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
