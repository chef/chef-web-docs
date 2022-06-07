+++
title = "azure_container_registry Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_container_registry"
identifier = "inspec/resources/azure/azure_container_registry Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_container_registry` InSpec audit resource to test properties and configuration of an Azure Container Registry.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

This resource requires the `resource_group` and `name` parameters, or the `resource_id` parameter.

```ruby
describe azure_container_registry(resource_group: 'inspec-resource-group-9', name: 'example_cr') do
  it { should exist }
end
```

```ruby
describe azure_container_registry(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.ContainerRegistry/registries/{registryName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: The unique name of the targeted resource. `registryName`.

`container_registry_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.ContainerRegistry/registries/{registryName}`.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `container_registry_name`

## Properties

`id`
: The identity of the container registry, if configured.

`sku`
: The SKU of the container registry.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/containerregistry/registries/get#registry) for other available properties.

Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test the status of the retention policy for container registry.**

```ruby
describe azure_container_registry(resource_group: 'resource_group', name: 'container_registry_name') do
  its('properties.status.retentionPolicy') { should cmp 'enabled' }
end
```

```ruby
describe azure_container_registry(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.ContainerRegistry/registries/{registryName}') do
  its('properties.status.retentionPolicy') { should cmp 'enabled' }
end
```

See [integration tests](../../test/integration/verify/controls/azure_container_registry.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect 'cr-1' to always exist
describe azure_container_registry(resource_group: 'example', name: 'cr-1') do
  it { should exist }
end

# If we expect 'cr-1' to never exist
describe azure_container_registry(resource_group: 'example', name: 'cr-1') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
