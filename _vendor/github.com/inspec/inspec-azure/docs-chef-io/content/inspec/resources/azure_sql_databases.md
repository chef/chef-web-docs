+++
title = "azure_sql_databases Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_sql_databases"
identifier = "inspec/resources/azure/azure_sql_databases Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_sql_databases` InSpec audit resource to test the properties and configuration of Azure SQL Databases.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

The `resource_group` and `server_name` are required parameters.

```ruby
describe azure_sql_databases(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`server_name`
: The name of the server in which the database resides.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`types`
: A list of the types of resources being interrogated.

: **Field**: `type`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

`locations`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`kinds`
: A list of kinds of all the resources being interrogated.

: **Field**: `kind`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check resources are present

````ruby
describe azure_sql_databases(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME') do
    it { should exist }
    its('names') { should include 'my-db' }
end
````

### Filter the results to include only those with names that match the specified string value

```ruby
describe azure_sql_databases.(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME').where{ name.eql?('production-db') } do
  it { should exist }
end
```

### Filter the results to include only those with 'GRS' storage account type

```ruby
describe azure_sql_databases.(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME').where{ properties[:storageAccountType] == 'GRS' } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
# If we expect resources to exist.

describe azure_sql_databases(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect resources not to exist.

describe azure_sql_databases(resource_group: 'RESOURCE_GROUP', server_name: 'SERVER_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
