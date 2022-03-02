+++
title = "azure_resource_health_availability_statuses Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_resource_health_availability_statuses"
identifier = "inspec/resources/azure/azure_resource_health_availability_statuses Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_resource_health_availability_statuses` InSpec audit resource to test properties related to all Azure Availability Statuses for the subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_resource_health_availability_statuses` resource block returns all Azure Availability Statuses within a Subscription.
```ruby
describe azure_resource_health_availability_statuses do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the Azure Resource Manager Identity for the availabilityStatuses resources.

: **Field**: `id`

`names`
: current.

: **Field**: `name`

`types`
: Microsoft.ResourceHealth/AvailabilityStatuses.

: **Field**: `type`

`properties`
: A list of Properties of availability state.

: **Field**: `properties`

`locations`
: A list of Azure Resource Manager geo locations of the resource.

: **Field**: `location`

{{% inspec_filter_table %}}

## Examples

**Loop through availability statuses by resource ID.**

```ruby
azure_resource_health_availability_statuses.ids.each do |id|
  describe azure_resource_health_availability_status(resource_id: id) do
    it { should exist }
  end
end
```

**Test that there are availability statuses that have an `Available` availability state.**

```ruby
describe azure_resource_health_availability_statuses.where{ properties.select{|prop| prop.availabilityState == 'Available' } } do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no availability statuses are present in the subscription

describe azure_resource_health_availability_statuses do
  it { should_not exist }
end

# Should exist if the filter returns at least one availability status in the subscription

describe azure_resource_health_availability_statuses do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
