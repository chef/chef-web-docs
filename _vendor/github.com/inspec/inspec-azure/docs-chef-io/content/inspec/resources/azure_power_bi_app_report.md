+++
title = "azure_power_bi_app_report Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_app_report"
identifier = "inspec/resources/azure/azure_power_bi_app_report Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_app_report` InSpec audit resource to test the properties related to an Azure Power BI app report.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_power_bi_app_report(app_id: 'APP_ID', report_id: 'REPORT_ID') do
  it  { should exist }
end
```

## Parameters

`app_id` _(required)_

: The app ID.

`report_id` _(required)_

: The app report ID.

## Properties

`id`
: The report ID.

`appId`
: The app ID.

`embedUrl`
: The report embed URL.

`datasetId`
: The dataset ID.

`name`
: The report name.

`webUrl`
: The report web URL.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/apps/get-report) for other properties available.

## Examples

### Test that the Power BI app report is paginated and embed URL is present

```ruby
describe azure_power_bi_app_report(app_id: 'APP_ID', report_id: 'REPORT_ID')  do
  its('reportType') { should eq 'PaginatedReport' }
  its('embedUrl') { should_not be_empty }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

Use `should` to test that the entity exists.

```ruby
describe azure_power_bi_app_report(app_id: 'APP_ID', report_id: 'REPORT_ID')  do
  it { should exist }
end
```

### not_exists

Use `should_not` to test that the entity does not exist.

```ruby
describe azure_power_bi_app_report(app_id: 'APP_ID', report_id: 'REPORT_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

This API does not support service principal authentication. Instead, use an Active Directory account access token to access this resource.
Your Active Directory account must be set up with a `Report.Read.All` role on the Azure Power BI workspace you wish to test.
