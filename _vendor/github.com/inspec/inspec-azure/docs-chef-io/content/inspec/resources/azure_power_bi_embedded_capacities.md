+++
title = "azure_power_bi_embedded_capacities Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_embedded_capacities"
identifier = "inspec/resources/azure/azure_power_bi_embedded_capacities Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_embedded_capacities` InSpec audit resource to test the properties related to all Azure Power BI Embedded Capacities within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_embedded_capacities` resource block returns all Azure Power BI Embedded Capacities within a project.

```ruby
describe azure_power_bi_embedded_capacities do
  #...
end
```

## Parameters

`account_name`
: The Azure Storage account name.

`dns_suffix`
: The DNS suffix for the Azure Data Lake Storage endpoint.

The following parameters are optional,`account_name` and `dns_suffix`.

## Properties

`ids`
: A list of Power BI dedicated resources.

: **Field**: `id`

`names`
: The names of all the Power BI dedicated resources.

: **Field**: `name`

`locations`
: A location list of all the Power BI dedicated resources.

: **Field**: `location`

`modes`
: A list of all the capacity modes.

: **Field**: `mode`

`provisioningStates`
: A list of all provisioning states.

: **Field**: `provisioningState`

`states`
: The current state of all Power BI dedicated resources.

: **Field**: `state`

`sku_names`
: The SKU name of the Power BI dedicated resource.

: **Field**: `sku_name`

`sku_tiers`
: The SKU tier of the Power BI dedicated resource.

: **Field**: `sku_tier`

`sku_capacities`
: The SKU capacities of the Power BI dedicated resource.

: **Field**: `sku_capacity`

`administration_members`
: A collection of dedicated capacity administrators.

: **Field**: `administration_members`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through Power BI Embedded Capacities by their names

```ruby
azure_power_bi_embedded_capacities.names.each do |name|
  describe azure_power_bi_embedded_capacity(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

### Test to ensure Power BI Embedded Capacities where `sku_capacities` greater than 1

```ruby
describe azure_power_bi_embedded_capacities.where(sku_capacity > 1 ) do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should exist if the filter returns at least one Migrate Assessment in the project and the resource group.

describe azure_power_bi_embedded_capacities do
  it { should exist }
end
```

### not_exists

```ruby
# Should not exist if no Power BI Embedded Capacities are present in the project and the resource group.

describe azure_power_bi_embedded_capacities do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
