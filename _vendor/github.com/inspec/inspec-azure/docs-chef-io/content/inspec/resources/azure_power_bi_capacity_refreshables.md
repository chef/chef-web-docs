+++
title = "azure_power_bi_capacity_refreshables Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_capacity_refreshables"
identifier = "inspec/resources/azure/azure_power_bi_capacity_refreshables Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_capacity_refreshables` InSpec audit resource to test the properties of multiple Azure Power BI Capacity refreshables.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_power_bi_capacity_refreshables` resource block returns all Azure Power BI Capacity refreshables.

```ruby
describe azure_power_bi_capacity_refreshables do
  #...
end
```

## Parameters

`capacity_id` _(optional)_

: The capacity ID.


## Properties

`ids`
: List of all Power Bi Capacity refreshable IDs.

: **Field**: `id`

`names`
: List of all the Power Bi Capacity refreshable names.

: **Field**: `name`

`kinds`
: List of all the Power Bi Capacity refreshable kinds.

: **Field**: `kind`

`refreshCounts`
: List of the number of refreshes within the summary time windows.

: **Field**: `refreshCount`

`refreshFailures`
: List of the number of refresh failures within the summary time window.

: **Field**: `refreshFailures`

`refreshesPerDays`
: List of the number of refreshes.

: **Field**: `refreshesPerDay`

`medianDurations`
: List of the median duration in seconds of a refresh.

: **Field**: `medianDuration`

`averageDurations`
: List of the average duration in seconds of a refresh.

: **Field**: `averageDuration`

{{% inspec_filter_table %}}

For additional information, refer to the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/capacities/get-refreshables) for other properties available.

## Examples

**Test to ensure Power BI Capacity refreshable schedules are enabled.**

```ruby
describe azure_power_bi_capacity_refreshables do
  its('refreshSchedules') { should_not be empty }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no Power BI Capacity refreshables are present

describe azure_power_bi_capacity_refreshables do
  it { should_not exist }
end
# Should exist if the filter returns at least one Power BI Capacity refreshables

describe azure_power_bi_capacity_refreshables do
  it { should exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Capacity.Read.All` role on the Azure Power BI Capacity you wish to test.
