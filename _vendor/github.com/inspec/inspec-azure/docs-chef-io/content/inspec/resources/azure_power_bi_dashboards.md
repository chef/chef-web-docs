+++
title = "azure_power_bi_dashboards Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_dashboards"
identifier = "inspec/resources/azure/azure_power_bi_dashboards Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_dashboards` InSpec audit resource to test the properties related to all AzurePower BI Dashboards within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_dashboards` resource block returns all AzurePower BI Dashboards within a group.

```ruby
describe azure_power_bi_dashboards do
  #...
end
```

```ruby
describe azure_power_bi_dashboards(group_id: 'GROUP_ID') do
  #...
end
```

## Parameters

`group_id` _(optional)_
: The workspace ID.

## Properties

`ids`
: List of all dashboard IDs.

: **Field**: `id`

`displayNames`
: List of all the dashboard display names.

: **Field**: `displayName`

`embedUrls`
: List of all dashboard embed URLs.

: **Field**: `embedUrl`

`isReadOnly`
: List of all read-only dashboards.

: **Field**: `isReadOnlies`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/dashboards/get-dashboards) for other properties available.

## Examples

### Loop throughPower BI Dashboards by their IDs

```ruby
azure_power_bi_dashboards.ids.each do |id|
  describe azure_power_bi_dashboard(dashboard_id: id) do
    it { should exist }
  end
end
```

### Test to ensure all Power BI dashboards are ready-only

```ruby
describe azure_power_bi_dashboards.where(isReadOnly: true) do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Power BI dashboards are present in the group.

describe azure_power_bi_dashboards do
  it { should_not exist }
end

# Should exist if the filter returns at least one Power BI dashboard in the group.

describe azure_power_bi_dashboards do
  it { should exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `dashboard.Read.All` role on the Azure Power BI Workspace you wish to test.
