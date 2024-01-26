+++
title = "azure_power_bi_capacity_workloads Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_capacity_workloads"
identifier = "inspec/resources/azure/azure_power_bi_capacity_workloads Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_capacity_workloads` InSpec audit resource to test the properties related to all Azure Power BI Capacity workloads.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_capacity_workloads` resource block returns all Azure Power BI Capacity workloads.

```ruby
describe azure_power_bi_capacity_workloads(capacity_id: 'CAPACITY_ID') do
  #...
end
```

## Parameters

`capacity_id`
: The capacity ID.

## Properties

`states`
: List of all Power Bi Capacity Workload IDs.

: **Field**: `state`

`names`
: List of all the Power Bi Capacity Workload names.

: **Field**: `name`

`maxMemoryPercentageSetByUsers`
: List of all the Power Bi Capacity Workload Kinds.

: **Field**: `maxMemoryPercentageSetByUser`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/capacities/get-Workloads) for other properties available.

## Examples

### Test to ensure Power BI Capacity Workload is enabled

```ruby
describe azure_power_bi_capacity_workloads(capacity_id: 'CAPACITY_ID').where(state: 'Enabled') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Power BI Capacity Workloads are present.

describe azure_power_bi_capacity_workloads(capacity_id: 'CAPACITY_ID') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Power BI Capacity Workloads.

describe azure_power_bi_capacity_workloads(capacity_id: 'CAPACITY_ID') do
  it { should exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Capacity.Read.All` role on the Azure Power BI Capacity you wish to test.
