+++
title = "azure_cosmosdb_database_account Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_cosmosdb_database_account"
identifier = "inspec/resources/azure/azure_cosmosdb_database_account Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_cosmosdb_database_account` InSpec audit resource to test properties and configuration of an Azure CosmosDb Database Account within a Resource Group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_cosmosdb_database_account(resource_group: 'inspec-resource-group-9', name: 'my-cosmos-db') do
  it { should exist }
end
```
```ruby
describe azure_cosmosdb_database_account(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/databaseAccounts/{accountName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `resource-group-name`.

`name`
: The unique name of the targeted resource. `resource-name`.

`cosmosdb_database_account`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/databaseAccounts/{accountName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group` and `name`
- `resource_group` and `cosmosdb_database_account`

## Properties

`location`
: Resource location, e.g. `eastus`.

`kind`
: Indicates the type of database account, e.g. `GlobalDocumentDB`, `MongoDB`.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/cosmos-db-resource-provider/2020-04-01/databaseaccounts/get#databaseaccountgetresults) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test If a GlobalDocumentDB is Accessible on Public Network.**

```ruby
describe azure_cosmosdb_database_account(resource_group: 'my-rg', name: 'my-cosmos-db') do
  its('properties.publicNetworkAccess') { should cmp 'Enabled' }
end
```
```ruby
describe azure_cosmosdb_database_account(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/databaseAccounts/{accountName}') do
  its('properties.publicNetworkAccess') { should cmp 'Enabled' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect 'my-cosmos-db' to always exist
describe azure_cosmosdb_database_account(resource_group: 'example', name: 'appgw-1') do
  it { should exist }
end

# If we expect 'my-cosmos-db' to never exist
describe azure_cosmosdb_database_account(resource_group: 'example', name: 'my-cosmos-db') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
