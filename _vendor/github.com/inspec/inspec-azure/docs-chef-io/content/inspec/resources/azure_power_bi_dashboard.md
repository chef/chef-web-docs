+++
title = "azure_power_bi_dashboard Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_dashboard"
identifier = "inspec/resources/azure/azure_power_bi_dashboard Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_dashboard` InSpec audit resource to test the properties related to Azure Power BI Dashboard.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`dashboard_id` is a required parameter and `group_id` is an optional parameter.

```ruby
describe azure_power_bi_dashboard(group_id: 'GROUP_ID', dashboard_id: 'dashboard_ID') do
  it  { should exist }
end
```

## Parameters

`dashboard_id` _(required)_

: The dashboard ID.

`group_id` _(optional)_

: The workspace ID.

## Properties

`id`
: Power BI dashboard ID.

`displayName`
: The dashboard display name.

`embedUrl`
: The dashboard embed url.

`isReadOnly`
: Is ReadOnly dashboard.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/dashboards/get-dashboard) for other properties available.

## Examples

**Test that the Power BI Dashboard is read only.**

```ruby
describe azure_power_bi_dashboard(group_id: 'GROUP_ID', dashboard_id: 'DASHBOARD_ID')  do
  its('isReadOnly') { should eq 'true' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# Should exist if the Power BI dashboard is present in the group

describe azure_power_bi_dashboard(group_id: 'GROUP_ID', dashboard_id: 'dashboard_ID')  do
  it { should exist }
end

# Should not exist if the Power BI dashboard is not present in the group

describe azure_power_bi_dashboard(group_id: 'GROUP_ID', dashboard_id: 'dashboard_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Dashboard.Read.All` role on the Azure Power BI Workspace you wish to test.
