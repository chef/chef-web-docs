+++
title = "azure_redis_cache Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_redis_cache"
identifier = "inspec/resources/azure/azure_redis_cache Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_redis_cache` InSpec audit resource to test the properties related to an Azure Redis cache.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and `name` are required parameters.

```ruby
describe azure_redis_cache(resource_group: 'RESOURCE_GROUP', name: 'REDIS_CACHE_NAME') do
  it                                      { should exist }
  its('name')                             { should cmp 'REDIS_CACHE_NAME' }
  its('type')                             { should cmp 'Microsoft.Cache/Redis' }
  its('sku.name')                         { should cmp 'Standard' }
  its('sku.family')                       { should cmp 'C' }
  its('location')                         { should cmp 'southcentralus' }
end
```

```ruby
describe azure_redis_cache(resource_group: 'RESOURCE_GROUP', name: 'REDIS_CACHE_NAME') do
  it  { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: Name of the Azure Redis cache to test.

The parameter set should be provided for a valid query:

- `resource_group` and `name`

## Properties

`id`
: Resource ID.

`name`
: Redis Cache Name.

`location`
: Redis Cache Location.

`type`
: Resource type.

`tags`
: Resource tags.

`properties.sku.name`
: The type of Redis cache to deploy. Valid values: (Basic, Standard, Premium).

`properties.sku.family`
: The SKU family to use. Valid values: (C, P). (C = Basic/Standard, P = Premium).

`properties.sku.capacity`
: The size of the Redis cache to deploy. Valid values: for C (Basic/Standard) family (0, 1, 2, 3, 4, 5, 6), for P (Premium) family (1, 2, 3, 4).

`properties.provisioningState`
: The resource's provisioning state.

`properties.redisVersion`
: Redis version.

`properties.enableNonSslPort`
: Specifies whether the non-SSL Redis server port (6379) is enabled.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/redis/redis/get) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test that the Redis instance's provisioning status equals 'Succeeded'.**

```ruby
describe azure_redis_cache(resource_group: 'RESOURCE_GROUP', name: 'REDIS_CACHE_NAME') do
  its('properties.provisioningState') { should eq 'Succeeded' }
end
```

**Test that the Redis instance Skuname equals 'Standard'.**

**Skuname** is the Redis cache to deploy. Valid values are `Basic`, `Standard`, `Premium`.

```ruby
describe azure_redis_cache(resource_group: 'RESOURCE_GROUP', name: 'REDIS_CACHE_NAME') do
  its('properties.sku.name') { should eq 'Standard' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a redis cache is found it will exist

describe azure_redis_cache(resource_group: 'RESOURCE_GROUP', name: 'REDIS_CACHE_NAME') do
  it { should exist }
end

# Redis Caches that aren't found will not exist
describe azure_redis_cache(resource_group: 'RESOURCE_GROUP', name: 'REDIS_CACHE_NAME') do
  it { should_not exist }
end
```

### be_enabled_non_ssl_port

Ensure that the Redis Cache supports non-SSL ports.

```ruby
describe azure_redis_cache(resource_group: 'RESOURCE_GROUP', name: 'REDIS_CACHE_NAME') do
  it { should be_enabled_non_ssl_port }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
