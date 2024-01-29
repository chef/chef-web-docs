+++
title = "azure_power_bi_gateway Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_gateway"
identifier = "inspec/resources/azure/azure_power_bi_gateway Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_gateway` InSpec audit resource to test the properties related to an Azure Power BI gateway.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

The `gateway_id` is a required parameter.

```ruby
describe azure_power_bi_gateway(gateway_id: 'GATEWAY_ID') do
  it  { should exist }
end
```

## Parameters

`gateway_id` _(required)_
: The gateway ID.

## Properties

`id`
: The gateway ID.

`name`
: The gateway name.

`type`
: The gateway type.

`publicKey.exponent`
: The public key exponent.

`publicKey.modulus`
: The public key modulus.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/gateways/get-gateway) for other properties available.

## Examples

### Test that the Power BI gateway's exponent is 'AQAB'

```ruby
describe azure_power_bi_gateway(gateway_id: 'GATEWAY_ID')  do
  its('publicKey.exponent') { should eq 'AQAB' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If the Azure Power BI gateway is found, it will exist.

describe azure_power_bi_gateway(gateway_id: 'GATEWAY_ID')  do
  it { should exist }
end
```

### not_exists

```ruby
# if the Azure Power BI gateway is not found, it will not exist.

describe azure_power_bi_gateway(gateway_id: 'GATEWAY_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Dataset.Read.All` role on the Azure Power BI Workspace you wish to test.
