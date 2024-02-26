+++
title = "azure_power_bi_app_reports Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_app_reports"
identifier = "inspec/resources/azure/azure_power_bi_app_reports Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_app_reports` InSpec audit resource to test the properties related to all Azure Power BI app reports.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_app_reports` resource block returns all Azure Power BI app reports.

```ruby
describe azure_power_bi_app_reports(app_id: 'APP_ID') do
  #...
end
```

## Parameters

`app_id` _(required)_

: The app ID.

## Properties

`ids`
: List of all app report IDs.

: **Field**: `id`

`embedUrls`
: List of all the report embed URLs.

: **Field**: `embedUrl`

`appIds`
: List of all the app IDs.

: **Field**: `appId`

`datasetIds`
: List of all the Dataset IDs.

: **Field**: `datasetId`

`names`
: List of all the report names.

: **Field**: `name`

`webUrls`
: List of all the report web URLs.

: **Field**: `webUrl`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/apps/get-reports) for other properties available.

## Examples

### Loop through Power BI app reports by their IDs

```ruby
azure_power_bi_app_reports(app_id: 'APP_ID').ids.each do |id|
  describe azure_power_bi_app_report(app_id: 'APP_ID', report_id: id) do
    it { should exist }
  end
end
```

### Test to filter out Power BI app reports by report name

```ruby
describe azure_power_bi_app_reports(app_id: 'APP_ID').where(name: 'REPORT_NAME') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Power BI app reports are present.

describe azure_power_bi_app_reports(app_id: 'APP_ID') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Power BI app reports.

describe azure_power_bi_app_reports(app_id: 'APP_ID') do
  it { should exist }
end
```

## Azure Permissions

This API does not support service principal authentication. Instead, use an Active Directory account access token to access this resource.
Your Active Directory account must be set up with a `Report.Read.All` role on the Azure Power BI workspace you wish to test.
