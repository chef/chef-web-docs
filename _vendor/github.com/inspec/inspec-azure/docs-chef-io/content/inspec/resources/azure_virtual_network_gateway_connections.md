+++
title = "azure_virtual_network_gateway_connections Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_network_gateway_connections"
identifier = "inspec/resources/azure/azure_virtual_network_gateway_connections Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_network_gateway_connections` InSpec audit resource to test the properties related to all Azure Virtual Network Gateway connections within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_virtual_network_gateway_connections` resource block returns all Azure Virtual Network Gateway connections within a project.

```ruby
describe azure_virtual_network_gateway_connections(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group name where the targeted resource resides.

The parameter set should be provided for a valid query:

- `resource_group`

## Properties

`ids`
: A list of resource IDs.

: **Field**: `id`

`names`
: A list of resource names.

: **Field**: `name`

`types`
: A list of types.

: **Field**: `type`

`eTags`
: A list of eTags.

: **Field**: `eTag`

`locations`
: A list of all locations.

: **Field**: `location`

`properties`
: A list of Properties for all the virtual network gateway connections.

: **Field**: `properties`

`provisioningStates`
: A list of provisioning states.

: **Field**: `provisioningState`

`connectionTypes`
: A list of gateway connection types.

: **Field**: `connectionType`

`connectionProtocols`
: A list of connection protocols used for this connection.

: **Field**: `connectionProtocol`

`useLocalAzureIpAddresses`
: A list of private local Azure IPs for the connection.

: **Field**: `datacenterManagementServerName`

`ipsecPolicies`
: A list of all the IPSec policies to be considered by this connection.

: **Field**: `ipsecPolicies`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through Virtual Network Gateway connection by their names

```ruby
azure_virtual_network_gateway_connections(resource_group: 'RESOURCE_GROUP').names.each do |name|
  describe azure_virtual_network_gateway_connection(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

### Test that there are Virtual Network Gateway connections with IPsec type

```ruby
describe azure_virtual_network_gateway_connections(resource_group: 'RESOURCE_GROUP').where(connectionType: 'VPN_CONNECTION_TYPE') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Virtual Network Gateway connection is present in the project and the resource group.

describe azure_virtual_network_gateway_connections(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Virtual Network Gateway connection in the project and the resource group.

describe azure_virtual_network_gateway_connections(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
