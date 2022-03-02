+++
title = "azure_postgresql_server Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_postgresql_server"
identifier = "inspec/resources/azure/azure_postgresql_server Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_postgresql_server` InSpec audit resource to test properties and configuration of an Azure PostgreSql Server.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_postgresql_server(resource_group: 'inspec-resource-group-9', name: 'example_server') do
  it { should exist }
end
```
```ruby
describe azure_postgresql_server(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.DBforPostgreSQL/servers/{serverName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: Name of the PostgreSql server to test. `MyServer`.

`server_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.DBforPostgreSQL/servers/{serverName}`.

`configurations_api_version`
: The endpoint api version for the `configurations` property. The latest version will be used unless provided.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group` and `name`
- `resource_group` and `server_name`

## Properties

`configurations`
: An object containing all the configurations of a DB server available through [configurations](https://docs.microsoft.com/en-us/rest/api/postgresql/configurations/listbyserver) endpoint. Configuration values can be accessed as following, `configurations.client_encoding.properties.value`, `configurations.deadlock_timeout.properties.value`, etc.

`sku`
: The SKU (pricing tier) of the server.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/postgresql/servers/get#server) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test the Administrator's Login Name of a PostgreSql Server.**

```ruby
describe azure_postgresql_server(resource_group: 'my-rg', name: 'sql-server-1') do
  its('properties.administratorLogin') { should cmp 'admin' }
end
```
**Test the Fully Qualified Domain Name of a PostgreSql Server.**

```ruby
describe azure_postgresql_server(resource_group: 'my-rg', name: 'i-dont-exist') do
  its('properties.fullyQualifiedDomainName') { should cmp 'pgtestsvc1.postgres.database.azure.com' }
end
```    
**Test the Client Encoding Configuration Value of a PostgreSql Server.**

```ruby
describe azure_postgresql_server(resource_group: 'my-rg', name: 'my-server') do
  its('configurations.client_encoding.properties.value') { should cmp 'sql_ascii' }
end
```  
**Test the Deadlock Timeout Configuration Value of a PostgreSql Server.**

```ruby
describe azure_postgresql_server(resource_group: 'my-rg', name: 'my-server') do
  its('configurations.deadlock_timeout.properties.value') { should cmp '1000' }
end
```        
**Test a PostgreSql Server's Location and Maximum Replica Capacity.**

```ruby
describe azure_postgresql_server(resource_id: '/subscriptions/.../my-server') do
  its('properties.replicaCapacity') { should cmp 2 }
  its('location') { should cmp 'westeurope' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# If we expect a resource to always exist

describe azure_postgresql_server(resource_group: 'my-rg', server_name: 'server-name-1') do
  it { should exist }
end
# If we expect a resource to never exist

describe azure_postgresql_server(resource_group: 'my-rg', server_name: 'server-name-1') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
