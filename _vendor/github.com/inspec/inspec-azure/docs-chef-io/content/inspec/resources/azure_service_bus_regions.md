+++
title = "azure_service_bus_regions Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_bus_regions"
identifier = "inspec/resources/azure/azure_service_bus_regions Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_bus_regions` InSpec audit resource to test the properties related to all Azure Service Bus regions.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_service_bus_regions` resource block returns all Azure Service Bus regions.

```ruby
describe azure_service_bus_regions(sku: 'SKU_NAME') do
  #...
end
```

## Parameters

`sku` _(required)_
: The sku type.

## Properties

`ids`
: A list of resource IDs.

: **Field**: `id`

`names`
: A list of resource names.

: **Field**: `name`

`types`
: A list of the resource types.

: **Field**: `type`

`properties`
: A list of properties for all the Service Bus regions.

: **Field**: `properties`

`locations`
: A list of the resource locations.

: **Field**: `location`

`codes`
: A list of region codes.

: **Field**: `code`

`fullNames`
: A list of full names of the regions.

: **Field**: `fullName`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that there are Service Bus regions that are successfully provisioned

```ruby
describe azure_service_bus_regions(sku: 'SKU_NAME').where(code: 'Central US') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Service Bus regions are present.

describe azure_service_bus_regions(sku: 'SKU_NAME') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Service Bus region.

describe azure_service_bus_regions(sku: 'SKU_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
