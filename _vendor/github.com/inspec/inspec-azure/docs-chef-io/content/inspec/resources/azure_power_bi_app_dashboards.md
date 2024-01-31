+++
title = "azure_power_bi_app_dashboards Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_app_dashboards"
identifier = "inspec/resources/azure/azure_power_bi_app_dashboards Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_app_dashboards` InSpec audit resource to test the properties of all Azure Power BI app dashboards.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_app_dashboards` resource block returns all Azure Power BI app dashboards.

```ruby
describe azure_power_bi_app_dashboards(app_id: 'APP_ID') do
  #...
end
```

## Parameters

`app_id` _(required)_
: The app ID.

## Properties

`ids`
: List of all app IDs.

: **Field**: `id`

`displayNames`
: List of all the dashboard display names.

: **Field**: `displayName`

`embedUrls`
: List of all the dashboard embed URLs.

: **Field**: `embedUrl`

`isReadOnlies`
: List of all the boolean read-only dashboard flags.

: **Field**: `isReadOnly`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/apps/get-dashboards) for other properties available.

## Examples

### Loop through Power BI app dashboards by their IDs

```ruby
azure_power_bi_app_dashboards(app_id: 'APP_ID').ids.each do |id|
  describe azure_power_bi_app_dashboard(app_id: 'APP_ID', dashboard_id: id) do
    it { should exist }
  end
end
```

### Test to filter out Power BI app dashboards that are read-only

```ruby
describe azure_power_bi_app_dashboards(app_id: 'APP_ID').where(isReadOnly: true) do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Power BI apps are present.

describe azure_power_bi_app_dashboards(app_id: 'APP_ID') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Power BI app.

describe azure_power_bi_app_dashboards(app_id: 'APP_ID') do
  it { should exist }
end
```

## Azure Permissions

This API does not support service principal authentication. Instead, use the Active Directory (AD) account access token to access this resource.
Your AD account must be set up with a `Dashboard.Read.All` role on the Azure Power BI workspace you wish to test.
