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

Use the `azure_resource_health_availability_statuses` InSpec audit resource to test the properties related to all Azure Availability Statuses for the subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_resource_health_availability_statuses` resource block returns all Azure Availability Statuses within a subscription.

```ruby
describe azure_resource_health_availability_statuses do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the Azure Resource Manager Identity for the `availabilityStatuses` resources.

: **Field**: `id`

`names`
: current.

: **Field**: `name`

`types`
: `Microsoft.ResourceHealth/AvailabilityStatuses`.

: **Field**: `type`

`properties`
: A list of Properties of availability state.

: **Field**: `properties`

`locations`
: A list of Azure Resource Manager geo locations of the resource.

: **Field**: `location`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through availability statuses by resource ID

```ruby
azure_resource_health_availability_statuses.ids.each do |id|
  describe azure_resource_health_availability_status(resource_id: id) do
    it { should exist }
  end
end
```

### Test that there are availability statuses that have an 'Available' availability state

```ruby
describe azure_resource_health_availability_statuses.where{ properties.select{|prop| prop.availabilityState == 'Available' } } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no availability statuses are present in the subscription.

describe azure_resource_health_availability_statuses do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one availability status in the subscription.

describe azure_resource_health_availability_statuses do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
