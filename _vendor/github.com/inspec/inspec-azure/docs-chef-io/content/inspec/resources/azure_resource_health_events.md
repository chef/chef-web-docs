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

Use the `azure_resource_health_events` InSpec audit resource to test the properties related to all Azure Resource Health events for the subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

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

{{< note >}}

To list all service health events in a subscription, do not provide any parameters.
To list events for a particular resource, pass in all three parameters listed below.
If one or more parameters are missing then all events in a subscription will be returned.

{{< /note >}}

`resource_group`
: Azure resource group where the targeted resource resides.

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

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

See the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/resourcehealth/events/list-by-single-resource) for other available properties.

## Examples

### Test that there are health events that have a service issue

```ruby
describe azure_resource_health_events.where{ properties.select{|prop| prop.eventType == 'ServiceIssue' } } do
  it { should exist }
end
```

### Test that there are health events for a particular resource

```ruby
describe azure_resource_health_events(resource_group: 'RESOURCE_GROUP', resource_type: 'RESOURCE_TYPE', resource_id: 'RESOURCE_ID') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no service health events are present in the subscription.

describe azure_resource_health_events do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one service health events in the subscription.

describe azure_resource_health_events do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
