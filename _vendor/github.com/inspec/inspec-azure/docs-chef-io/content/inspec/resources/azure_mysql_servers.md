+++
title = "azure_mysql_servers Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_mysql_servers"
identifier = "inspec/resources/azure/azure_mysql_servers Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_mysql_servers` InSpec audit resource to test properties and configuration of multiple Azure MySQL Servers.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_mysql_servers` resource block returns all Azure MySQL Servers, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_mysql_servers do
  #...
end
```
or
```ruby
describe azure_mysql_servers(resource_group: 'my-rg') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`locations`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

`skus`
: A list of the SKUs (pricing tiers) of the servers.

: **Field**: `sku`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Check MySQL Servers are present.**

```ruby
describe azure_mysql_servers do
  it            { should exist }
  its('names')  { should include 'my-server-name' }
end
```
**Filters the Results to Include Only Those Servers which Include the Given Name (Client Side Filtering).**

```ruby
describe azure_mysql_servers.where{ name.include?('production') } do
  it { should exist }
end
```
**Filters the Results to Include Only Those Servers which Reside in a Given Location (Client Side Filtering).**

```ruby
describe azure_mysql_servers.where{ location.eql?('westeurope') } do
  it { should exist }
end
```    
**Filters the Results to Include Only Those Servers which Reside in a Given Location and Include the Given Name (Server Side Filtering - Recommended).**

```ruby
describe azure_generic_resources(resource_provider: 'Microsoft.DBforMySQL/servers', substring_of_name: 'production', location: 'westeurope') do
  it {should exist}  
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
describe azure_mysql_servers do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
