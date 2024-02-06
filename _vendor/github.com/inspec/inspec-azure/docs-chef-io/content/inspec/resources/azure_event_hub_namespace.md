+++
title = "azure_event_hub_namespace Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_event_hub_namespace"
identifier = "inspec/resources/azure/azure_event_hub_namespace Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_event_hub_namespace` InSpec audit resource to test the properties and configuration of an Azure Event Hub Namespace within a resource group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_event_hub_namespace(resource_group: 'RESOURCE_GROUP', name: 'EVENT_HUB_NAME') do
  it { should exist }
end
```

```ruby
describe azure_event_hub_namespace(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: The unique name of the Event Hub Namespace.

`namespace_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `namespace_name`

## Properties

`properties.kafkaEnabled`
: Value that indicates whether Kafka is enabled for Eventhub Namespace.

For parameters applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/eventhub/preview/namespaces/get?tabs=HTTP) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test if Kafka is enabled for an Eventhub Namespace

```ruby
describe azure_event_hub_namespace(resource_group: 'RESOURCE_GROUP', name: 'EVENT_HUB_NAME') do
  its('properties.kafkaEnabled') { should be true }
end
```

```ruby
describe azure_event_hub_namespace(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}') do
  its('properties.kafkaEnabled') { should be true }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist.

describe azure_event_hub_namespace(resource_group: 'RESOURCE_GROUP', name: 'EVENT_HUB_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the resource not to exist.

describe azure_event_hub_namespace(resource_group: 'RESOURCE_GROUP', name: 'EVENT_HUB_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
