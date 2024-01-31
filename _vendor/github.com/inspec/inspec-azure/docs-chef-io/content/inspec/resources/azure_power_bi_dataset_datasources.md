+++
title = "azure_power_bi_dataset_datasources Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_dataset_datasources"
identifier = "inspec/resources/azure/azure_power_bi_dataset_datasources Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_dataset_datasources` Chef InSpec audit resource to test the properties of all Azure Power BI dataset data sources.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_dataset_datasources` resource block returns all Azure Power BI dataset data sources.

```ruby
describe azure_power_bi_dataset_datasources(dataset_id: 'DATASET_ID') do
  #...
end
```

## Parameters

`dataset_id` _(required)_
: The dataset ID.

`group_id` _(optional)_
: The workspace ID.

## Properties

`datasourceIds`
: List of all Power BI data source IDs.

: **Field**: `datasourceId`

`gatewayIds`
: List of all the bound gateway IDs.

: **Field**: `gatewayId`

`datasourceTypes`
: List of the data source types.

: **Field**: `datasourceType`

`connectionDetails`
: List of the data source connection details.

: **Field**: `connectionDetails`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/datasets/get-datasources) for other properties available.

## Examples

### Verify that a Power BI dataset data source for a server exists

```ruby
describe azure_power_bi_dataset_datasources(dataset_id: 'DATASET_ID').where{ connectionDetails[:server] == 'CONNECTION_SERVER' } do
  it { should exist }
end
```

## Matchers

This Chef InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

Verify that a Power BI dataset data source is not present.

```ruby
describe azure_power_bi_dataset_datasources(dataset_id: 'DATASET_ID') do
  it { should_not exist }
end
```

### not_exists

Verify that at least one Power BI dataset data source exists.

``` ruby
describe azure_power_bi_dataset_datasources(dataset_id: 'DATASET_ID') do
  it { should exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Dataset.Read.All` role on the Azure Power BI data set you wish to test.
