+++
title = "azure_power_bi_app_dashboard Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_app_dashboard"
identifier = "inspec/resources/azure/azure_power_bi_app_dashboard Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_app_dashboard` InSpec audit resource to test the properties of an Azure Power BI app dashboard.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_power_bi_app_dashboard(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID') do
  it  { should exist }
end
```

## Parameters

`app_id` _(required)_
: The app ID.

`dashboard_id` _(required)_
: The app dashboard ID.

## Properties

`id`
: The app ID.

`displayName`
: The dashboard display name.

`embedUrl`
: The dashboard embed URL.

`isReadOnly`
: Is ReadOnly dashboard.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/apps/get-dashboard) for other properties available.

## Examples

### Test that the Power BI app dashboard is read-only

```ruby
describe azure_power_bi_app_dashboard(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID')  do
  its('isReadOnly') { should eq true }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If the Azure Power BI app dashboard is found, it will exist.
describe azure_power_bi_app_dashboard(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID')  do
  it { should exist }
end
```

### not_exists

```ruby
# if the Azure Power BI app dashboard is not found, it will not exist.

describe azure_power_bi_app_dashboard(app_id: 'APP_ID', dashboard_id: 'DASHBOARD_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

This API does not support service principal authentication. Instead, use the Active Directory (AD) account access token to access this resource.
Your AD account must be set up with a `Dashboard.Read.All` role on the Azure Power BI workspace you wish to test.
