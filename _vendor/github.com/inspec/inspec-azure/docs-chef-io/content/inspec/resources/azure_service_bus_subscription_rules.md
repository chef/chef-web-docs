+++
title = "azure_service_bus_subscription_rules Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_bus_subscription_rules"
identifier = "inspec/resources/azure/azure_service_bus_subscription_rules Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_bus_subscription_rules` InSpec audit resource to test the properties related to all Azure Service Bus subscription rules.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_service_bus_subscription_rules` resource block returns all Azure Service Bus subscription rules.

```ruby
describe azure_service_bus_subscription_rules(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', subscription_name: 'SUBSCRIPTION_NAME', topic_name: 'TOPIC_NAME') do
  #...
end
```

## Parameters

`namespace_name` _(required)_
: The namespace name.

`subscription_name` _(required)_
: The subscription name.

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
: A list of properties for all the Service Bus subscription rules.

: **Field**: `properties`

`filterTypes`
: A list of the filter types.

: **Field**: `filterType`

`sqlFilter`
: A list of sqlFilters.

: **Field**: `sqlFilter`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that there are Service Bus subscription rules that are of SQL Filter type

```ruby
describe azure_service_bus_subscription_rules(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', subscription_name: 'SUBSCRIPTION_NAME', topic_name: 'TOPIC_NAME').where(filterType: 'SqlFilter') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Service Bus subscription rules are present.

describe azure_service_bus_subscription_rules(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', subscription_name: 'SUBSCRIPTION_NAME', topic_name: 'TOPIC_NAME') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Service Bus subscription rule.

describe azure_service_bus_subscription_rules(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', subscription_name: 'SUBSCRIPTION_NAME', topic_name: 'TOPIC_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
