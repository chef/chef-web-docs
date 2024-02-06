+++
title = "azure_application_gateway Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_application_gateway"
identifier = "inspec/resources/azure/azure_application_gateway Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_application_gateway` InSpec audit resource to test the properties and configuration of an Azure Application Gateway.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` must be given as a parameter.

```ruby
describe azure_application_gateway(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  it { should exist }
end
```

```ruby
describe azure_application_gateway(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/applicationGateways/{gatewayName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: The unique name of the targeted resource.

`application_gateway_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `application_gateway_name`

## Properties

`identity`
: The identity of the application gateway, if configured. It is a [managed service identity object](https://docs.microsoft.com/en-us/rest/api/application-gateway/applicationgateways/get#managedserviceidentity).

`zones`
: A list of availability zones denoting from where the resource needs to come.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/application-gateway/applicationgateways/get#applicationgateway) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test the SSL policy name of an application gateway

```ruby
describe azure_application_gateway(resource_group: 'RESOURCE_GROUP', application_gateway_name: 'APPLICATION_GATEWAY_NAME') do
  its('properties.sslPolicy.policyName') { should eq 'AppGwSslPolicy20170401S' }
end
```

```ruby
describe azure_application_gateway(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/applicationGateways/{gatewayName}') do
  its('properties.sslPolicy.policyName') { should eq 'AppGwSslPolicy20170401S' }
end
```

See [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_application_gateway.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect 'APPGW-1' always to exist.

describe azure_application_gateway(resource_group: 'RESOURCE_GROUP', name: 'APPGW-1') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect 'APPGW-1' never to exist.

describe azure_application_gateway(resource_group: 'RESOURCE_GROUP', name: 'APPGW-1') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
