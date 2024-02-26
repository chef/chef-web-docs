+++
title = "azure_hpc_caches Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_hpc_caches"
identifier = "inspec/resources/azure/azure_hpc_caches Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_hpc_caches` InSpec audit resource to test the properties related to all Azure HPC Caches.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_hpc_caches` resource block returns all Azure HPC Caches.

```ruby
describe azure_hpc_caches do
  #...
end
```

## Parameters

`resource_group` _(optional)_
: Azure resource group where the targeted resource resides.

## Properties

`ids`
: A list of resource IDs.

**Field**: `id`

`names`
: A list of HPC Cache names.

**Field**: `name`

`types`
: A list of the HPC Cache types.

**Field**: `type`

`properties`
: A list of Properties for all the HPC Caches.

**Field**: `properties`

`locations`
: A list of the resource locations.

**Field**: `location`

`cacheSizeGBs`
: A list of the sizes of the HPC Cache.

**Field**: `cacheSizeGB`

`subnets`
: A list of subnets used for the HPC Cache.

**Field**: `subnet`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through HPC Caches by their names

```ruby
azure_hpc_caches.names.each do |name|
  describe azure_hpc_cache(resource_group: 'RESOURCE_GROUP', cache_name: 'HPC_CACHE_NAME', name: name) do
    it { should exist }
  end
end
```

### Test to ensure that there are provisioned HPC Caches

```ruby
describe azure_hpc_caches.where(provisioningState: 'SUCCEEDED') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no HPC Caches are present.

describe azure_hpc_caches do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one HPC Caches.

describe azure_hpc_caches do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
