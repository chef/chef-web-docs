+++
title = "azure_public_ip Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_public_ip"
identifier = "inspec/resources/azure/azure_public_ip Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_public_ip` InSpec audit resource to test properties of an Azure Public IP address.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_public_ip` resource block identifies a public IP address by `name` and `resource_group` or the `resource_id`.
```ruby
describe azure_public_ip(resource_group: 'example', name: 'addressName') do
  it { should exist }
end
```
```ruby
describe azure_public_ip(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPAddresses/{publicIpAddressName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `resourceGroupName`.

`name`
: The unique name of the public IP address. `publicIpAddressName`.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPAddresses/{publicIpAddressName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group` and `name`

## Properties

`properties.ipAddress`
: The IP address associated with the public IP address resource.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/publicipaddresses/get#publicipaddress) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test the IP Address of a Public IP Resource.**

```ruby
describe azure_public_ip(resource_group: 'example', name: 'publicIpAddressName') do
  its('properties.ipAddress') { should cmp '51.224.11.75' }
end
``` 
```ruby
describe azure_public_ip(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPAddresses/{publicIpAddressName}') do
  its('properties.ipAddress') { should cmp '51.224.11.75' }
end
``` 
See [integration tests](../../test/integration/verify/controls/azurerm_public_ip.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist

describe azure_public_ip(resource_group: 'example', name: 'publicIpAddressName') do
  it { should exist }
end

# If we expect the resource not to exist

describe azure_public_ip(resource_group: 'example', name: 'publicIpAddressName') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
