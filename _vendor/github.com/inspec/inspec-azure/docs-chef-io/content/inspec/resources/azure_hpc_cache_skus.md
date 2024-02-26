+++
title = "azure_hpc_cache_skus Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_hpc_cache_skus"
identifier = "inspec/resources/azure/azure_hpc_cache_skus Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_hpc_cache_skus` InSpec audit resource to test the properties related to all Azure HPC Cache SKUs.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_hpc_cache_skus` resource block returns all Azure HPC Cache SKUs.

```ruby
describe azure_hpc_cache_skus do
  #...
end
```

## Parameters

## Properties

`resourceTypes`
: A resource types list where the SKU applies.

**Field**: `resourceType`

`names`
: A list of SKU names.

**Field**: `name`

`sizes`
: A list of the SKU sizes.

**Field**: `size`

`tiers`
: A tiers list of VM in a scale set.

**Field**: `tier`

`kind`
: The supported kind list of resources.

**Field**: `kind`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Ensure that there are Standard tier HPC Cache SKUs

```ruby
describe azure_hpc_cache_skus.where(tier: 'STANDARD') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no HPC Cache SKUs are present.

describe azure_hpc_cache_skus do
  it { should_not exist }
end
# Should exist if the filter returns at least one HPC Cache SKUs.

describe azure_hpc_cache_skus do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
