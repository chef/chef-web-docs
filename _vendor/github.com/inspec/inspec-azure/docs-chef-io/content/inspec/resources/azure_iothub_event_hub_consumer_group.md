+++
title = "azure_iothub_event_hub_consumer_group Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_iothub_event_hub_consumer_group"
identifier = "inspec/resources/azure/azure_iothub_event_hub_consumer_group Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_iothub_event_hub_consumer_group` InSpec audit resource to test properties and configuration of an Azure IoT Hub Event Hub Consumer Group within a Resource Group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group`, `resource_name`, `event_hub_endpoint` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_iothub_event_hub_consumer_group(resource_group: 'my-rg', resource_name: 'my-iot-hub', event_hub_endpoint: 'myeventhub', name: 'my-consumer-group') do
  it { should exist }
end
```
```ruby
describe azure_iothub_event_hub_consumer_group(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/eventHubEndpoints/{eventHubEndpointName}/ConsumerGroups/{name}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`resource_name`
: The name of the IoT hub. `my-iot-hub`.

`event_hub_endpoint`
: The name of the Event Hub-compatible endpoint in the IoT hub. `eventHubEndpointName`.

`name`
: The name of the consumer group to retrieve. `my-consumer-group`.

`consumer_group`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/eventHubEndpoints/{eventHubEndpointName}/ConsumerGroups/{name}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group`, `resource_name`, `event_hub_endpoint` and `name`
- `resource_group`, `resource_name`, `event_hub_endpoint` and `consumer_group`

## Properties

`name`
: The Event Hub-compatible consumer group name.

For properties applicable to all resources, such as `type`, `tags`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/iothub/iothubresource/geteventhubconsumergroup#eventhubconsumergroupinfo) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test the Name of a Resource.**

```ruby
describe azure_iothub_event_hub_consumer_group(resource_group: 'my-rg', resource_name: 'my-iot-hub', event_hub_endpoint: 'myeventhub', name: 'my-consumer-group') do
  its('name') { should cmp 'my-consumer-group' }
end
```
```ruby
describe azure_iothub_event_hub_consumer_group(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/eventHubEndpoints/{eventHubEndpointName}/ConsumerGroups/{name}') do
  its('name') { should cmp 'my-consumer-group' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist

describe azure_iothub_event_hub_consumer_group(resource_group: 'my-rg', resource_name: 'my-iot-hub', event_hub_endpoint: 'myeventhub', name: 'my-consumer-group') do
  it { should exist }
end

# If we expect the resource to never exist

describe azure_iothub_event_hub_consumer_group(resource_group: 'my-rg', resource_name: 'my-iot-hub', event_hub_endpoint: 'myeventhub', name: 'my-consumer-group') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
