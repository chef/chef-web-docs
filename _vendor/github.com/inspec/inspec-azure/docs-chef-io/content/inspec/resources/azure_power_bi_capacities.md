+++
title = "azure_power_bi_app_capacities Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_app_capacities"
identifier = "inspec/resources/azure/azure_power_bi_app_capacities Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_app_capacities` InSpec audit resource to test the properties related to all Azure Power BI capacities.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_power_bi_app_capacities` resource block returns all Azure Power BI capacities.

```ruby
describe azure_power_bi_app_capacities do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: List of all Power BI capacity IDs.

: **Field**: `id`

`displayNames`
: List of all the Power BI capacity names.

: **Field**: `displayName`

`admins`
: An array of capacity admins.

: **Field**: `admin`

`skus`
: List of all capacity SKUs.

: **Field**: `sku`

`states`
: List of the capacity states.

: **Field**: `state`

`regions`
: List of the Azure regions where the capacity is provisioned.

: **Field**: `region`

`capacityUserAccessRights`
: List of access rights user has on the capacity.

: **Field**: `capacityUserAccessRight`

{{% inspec_filter_table %}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/capacities/get-capacities) for other properties available.

## Examples

**Test to ensure Power BI capacities are active.**

```ruby
describe azure_power_bi_app_capacities.where(state: 'Active') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

Use `should` to test that the entity exists.

```ruby
describe azure_power_bi_app_capacities do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe azure_power_bi_app_capacities do
  it { should_not exist }
end
```

## Azure Permissions

This API does not support service principal authentication. Instead, use an Active Directory account access token to access this resource.
Your Active Directory account must be set up with a `Capacity.Read.All` role on the Azure Power BI workspace that you wish to test.
