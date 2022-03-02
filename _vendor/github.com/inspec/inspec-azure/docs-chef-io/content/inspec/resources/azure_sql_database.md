+++
title = "azure_sql_database Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_sql_database"
identifier = "inspec/resources/azure/azure_sql_database Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_sql_database` InSpec audit resource to test properties and configuration of an Azure SQL Database.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group`, `server_name` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_sql_database(resource_group: 'inspec-rg', server_name: 'customer_server', name: 'order-db') do
  it { should exist }
end
```
```ruby
describe azure_sql_database(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`server_name`
: The name of the server on which the database resides. `serverName`.

`name`
: Name of the SQL database to test. `MyDatabase`.

`database_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}`.

`auditing_settings_api_version`
: The endpoint api version for the `auditing_settings` property. The latest version will be used unless provided.

`threat_detection_settings_api_version`
: The endpoint api version for the `threat_detection_settings` property. The latest version will be used unless provided.

`encryption_settings_api_version`
: The endpoint api version for the `encryption_settings` property. The latest version will be used unless provided.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group`, `server_name`, and `name`
- `resource_group`, `server_name`, and `database_name`

## Properties

`encryption_settings`
: Database's transparent data encryption configuration with [these](https://docs.microsoft.com/en-us/rest/api/sql/transparentdataencryptions/get#transparentdataencryption) properties.

`auditing_settings`
: Database's blob auditing policy with [these](https://docs.microsoft.com/en-us/rest/api/sql/database%20auditing%20settings/get#databaseblobauditingpolicy) properties.

`threat_detection_settings`
: Threat detection settings for the targeted database with [these](https://docs.microsoft.com/en-us/rest/api/sql/databasethreatdetectionpolicies/get#databasesecurityalertpolicy) properties.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/sql/databases/get#database) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test If a SQL Database is Referenced with a Valid Name.**

```ruby
describe azure_sql_database(resource_group: 'inspec-rg', server_name: 'customer_server', name: 'order-db') do
  it { should exist }
end
```
**Test If a SQL Database is Referenced with an Invalid Name.**

```ruby
describe azure_sql_database(resource_group: 'inspec-rg', server_name: 'customer_server', name: 'order-db') do
  it { should_not exist }
end
```    
**Test If a SQL Database Has Transparent Data Encryption is Enabled.**

```ruby
describe azure_sql_database(resource_group: 'inspec-rg', server_name: 'customer_server', name: 'order-db') do
  its('encryption_settings.properties.status') { should cmp 'Enabled' }
end
```  
**Test If a SQL Database Auditing is Enabled.**

```ruby
describe azure_sql_database(resource_group: 'inspec-rg', server_name: 'customer_server', name: 'order-db') do
  its('auditing_settings.properties.status') { should cmp 'Enabled' }
end
```   
**Test If a SQL Database Threat Detection is Enabled.**

```ruby
describe azure_sql_database(resource_group: 'inspec-rg', server_name: 'customer_server', name: 'order-db') do
  its('threat_detection_settings.properties.status') { should cmp 'Enabled' }
end
``` 

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# If we expect a resource to always exist

describe azure_sql_database(resource_group: 'inspec-rg', server_name: 'customer_server', name: 'order-db') do
  it { should exist }
end
# If we expect a resource to never exist

describe azure_sql_database(resource_group: 'inspec-rg', server_name: 'customer_server', name: 'order-db') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
