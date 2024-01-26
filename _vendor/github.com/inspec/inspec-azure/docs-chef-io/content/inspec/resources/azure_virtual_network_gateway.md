+++
title = "azure_virtual_network_gateway Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_network_gateway"
identifier = "inspec/resources/azure/azure_virtual_network_gateway Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_network_gateway` InSpec audit resource to test the properties and configuration of an Azure Virtual Network Gateway.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name` are required parameters.

```ruby
describe azure_virtual_network_gateway(resource_group: 'RESOURCE_GROUP', name: 'VIRTUAL_NETWORK_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group` _(REQUIRED)_

: The Azure resource group where the targeted resource resides.

`name` _(REQUIRED)_

: The unique name of the targeted resource.

## Properties

`name`
: The resource name.

`id`
: The resource ID.

`etag`
: A unique read-only string that changes whenever the resource is updated.

`type`
: The resource type.

`location`
: The resource location.

`tags`
: The resource tags.

`properties.bgpSettings`
: The virtual network gateway's BGP speaker settings.

`properties.provisioningState`
: The provisioning state of the virtual network gateway resource.

`properties.vpnClientConfiguration`
: The reference to the VpnClientConfiguration resource, which represents the P2S VpnClient configurations.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/network-gateway/virtual-network-gateways/get) for other available properties. Any attribute in the response is accessed with the key names separated by dots (`.`).

## Examples

### Test the VPN client protocol of a virtual network gateway

```ruby
describe azure_virtual_network_gateway(resource_group: 'RESOURCE_GROUP', name: 'VIRTUAL_NETWORK_NAME') do
  its('properties.vpnClientConfiguration.vpnClientProtocols') { should include 'OpenVPN' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect a virtual network gateway to always exist.

describe azure_virtual_network_gateway(resource_group: 'RESOURCE_GROUP', name: 'VIRTUAL_NETWORK_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a virtual network gateway to never exist.

describe azure_virtual_network_gateway(resource_group: 'RESOURCE_GROUP', name: 'VIRTUAL_NETWORK_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
