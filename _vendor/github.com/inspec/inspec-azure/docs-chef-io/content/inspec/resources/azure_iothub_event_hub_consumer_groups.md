+++
title = "azure_iothub_event_hub_consumer_groups Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_iothub_event_hub_consumer_groups"
identifier = "inspec/resources/azure/azure_iothub_event_hub_consumer_groups Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_iothub_event_hub_consumer_groups` InSpec audit resource to test properties and configuration of an Azure IoT Hub Event Hub Consumer Groups within a Resource Group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

The `resource_group`, `resource_name` and `event_hub_endpoint` must be given as a parameter.
```ruby
describe azure_iothub_event_hub_consumer_groups(resource_group: 'my-rg', resource_name: 'my-iot-hub', event_hub_endpoint: 'myeventhub') do
  its('names') { should include 'my-consumer-group'}
  its('types') { should include 'Microsoft.Devices/IotHubs/EventHubEndpoints/ConsumerGroups' }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`resource_name`
: The name of the IoT hub. `my-iot-hub`.

`event_hub_endpoint`
: The name of the Event Hub-compatible endpoint in the IoT hub. `eventHubEndpointName`.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`locations`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`types`
: A list of the types of resources being interrogated.

: **Field**: `type`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

`etags`
: A list of etags defined on the resources.

: **Field**: `etag`

{{% inspec_filter_table %}}

## Examples

**Check If a Specific Consumer Group Exists.**

```ruby
describe azure_iothub_event_hub_consumer_groups(resource_group: 'my-rg', resource_name: 'my-iot-hub', event_hub_endpoint: 'myeventhub') do
  its('names') { should include('my_consumer_group') }
end
```

**exists.**

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
**If we expect at least one resource to exists on a specified endpoint.**

describe azure_iothub_event_hub_consumer_groups(resource_group: 'my-rg', resource_name: 'my-iot-hub', event_hub_endpoint: 'myeventhub') do
  it { should exist }
end

**If we expect not to exist any consumer groups on a specified endpoint.**

describe azure_iothub_event_hub_consumer_groups(resource_group: 'my-rg', resource_name: 'my-iot-hub', event_hub_endpoint: 'myeventhub') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
