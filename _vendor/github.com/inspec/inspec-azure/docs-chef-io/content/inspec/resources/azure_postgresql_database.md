+++
title = "azure_postgresql_database Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_postgresql_database"
identifier = "inspec/resources/azure/azure_postgresql_database Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_postgresql_database` InSpec audit resource to test the properties and configuration of an Azure PostgreSQL database on a PostgreSQL server.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group`, `server_name` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_postgresql_database(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME', name: 'DATABASE_NAME') do
  it { should exist }
end
```

```ruby
describe azure_postgresql_database(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforPostgreSQL/servers/{serverName}/databases/{databaseName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`server_name`
: The name of the server on which the database resides.

`name`
: The unique name of the database.

`database_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforPostgreSQL/servers/{serverName}/databases/{databaseName}`.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group`, `server_name`, and `name`
- `resource_group`, `server_name`, and `database_name`

## Properties

`properties.charset`
: The charset of the database.

For properties applicable to all resources, such as `type`, `tags`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/postgresql/flexibleserver(preview)/databases/get) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test the resource name

```ruby
describe azure_postgresql_database(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME', name: 'DATABASE_NAME') do
  its('name')   { should be 'order-db' }
end
```

```ruby
describe azure_postgresql_database(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforPostgreSQL/servers/{serverName}/databases/order-db') do
  its('name')   { should be 'order-db' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist.

describe azure_postgresql_database(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME', name: 'DATABASE_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the resource to never exist.

describe azure_postgresql_database(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME', name: 'DATABASE_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
