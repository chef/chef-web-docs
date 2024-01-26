+++
title = "azure_service_bus_subscriptions Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_bus_subscriptions"
identifier = "inspec/resources/azure/azure_service_bus_subscriptions Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_bus_subscriptions` InSpec audit resource to test the properties related to all Azure Service Bus subscriptions.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_service_bus_subscriptions` resource block returns all Azure Service Bus subscriptions.

```ruby
describe azure_service_bus_subscriptions(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', topic_name: 'TOPIC_NAME') do
  #...
end
```

## Parameters

`namespace_name` _(required)_
: The namespace name.

`topic_name` _(required)_
: The topic name.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

## Properties

`ids`
: A list of resource IDs.

: **Field**: `id`

`names`
: A list of resource names.

: **Field**: `name`

`types`
: A list of the resource types.

: **Field**: `type`

`properties`
: A list of properties for all the Service Bus subscriptions.

: **Field**: `properties`

`lockDurations`
: A list of the lock duration timespans.

: **Field**: `lockDuration`

`statuses`
: A list of statuses of a messaging entity.

: **Field**: `status`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that there are Service Bus subscriptions that are active

```ruby
describe azure_service_bus_subscriptions(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', topic_name: 'TOPIC_NAME').where(status: 'Active') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Service Bus subscriptions are present.

describe azure_service_bus_subscriptions(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', topic_name: 'TOPIC_NAME') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Service Bus subscription.

describe azure_service_bus_subscriptions(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', topic_name: 'TOPIC_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
