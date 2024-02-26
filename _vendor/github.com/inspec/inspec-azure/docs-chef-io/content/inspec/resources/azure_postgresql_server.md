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

Use the `azure_postgresql_server` InSpec audit resource to test the properties and configuration of an Azure PostgreSql server.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_postgresql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
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
: Azure resource group where the targeted resource resides.

`name`
: Name of the PostgreSql server to test.

`server_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

`configurations_api_version`
: The endpoint API version for the `configurations` property. The latest version will be used unless provided.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `server_name`

## Properties

`configurations`
: An object containing all the configurations of a DB server available through [configurations](https://docs.microsoft.com/en-us/rest/api/postgresql/singleserver/configurations/list-by-server) endpoint. Configuration values can be accessed as follows, `configurations.client_encoding.properties.value`, `configurations.deadlock_timeout.properties.value`, and so on.

`sku`
: The SKU (pricing tier) of the server.

`firewall_rules`
: An object of firewall rules applied on postgresql server.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/postgresql/flexibleserver(preview)/servers/get) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test the administrator's login name of a PostgreSql server

```ruby
describe azure_postgresql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  its('properties.administratorLogin') { should cmp 'admin' }
end
```

### Test the fully qualified domain name of a PostgreSql server

```ruby
describe azure_postgresql_server(resource_group: 'RESOURCE_GROUP', name: 'i-dont-exist') do
  its('properties.fullyQualifiedDomainName') { should cmp 'pgtestsvc1.postgres.database.azure.com' }
end
```

### Test the client encoding configuration value of a PostgreSql server

```ruby
describe azure_postgresql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  its('configurations.client_encoding.properties.value') { should cmp 'sql_ascii' }
end
```

### Test the deadlock timeout configuration value of a PostgreSql server

```ruby
describe azure_postgresql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  its('configurations.deadlock_timeout.properties.value') { should cmp '1000' }
end
```

### Test a PostgreSql server's location and maximum replica capacity

```ruby
describe azure_postgresql_server(resource_id: '/subscriptions/.../my-server') do
  its('properties.replicaCapacity') { should cmp 2 }
  its('location') { should cmp 'westeurope' }
end
```
### Test a PostgreSql server's firewall rules

```ruby
describe azure_postgresql_server(resource_id: '/subscriptions/.../my-server') do
  its('firewall_rules') { should eq {} }
end
```
## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If we expect a resource to always exist.

describe azure_postgresql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_postgresql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
