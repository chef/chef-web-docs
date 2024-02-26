+++
title = "azure_power_bi_capacity_workload Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_capacity_workload"
identifier = "inspec/resources/azure/azure_power_bi_capacity_workload Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_capacity_workload` InSpec audit resource to test the properties related to Azure Power BI Capacity workload.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` and `capacity_id` are required parameters.

```ruby
describe azure_power_bi_capacity_workload(capacity_id: 'CAPACITY_ID', name: 'WORKLOAD_NAME') do
  it  { should exist }
end
```

```ruby
describe azure_power_bi_capacity_workload(capacity_id: 'CAPACITY_ID', name: 'WORKLOAD_NAME')  do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: The workload Name.

`capacity_id` _(required)_
: The capacity ID.

## Properties

`name`
: The workload name.

`state`
: The capacity workload state.

`maxMemoryPercentageSetByUser`
: The memory percentage maximum Limit set by the user.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/capacities/get-workload) for other properties available.

## Examples

### Test that the Power BI Capacity workload is enabled

```ruby
describe azure_power_bi_capacity_workload(capacity_id: 'CAPACITY_ID', name: 'WORKLOAD_NAME')  do
  its('state') { should eq 'Enabled' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If the Power BI Capacity workload is found, it will exist.

describe azure_power_bi_capacity_workload(capacity_id: 'CAPACITY_ID', name: 'WORKLOAD_NAME')  do
  it { should exist }
end
```

### not_exists

```ruby
# if the Power BI Capacity workload is not found, it will not exist.

describe azure_power_bi_capacity_workload(capacity_id: 'CAPACITY_ID', name: 'WORKLOAD_NAME')  do
  it { should_not exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Capacity.Read.All` role on the Azure Power BI Capacity you wish to test.
