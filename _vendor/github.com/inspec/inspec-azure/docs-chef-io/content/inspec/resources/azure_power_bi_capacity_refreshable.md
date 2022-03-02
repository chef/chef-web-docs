+++
title = "azure_power_bi_capacity_refreshable Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_capacity_refreshable"
identifier = "inspec/resources/azure/azure_power_bi_capacity_refreshable Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_capacity_refreshable` InSpec audit resource to test the properties of an Azure Power BI Capacity refreshable.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

```ruby
describe azure_power_bi_capacity_refreshable(capacity_id: 'CAPACITY_ID', name: 'REFRESHABLE_ID') do
  it { should exist }
end
```

```ruby
describe azure_power_bi_capacity_refreshable(capacity_id: 'CAPACITY_ID', name: 'REFRESHABLE_ID')  do
  it { should exist }
end
```

## Parameters

`name` _(required)_

: The refreshable ID.

`capacity_id` _(required)_

: The capacity ID.

## Properties

`id`
: The object ID of the refreshable.

`kind`
: The refreshable kind.

`name`
: Display name of refreshable.

`startTime`
: The start time of the window for which summary data exists.

`endTime`
: The end time of the window for which summary data exists.

`refreshCount`
: The number of refreshes within the summary time window.

`refreshFailures`
: The number of refresh failures within the summary time window.

`refreshesPerDay`
: The number of refreshes (schedule+onDemand) per day within the summary time window with at most 60.

`refreshSchedule.days`
: Days to execute the refresh.

`refreshSchedule.enabled`
: Is the refresh enabled.


For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/capacities/get-refreshable-for-capacity) for other properties available.

## Examples

**Test that the Power BI Capacity refreshable schedule is enabled.**

```ruby
describe azure_power_bi_capacity_refreshable(capacity_id: 'CAPACITY_ID', name: 'REFRESHABLE_ID')  do
  its('refreshSchedules.enabled') { should be_truthy }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If the Power BI Capacity refreshable is found, it will exist
describe azure_power_bi_capacity_refreshable(capacity_id: 'CAPACITY_ID', name: 'REFRESHABLE_ID')  do
  it { should exist }
end
# if the Power BI Capacity refreshable is not found, it will not exist
describe azure_power_bi_capacity_refreshable(capacity_id: 'CAPACITY_ID', name: 'REFRESHABLE_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Capacity.Read.All` role on the Azure Power BI Capacity you wish to test.
