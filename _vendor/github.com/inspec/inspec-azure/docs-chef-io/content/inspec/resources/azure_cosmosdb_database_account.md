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

Use the `azure_cosmosdb_database_account` InSpec audit resource to test the properties and configuration of an Azure CosmosDb Database account within a resource group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_cosmosdb_database_account(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
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
: Azure resource group where the targeted resource resides.

`name`
: The unique name of the targeted resource.

`cosmosdb_database_account`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `cosmosdb_database_account`

## Properties

`location`
: Resource location. For example, `eastus`.

`kind`
: Indicates the type of database account. For example, `GlobalDocumentDB`, `MongoDB`.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/sql/2021-02-01-preview/databases/get?tabs=HTTP) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test if a GlobalDocumentDB is accessible on public network

```ruby
describe azure_cosmosdb_database_account(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
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
# If we expect 'MY-COSMOS-DB' to always exist.

describe azure_cosmosdb_database_account(resource_group: 'RESOURCE_GROUP', name: 'MY-COSMOS-DB) do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect 'MY-COSMOS-DB' to never exist.

describe azure_cosmosdb_database_account(resource_group: 'RESOURCE_GROUP', name: 'MY-COSMOS-DB') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
