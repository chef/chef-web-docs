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

Use the `azure_iothub_event_hub_consumer_groups` InSpec audit resource to test the properties and configuration of an Azure IoT Hub Event Hub Consumer Groups within a resource group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

The `resource_group`, `resource_name`, and `event_hub_endpoint` are required parameters.

```ruby
describe azure_iothub_event_hub_consumer_groups(resource_group: 'RESOURCE_GROUP', resource_name: 'IoT_NAME', event_hub_endpoint: 'EVENT_HUB_NAME') do
  its('names') { should include 'CONSUMER_GROUP'}
  its('types') { should include 'Microsoft.Devices/IotHubs/EventHubEndpoints/ConsumerGroups' }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`resource_name`
: The name of the IoT hub.

`event_hub_endpoint`
: The name of the Event Hub-compatible endpoint in the IoT hub.

## Properties

`ids`
: A list of the unique resource IDs.

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

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check if a specific consumer group exists

```ruby
describe azure_iothub_event_hub_consumer_groups(resource_group: 'RESOURCE_GROUP', resource_name: 'IoT_NAME', event_hub_endpoint: 'EVENT_HUB_NAME') do
  its('names') { should include('CONSUMER_GROUP') }
end
```

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
**If we expect at least one resource to exist on a specified endpoint.**

describe azure_iothub_event_hub_consumer_groups(resource_group: 'RESOURCE_GROUP', resource_name: 'IoT_NAME', event_hub_endpoint: 'EVENT_HUB_NAME') do
  it { should exist }
end

**If we expect not to exist consumer groups on a specified endpoint.**

describe azure_iothub_event_hub_consumer_groups(resource_group: 'RESOURCE_GROUP', resource_name: 'IoT_NAME', event_hub_endpoint: 'EVENT_HUB_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
