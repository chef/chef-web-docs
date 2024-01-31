+++
title = "azure_service_bus_topic Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_bus_topic"
identifier = "inspec/resources/azure/azure_service_bus_topic Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_bus_topic` InSpec audit resource to test the properties related to an Azure Service Bus topic.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_service_bus_topic(resource_group: 'RESOURCE_GROUP', namespace_name: 'SERVICE_BUS_NAMESPACE_NAME', name: 'SERVICE_BUS_NAMESPACE') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.ServiceBus/Namespaces/Topics' }
end
```

```ruby
describe azure_service_bus_topic(resource_group: 'RESOURCE_GROUP', namespace_name: 'SERVICE_BUS_NAMESPACE_NAME', name: 'SERVICE_BUS_NAMESPACE') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: Name of the Azure Service Bus topics to test.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

`namespace_name` _(required)_
: Name of the namespace where the topic resides.

## Properties

`id`
: Resource ID.

`name`
: Resource name.

`type`
: Resource type. `Microsoft.ServiceBus/Namespaces/Topics`.

`properties`
: The properties of the Service Bus topic.

`properties.maxSizeInMegabytes`
: Maximum size of the topic in megabytes, the memory size allocated for the topic. The default value is **1024**.

`properties.sizeInBytes`
: Size of the topic, in bytes.

`properties.status`
: Enumerates the possible values for the status of a messaging entity.

`properties.countDetails`
: Message count details.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/servicebus/stable/topics/get) for other properties available.

## Examples

### Test that the Service Bus topics are provisioned successfully

```ruby
describe azure_service_bus_topic(resource_group: 'RESOURCE_GROUP', namespace_name: 'SERVICE_BUS_NAMESPACE_NAME', name: 'SERVICE_BUS_NAMESPACE') do
  its('properties.status') { should eq 'Active' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Service Bus topic is found, it will exist.

describe azure_service_bus_topic(resource_group: 'RESOURCE_GROUP', namespace_name: 'SERVICE_BUS_NAMESPACE_NAME', name: 'SERVICE_BUS_NAMESPACE') do
  it { should exist }
end
```

### not_exists

```ruby
# If Service Bus topic is not found, it will not exist.

describe azure_service_bus_topic(resource_group: 'RESOURCE_GROUP', namespace_name: 'SERVICE_BUS_NAMESPACE_NAME', name: 'SERVICE_BUS_NAMESPACE') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
