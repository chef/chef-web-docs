+++
title = "azure_power_bi_dashboard_tile Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_dashboard_tile"
identifier = "inspec/resources/azure/azure_power_bi_dashboard_tile Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_dashboard_tile` InSpec audit resource to test the properties related to an Azure Power BI dashboard tile.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_power_bi_dashboard_tile(group_id: 'GROUP_ID', dashboard_id: 'dashboard_ID', title_id: 'TITLE_ID') do
  it  { should exist }
end
```

## Parameters

`dashboard_id` _(required)_

: The dashboard ID.

`tile_id` _(required)_

: The tile ID.

`group_id` _(optional)_

: The workspace ID.

## Properties

`id`
: Power BI dashboard tile ID.

`title`
: The dashboard display name.

`embedUrl`
: The tile embed URL.

`rowSpan`
: The number of rows a tile should span.

`colSpan`
: The number of columns a tile should span.

`reportId`
: The report ID available only for tiles created from a report.

`datasetId`
: The dataset ID available only for tiles created from a report or using a dataset, such as Q&A tiles.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/dashboards/get-tile) for other properties available.

## Examples

### Test that the Power BI dashboard tile is on the left corner

```ruby
describe azure_power_bi_dashboard_tile(group_id: 'GROUP_ID', dashboard_id: 'dashboard_ID', title_id: 'TITLE_ID')  do
  its('rowSpan') { should eq 0 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# Use should to test for an Azure Power BI dashboard tile that should be in the resource group.

describe azure_power_bi_dashboard_tile(group_id: 'GROUP_ID', dashboard_id: 'dashboard_ID', title_id: 'TITLE_ID')  do
  it { should exist }
end
```

### not_exists

```ruby
# Use should_not to test for an Azure Power BI dashboard tile that should not be in the resource group.

describe azure_power_bi_dashboard_tile(group_id: 'GROUP_ID', dashboard_id: 'dashboard_ID', title_id: 'TITLE_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `dashboard.Read.All` role on the Azure Power BI Workspace you wish to test.
