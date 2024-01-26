+++
title = "azure_service_bus_namespace Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_bus_namespace"
identifier = "inspec/resources/azure/azure_service_bus_namespace Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_bus_namespace` InSpec audit resource to test the properties related to an Azure Service Bus Namespace.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` and `resource_group` are required parameters.

```ruby
describe azure_service_bus_namespace(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_BUS_NAMESPACE') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.ServiceBus/Namespaces' }
  its('location')                         { should eq 'East US' }
end
```

```ruby
describe azure_service_bus_namespace(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_BUS_NAMESPACE') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: Name of the Azure Service Bus namespaces to test.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

## Properties

`id`
: Resource ID.

`name`
: Resource name.

`type`
: Resource type. `Microsoft.ServiceBus/Namespaces`.

`location`
: The Geo-location where the resource lives.

`properties`
: The properties of the Service Bus Namespace.

`properties.serviceBusEndpoint`
: Endpoint you can use to perform Service Bus operations.

`properties.metricId`
: Identifier for Azure Insights metrics.

`properties.provisioningState`
: Provisioning state of the Namespace.

`sku.name`
: Name of this SKU.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/servicebus/stable/namespaces/get) for other properties available.

## Examples

### Test that the Service Bus Namespaces are provisioned successfully

```ruby
describe azure_service_bus_namespace(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_BUS_NAMESPACE') do
  its('properties.provisioningState') { should eq 'Succeeded' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Service Bus Namespace is found, it will exist.

describe azure_service_bus_namespace(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_BUS_NAMESPACE') do
  it { should exist }
end
```

### not_exists

```ruby
# If Service Bus Namespace is not found, it will not exist.

describe azure_service_bus_namespace(resource_group: 'RESOURCE_GROUP', name: 'SERVICE_BUS_NAMESPACE') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
