+++
title = "azure_mariadb_server Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_mariadb_server"
identifier = "inspec/resources/azure/azure_mariadb_server Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_mariadb_server` InSpec audit resource to test the properties and configuration of an Azure MariaDB Server.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_mariadb_server(resource_group: 'RESOURCE_GROUP', name: 'EXAMPLE_SERVER') do
  it { should exist }
end
```

```ruby
describe azure_mariadb_server(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.DBforMariaDB/servers/{serverName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: Name of the MariaDB server to test.

`server_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

`firewall_rules_api_version`
: The endpoint api version for the `firewall_rules` property. The latest version will be used unless provided.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `server_name`

## Properties

`firewall_rules`
: A list of all firewall rules in the targeted server.

`sku`
: The SKU (pricing tier) of the server.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/mariadb/servers/get#server) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test if a MariaDB server is referenced with a valid name

```ruby
describe azure_mariadb_server(resource_group: 'RESOURCE_GROUP', name: 'SQL-SERVER-1') do
  it { should exist }
end
```

### Test if a MariaDB server is referenced with an invalid name

```ruby
describe azure_mariadb_server(resource_group: 'RESOURCE_GROUP', name: 'I-DONT-EXIST') do
  it { should_not exist }
end
```

### Test if a MariaDB server has firewall rules set

```ruby
describe azure_mariadb_server(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  its('firewall_rules') { should_not be_empty }
end
```

### Test a MariaDB server's location and maximum replica capacity

```ruby
describe azure_mariadb_server(resource_id: '/subscriptions/.../my-server') do
  its('properties.replicaCapacity') { should cmp 2 }
  its('location') { should cmp 'westeurope' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If we expect a resource to always exist.

describe azure_mariadb_server(resource_group: 'RESOURCE_GROUP, server_name: 'SQL-SERVER-1') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_mariadb_server(resource_group: 'RESOURCE_GROUP', server_name: 'SQL-SERVER-1') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
