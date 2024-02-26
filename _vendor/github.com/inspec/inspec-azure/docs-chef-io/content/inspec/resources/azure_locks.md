+++
title = "azure_locks Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_locks"
identifier = "inspec/resources/azure/azure_locks Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_locks` InSpec audit resource to test the properties and configuration of all Management Locks for an Azure resource or any level below it.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_locks` resource block returns all Management Locks within a resource group (if provided) or the entire subscription.

```ruby
describe azure_locks do
  it { should exist }
end
```

Or

```ruby
describe azure_locks(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

Also, at resource level test can be done by providing the following identifiers: `resource_group`, `resource_name`, and `resource_type` or the `resource_id`.

```ruby
describe azure_locks(resource_group: 'RESOURCE_GROUP', resource_name: 'VM_NAME`, resource_type: 'Microsoft.Compute/virtualMachines') do
  it { should exist }
end
```

Or

```ruby
describe azure_locks(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/{vmName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`resource_name`
: Name of the Azure resource on which the Management Locks are being tested.

`resource_type`
: Type of the Azure resource on which the Management Locks are being tested.

`resource_id`
: The unique resource ID of the Azure resource on which the Management Locks are being tested.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group`, `resource_name` and `resource_type`
- `resource_group`
- None for a subscription level test.

## Properties

`ids`
: A list of the unique resource IDs of the Management Locks.

: **Field**: `id`

`names`
: A list of names of all the Management Locks being interrogated.

: **Field**: `name`

`properties`
: A list of properties for all the Management Locks being interrogated.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check if a specific Management Lock is present for a resource

```ruby
describe azure_locks(resource_group: 'RESOURCE_GROUP', resource_name: 'VM_NAME', resource_type: 'Microsoft.Compute/virtualMachines') do
  its('names')  { should include 'production_agents' }
end
```

### Filters the results to include only those Management Locks that have the specific name

```ruby
describe azure_locks.where{ name.include?('production') } do
  it { should exist }
end
```

### Loop through all virtual machines to test if they have Management Locks defined

```ruby
azure_virtual_machines.ids.each do |id|
  describe azure_locks(resource_id: id) do
    it { should exist }
  end
end
``` 

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
describe azure_locks(resource_group: 'RESOURCE_GROUP', resource_name: 'VM_NAME', resource_type: 'Microsoft.Compute/virtualMachines') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
