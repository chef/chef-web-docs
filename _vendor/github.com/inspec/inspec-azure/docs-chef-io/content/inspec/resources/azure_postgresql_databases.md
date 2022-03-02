+++
title = "azure_postgresql_databases Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_postgresql_databases"
identifier = "inspec/resources/azure/azure_postgresql_databases Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_postgresql_databases` InSpec audit resource to test properties and configuration of Azure PostgreSQL Databases.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

The `resource_group`, and `server_name` must be given as a parameter.
```ruby
describe azure_postgresql_databases(resource_group: 'my-rg', server_name: 'my-server') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`server_name`
: The name of the server in which the database resides. `serverName`.

## Properties

`ids`
: A list of the unique resource ids.

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

{{% inspec_filter_table %}}

## Examples

**Check Resources are Present.**

````ruby
describe azure_postgresql_databases(resource_group: 'my-rg', server_name: 'my-server') do
    it            { should exist }
    its('names')  { should include 'my-db' }
end
````
**Filter the Results to Include Only those with Names Match the Given String Value.**

```ruby
describe azure_postgresql_databases.(resource_group: 'my-rg', server_name: 'my-server').where{ name.eql?('production-db') } do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
# If we expect resources to exist

describe azure_postgresql_databases(resource_group: 'ExampleGroup', server_name: 'my-server') do
  it { should exist }
end

# If we expect resources not to exist

describe azure_postgresql_databases(resource_group: 'ExampleGroup', server_name: 'my-server') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
