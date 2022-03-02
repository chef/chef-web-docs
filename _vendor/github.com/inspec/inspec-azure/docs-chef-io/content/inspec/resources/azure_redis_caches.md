+++
title = "azure_redis_caches Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_redis_caches"
identifier = "inspec/resources/azure/azure_redis_caches Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_redis_caches` InSpec audit resource to test properties of multiple Azure Redis caches in a resource group or in an entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_redis_caches` resource block returns all Azure Redis caches within a Resource Group.

```ruby
describe azure_redis_caches(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

or

```ruby
describe azure_redis_caches(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

The parameter should be provided for a valid query

- `resource_group`

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

## Properties

`IDs`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of name for all the Resource names.

: **Field**: `name`

`types`
: A list of types for all the resources.

: **Field**: `type`

`locations`
: A list of locations for all the resources.

: **Field**: `location`

`properties`
: A list of properties all the resources.

: **Field**: `properties`

`tags`
: A list of resource tags.

: **Field**: `tags`

`sku_names`
: A list of the types of Redis caches to deploy.

: **Field**: `sku_name`

`sku_capacities`
: A list of the sizes of the Redis caches to deploy.

: **Field**: `sku_capacity`

`sku_families`
: A list of the SKU families to use.

: **Field**: `sku_family`

`instances_ssl_ports`
: A list of Redis instance SSL Ports.

: **Field**: `instances_ssl_ports`

`is_master_instance`
: A list of Redis instance is_master flag.

: **Field**: `is_master_instance`

`is_primary_instance`
: A list of Redis instance is_primary flag.

: **Field**: `is_primary_instance`

`max_clients`
: A list of max clients in redis configuration.

: **Field**: `max_clients`

`max_memory_reserves`
: A list of max memory reserves in Redis configuration.

: **Field**: `max_memory_reserved`

`max_fragmentation_memory_reserves`
: A list of max fragmentation memory reserves in redis configuration.

: **Field**: `max_fragmentation_memory_reserved`

`max_memory_deltas`
: A list of max memory deltas in Redis configuration.

: **Field**: `max_memory_delta`

`provisioning_states`
: A list of provisioning_states from the properties.

: **Field**: `provisioning_state`

`redis_versions`
: A list of Redis versions from the properties.

: **Field**: `redis_version`

`enable_non_ssl_port`
: A list of Redis caches where the non-SSL Redis server port (6379) is enabled.

: **Field**: `enable_non_ssl_port`

`public_network_access`
: A list of public network access from the properties.

: **Field**: `public_network_access`

`access_keys`
: A list of access keys from the properties.

: **Field**: `access_keys`

`host_names`
: A list of host names from the properties.

: **Field**: `host_name`

`ports`
: A list of ports from the properties.

: **Field**: `port`

`ssl_ports`
: A list of SSL ports from the properties.

: **Field**: `ssl_port`

`linked_servers`
: A list of linked servers from the Redis caches.

: **Field**: `linked_servers`

{{% inspec_filter_table %}}

## Examples

**Loop through Redis Caches by their names.**

```ruby
azure_redis_caches(resource_group: 'RESOURCE_GROUP').names.each do |name|
  describe azure_redis_cache(name: name) do
    it { should exist }
  end
end
```

**Test that there is Redis cache with a specific string in its names using client-side filtering.**

```ruby
describe azure_redis_caches(resource_group: 'RESOURCE_GROUP').where { name.include?('spec-client') } do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no redis caches are in the resource group

describe azure_redis_caches(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end

# Should exist if the filter returns at least one redis cache

describe azure_redis_caches(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
