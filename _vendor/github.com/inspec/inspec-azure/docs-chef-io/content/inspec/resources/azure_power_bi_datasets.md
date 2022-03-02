+++
title = "azure_power_bi_datasets Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_datasets"
identifier = "inspec/resources/azure/azure_power_bi_datasets Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_datasets` InSpec audit resource to test the properties of all Azure Power BI datasets.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_power_bi_datasets` resource block returns all Azure Power BI datasets.

```ruby
describe azure_power_bi_datasets do
  #...
end
```

## Parameters

`group_id` _(optional)_

: The workspace ID.

## Properties

`ids`
: List of all Power BI dataset IDs.

: **Field**: `id`

`names`
: List of all the Power BI dataset names.

: **Field**: `name`

`addRowsAPIEnableds`
: List of boolean flags which describes whether the dataset allows adding new rows.

: **Field**: `addRowsAPIEnabled`

`isRefreshables`
: List of boolean flags that represent refreshable parameter of datasets.

: **Field**: `isRefreshable`

`isEffectiveIdentityRequireds`
: List of boolean flags that represent effective identity.

: **Field**: `isEffectiveIdentityRequired`

`isEffectiveIdentityRolesRequireds`
: List of boolean flags that describes whether RLS is defined inside the PBIX file.

: **Field**: `isEffectiveIdentityRolesRequired`

`isOnPremGatewayRequireds`
: List of boolean flags that describes whether dataset requires an On-premises Data Gateway.

: **Field**: `isOnPremGatewayRequired`

{{% inspec_filter_table %}}

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/datasets/get-datasets) for other properties available.

## Examples

**Test to ensure Power BI dataset is refreshable.**

```ruby
describe azure_power_bi_datasets.where(isRefreshable: true) do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no Power BI datasets are present

describe azure_power_bi_datasets do
  it { should_not exist }
end
# Should exist if the filter returns at least one Power BI datasets

describe azure_power_bi_datasets do
  it { should exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Dataset.Read.All` role on the Azure Power BI dataset you wish to test.
