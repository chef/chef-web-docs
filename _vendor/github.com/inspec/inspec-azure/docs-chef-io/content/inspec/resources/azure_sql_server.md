+++
title = "azure_sql_server Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_sql_server"
identifier = "inspec/resources/azure/azure_sql_server Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_sql_server` InSpec audit resource to test the properties and configuration of an Azure SQL Server.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_sql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  it { should exist }
end
```

```ruby
describe azure_sql_server(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: Name of the SQL server to test.

`server_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

`firewall_rules_api_version`
: The endpoint API version for the `firewall_rules` property. The latest version will be used unless provided.

`auditing_settings_api_version`
: The endpoint API version for the `auditing_settings` property. The latest version will be used unless provided.

`threat_detection_settings_api_version`
: The endpoint API version for the `threat_detection_settings` property. The latest version will be used unless provided.

`administrators_api_version`
: The endpoint API version for the `administrators` property. The latest version will be used unless provided.

`encryption_protector_api_version`
: The endpoint API version for the `encryption_protector` property. The latest version will be used unless provided.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `server_name`

## Properties

`firewall_rules`
: A list of all firewall rules in the targeted server with [these](https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/listbyserver#firewallrulelistresult) properties.

`administrators`
: A list of all administrators for the targeted server with [these](https://docs.microsoft.com/en-us/rest/api/sql/serverazureadadministrators/listbyserver#serverazureadadministrator) properties.

`encryption_protector`
: A list of all encryption protectors for the targeted server with [these](https://docs.microsoft.com/en-us/rest/api/sql/encryptionprotectors/listbyserver#encryptionprotector) properties.

`auditing_settings`
: Auditing settings for the targeted server with [these](https://docs.microsoft.com/en-us/rest/api/sql/server%20auditing%20settings/listbyserver#serverblobauditingpolicylistresult) properties.

`threat_detection_settings`
: Threat detection settings for the targeted server with [these](https://docs.microsoft.com/en-us/rest/api/sql/databasethreatdetectionpolicies/get#databasesecurityalertpolicy) properties.

`sku`
: The SKU (pricing tier) of the server.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/sql/servers/get#server) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test if a SQL server is referenced with a valid name

```ruby
describe azure_sql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  it { should exist }
end
```

### Test if a SQL server is referenced with an invalid name

```ruby
describe azure_sql_server(resource_group: 'RESOURCE_GROUP', name: 'i-dont-exist') do
  it { should_not exist }
end
```

### Test if a SQL server has firewall rules set

```ruby
describe azure_sql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  its('firewall_rules') { should_not be_empty }
end
```

### Test a SQL server's location and kind

```ruby
describe azure_sql_server(resource_id: '/subscriptions/.../my-server') do
  its('kind') { should cmp 'v12.0' }
  its('location') { should cmp 'westeurope' }
end
```

### Test a SQL server's auditing settings

```ruby
describe azure_sql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  its('auditing_settings.properties.state') { should cmp 'Disabled' }
  its('auditing_settings.properties.retentionDays') { should be 0 }
  its('auditing_settings.properties.isStorageSecondaryKeyInUse') { should be false }
  its('auditing_settings.properties.isAzureMonitorTargetEnabled') { should be false }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If we expect a resource to always exist.

describe azure_sql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_sql_server(resource_group: 'RESOURCE_GROUP', name: 'SERVER_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
