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

Use the `azure_public_ip` InSpec audit resource to test the properties of an Azure Public IP address.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_public_ip` resource block identifies a public IP address by `name` and `resource_group`, or the `resource_id`.

```ruby
describe azure_public_ip(resource_group: 'RESOURCE_GROUP', name: 'ADDRESS_NAME') do
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
: Azure resource group where the targeted resource resides.

`name`
: The unique name of the public IP address.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`

## Properties

`properties.ipAddress`
: The IP address associated with the public IP address resource.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/publicipaddresses/get#publicipaddress) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test the IP Address of a Public IP Resource

```ruby
describe azure_public_ip(resource_group: 'RESOURCE_GROUP', name: 'ADDRESS_NAME') do
  its('properties.ipAddress') { should cmp '51.224.11.75' }
end
```

```ruby
describe azure_public_ip(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPAddresses/{publicIpAddressName}') do
  its('properties.ipAddress') { should cmp '51.224.11.75' }
end
```

See [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_public_ip.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist.

describe azure_public_ip(resource_group: 'RESOURCE_GROUP', name: 'ADDRESS_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the resource not to exist.

describe azure_public_ip(resource_group: 'RESOURCE_GROUP', name: 'ADDRESS_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
