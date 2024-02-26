+++
title = "azure_mysql_database_configuration Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_mysql_database_configuration"
identifier = "inspec/resources/azure/azure_mysql_database_configuration Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_mysql_database_configuration` InSpec audit resource to test the properties of an Azure MySQL Database Configuration on a MySQL Database Server.

## Syntax

`resource_group`, `server_name` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_mysql_database_configuration(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME', name: 'CONFIGURATION_NAME') do
  it { should exist }
end
```

```ruby
describe azure_mysql_database_configuration(resource_id: 'RESOURCE_ID') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`server_name`
: The name of the server on which the database resides.

`name`
: The unique name of the database configuration.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group`, `server_name`, and `name`

## Properties

`id`
: The id of the resource.

`name`
: The name of the resource.

`type`
: The type of the resource.

`properties.allowedValues`
: Allowed values of the configuration.

`properties.dataType`
: Data type of the configuration.

`properties.defaultValue`
: Default value of the configuration.

`properties.description`
: Description of the configuration.

`properties.source`
: Source of the configuration.

`properties.value`
: Value of the configuration.


For properties applicable to all resources, such as `type`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://learn.microsoft.com/en-us/rest/api/mysql/singleserver/configurations/get?tabs=HTTP) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test the resource name

```ruby
describe azure_mysql_database_configuration(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME', name: 'CONFIGURATION_NAME') do
  its('name') { should be 'CONFIGURATION_NAME' }
end
```

```ruby
describe azure_mysql_database_configuration(resource_id: 'RESOURCE_ID') do
  its('name') { should be 'CONFIGURATION_NAME' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist.
describe azure_mysql_database_configuration(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME', name: 'CONFIGURATION_NAME') do
  it { should exist }
end
```

```ruby
# If we expect the resource to never exist.
describe azure_mysql_database_configuration(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME', name: 'CONFIGURATION_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
