+++
title = "azure_resource_health_events Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_resource_health_events"
identifier = "inspec/resources/azure/azure_resource_health_events Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_resource_health_events` InSpec audit resource to test properties related to all Azure Resource Health events for the subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_resource_health_events` resource block returns all Azure Resource Health events within a subscription or for a particular resource.

```ruby
describe azure_resource_health_events do
  #...
end
```

or

```ruby
describe azure_resource_health_events(resource_group: 'RESOURCE_GROUP', resource_type: 'RESOURCE_TYPE', resource_id: 'RESOURCE_ID') do
  #...
end
```

## Parameters

**Note**

To list all service health events in a subscription, do not provide any parameters.
To list events for a particular resource, pass in all three parameters listed below.
If one or more parameters are missing then all events in a subscription will be returned.

`resource_group`
: Azure resource group that the targeted resource resides in.

`resource_type`
: The name of the resource type.

`resource_id`
: The unique identifier of the resource.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of names for all the resources.

: **Field**: `name`

`types`
: A list of resource types for all the resources.

: **Field**: `type`

`properties`
: A list of properties for all the resources.

: **Field**: `properties`


{{% inspec_filter_table %}}

See the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/resourcehealth/events/list-by-single-resource) for other available properties.

## Examples

**Test that there are health events that have a service issue.**

```ruby
describe azure_resource_health_events.where{ properties.select{|prop| prop.eventType == 'ServiceIssue' } } do
  it { should exist }
end
```

**Test that there are health events for a particular resource.**

```ruby
describe azure_resource_health_events(resource_group: 'RESOURCE_GROUP', resource_type: 'RESOURCE_TYPE', resource_id: 'RESOURCE_ID') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no service health events are present in the subscription

describe azure_resource_health_events do
  it { should_not exist }
end

# Should exist if the filter returns at least one service health events in the subscription

describe azure_resource_health_events do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
