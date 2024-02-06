+++
title = "azure_power_bi_app_dashboard_tile Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_app_dashboard_tile"
identifier = "inspec/resources/azure/azure_power_bi_app_dashboard_tile Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_app_dashboard_tile` InSpec audit resource to test the properties related to an Azure Power BI app dashboard tile.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`app_id`, `dashboard_id`, and `tile_id` are required parameters.

```ruby
describe azure_power_bi_app_dashboard_tile(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID', tile_id: 'TILE_ID') do
  it  { should exist }
end
```

## Parameters

`app_id` _(required)_

: The app ID.

`dashboard_id` _(required)_

: The app Dashboard ID.

`tile_id` _(required)_

: The app dashboard tile ID.

## Properties

`id`
: The tile ID.

`title`
: The dashboard display name.

`embedUrl`
: The tile embed URL.

`rowSpan`
: number of rows a tile should span.

`colSpan`
: number of columns a tile should span.

`reportId`
: The report ID, which is available only for tiles created from a report.

`datasetId`
: The dataset ID, which is available only for tiles created from a report or using a dataset, such as Q&A tiles.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/apps/get-tile) for other properties available.

## Examples

### Test that the Power BI app dashboard tile is at the left corner

```ruby
describe azure_power_bi_app_dashboard_tile(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID', tile_id: 'TILE_ID')  do
  its('rowSpan') { should eq 0 }
  its('colSpan') { should eq 0 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If the Azure Power BI app dashboard tile is found, it will exist.

describe azure_power_bi_app_dashboard_tile(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID', tile_id: 'TILE_ID')  do
  it { should exist }
end
```

### not_exists

```ruby
# if the Azure Power BI app dashboard tile is not found, it will not exist.

describe azure_power_bi_app_dashboard_tile(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID', tile_id: 'TILE_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

This API does not support service principal authentication. Instead, use an Active Directory account access token to access this resource.
Your Active Directory account must be set up with a `Dashboard.Read.All` role on the Azure Power BI workspace you wish to test.
