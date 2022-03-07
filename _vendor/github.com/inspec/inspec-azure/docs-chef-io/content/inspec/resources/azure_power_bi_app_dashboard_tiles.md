+++
title = "azure_power_bi_app_dashboard_tiles Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_app_dashboard_tiles"
identifier = "inspec/resources/azure/azure_power_bi_app_dashboard_tiles Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_app_dashboard_tiles` InSpec audit resource to test the properties related to all Azure Power BI App dashboard tiles.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_power_bi_app_dashboard_tiles` resource block returns all Azure Power BI App dashboard tiles.

```ruby
describe azure_power_bi_app_dashboard_tiles(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID') do
  #...
end
```

## Parameters

`app_id` _(required)_

: The app ID.

`dashboard_id` _(required)_

: The App Dashboard ID.

## Properties

`ids`
: List of all App dashboard tile IDs.

: **Field**: `id`

`titles`
: List of all the dashboard title.

: **Field**: `title`

`embedUrls`
: List of all the dashboard embed urls.

: **Field**: `embedUrl`

`rowSpans`
: List of all the row span values.

: **Field**: `rowSpan`

`colSpans`
: List of all the col span values.

: **Field**: `colSpan`

`reportIds`
: List of all the report IDs.

: **Field**: `reportId`

`datasetIds`
: List of all the dataset IDs.

: **Field**: `datasetId`

{{% inspec_filter_table %}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/apps/get-tiles) for other properties available.

## Examples

**Loop through Power BI App dashboard tiles by their IDs.**

```ruby
azure_power_bi_app_dashboard_tiles(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID').ids.each do |id|
  describe azure_power_bi_app_dashboard_tile(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID', tile_id: id) do
    it { should exist }
  end
end
```

**Test to filter out Power BI App dashboard tiles that are in left corner.**

```ruby
describe azure_power_bi_app_dashboard_tiles(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID').where(rowSpan: 0, colSpan: 0) do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

Use `should` to test that an entity exists.

```ruby
describe azure_power_bi_app_dashboard_tiles(app_id: 'APP_ID') do
  it { should_not exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe azure_power_bi_app_dashboard_tiles(app_id: 'APP_ID') do
  it { should exist }
end
```

## Azure Permissions

This API does not support service principal authentication. Instead, use an Active Directory account access token to access this resource.
Your Active Directory account must be set up with a `Dashboard.Read.All` role on the Azure Power BI workspace that you wish to test.
