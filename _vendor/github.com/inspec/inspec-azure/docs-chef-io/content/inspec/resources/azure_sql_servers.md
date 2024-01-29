+++
title = "azure_sql_servers Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_sql_servers"
identifier = "inspec/resources/azure/azure_sql_servers Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_sql_servers` InSpec audit resource to test the properties and configuration of multiple Azure SQL Servers.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_sql_servers` resource block returns all Azure SQL Servers, either within a resource group (if provided) or an entire subscription.

```ruby
describe azure_sql_servers do
  it { should exist }
end
```

Or

```ruby
describe azure_sql_servers(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`locations`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`kinds`
: A list of kinds of all the resources being interrogated.

: **Field**: `kind`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

`skus`
: A list of the SKUs (pricing tiers) of the servers.

: **Field**: `sku`

`types`
: A list of the types of resources being interrogated.

: **Field**: `type`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Checks if a specific SQL server is present

```ruby
describe azure_sql_servers do
  its('names')  { should include 'my-server-name' }
end
```

### Filters the results to include only those servers that have the specified name (Client Side Filtering)

```ruby
describe azure_sql_servers.where{ name.include?('production') } do
  it { should exist }
end
```

### Filters the results to include only those servers that reside in a specified location (Client Side Filtering)

```ruby
describe azure_sql_servers.where{ location.eql?('westeurope') } do
  it { should exist }
end
```

### Filters the results to include only those servers that reside in a specified location and have the specified name (Server Side Filtering - Recommended)

```ruby
describe azure_generic_resources(resource_provider: 'Microsoft.Sql/servers', substring_of_name: 'production', location: 'westeurope') do
  it {should exist}
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_sql_servers do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
