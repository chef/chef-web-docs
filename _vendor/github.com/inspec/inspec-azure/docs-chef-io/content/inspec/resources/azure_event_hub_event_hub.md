+++
title = "azure_event_hub_event_hub Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_event_hub_event_hub"
identifier = "inspec/resources/azure/azure_event_hub_event_hub Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_event_hub_event_hub` InSpec audit resource to test properties of an Azure Event Hub description within a Resource Group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group`, `namespace_name` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_event_hub_event_hub(resource_group: 'my-rg', namespace_name: 'my-event-hub-ns', name: 'myeventhub') do
  it { should exist }
end
```
```ruby
describe azure_event_hub_event_hub(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `resourceGroupName`.

`namespace_name`
: The unique name of the Event Hub Namespace. `namespaceName`.

`name`
: The unique name of the targeted resource. `eventHubName`.

`event_hub_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group`, `namespace_name` and `name`
- `resource_group`, `namespace_name` and `event_hub_name`

## Properties

`properties.messageRetentionInDays`
: Number of days to retain the events for this Event Hub, value should be 1 to 7 days.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/eventhub/2017-04-01/eventhubs/get#eventhub) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test the Message Retention Time of an Event Hub.**

```ruby
describe azure_event_hub_event_hub(resource_group: 'my-rg', namespace_name: 'my-event-hub-ns', name: 'myeventhub') do
  its('properties.messageRetentionInDays') { should cmp 4 }
end
```
```ruby
describe azure_event_hub_event_hub(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}') do
  its('properties.messageRetentionInDays') { should cmp 4 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist

describe azure_event_hub_event_hub(resource_group: 'my-rg', namespace_name: 'my-event-hub-ns', name: 'myeventhub') do
  it { should exist }
end

# If we expect the resource not to exist

describe azure_event_hub_event_hub(resource_group: 'my-rg', namespace_name: 'my-event-hub-ns', name: 'myeventhub') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
