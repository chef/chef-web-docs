+++
title = "azure_virtual_machines Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_machines"
identifier = "inspec/resources/azure/azure_virtual_machines Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_machines` InSpec audit resource to test properties related to virtual machines for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_virtual_machines` resource block returns all Azure virtual machines, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_virtual_machines do
  #...
end
```
or
```ruby
describe azure_virtual_machines(resource_group: 'my-rg') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`os_disks`
: A list of OS disk names for all the virtual machines.

: **Field**: `os_disk`

`data_disks`
: A list of data disks for all the virtual machines.

: **Field**: `data_disks`

`vm_names`
: A list of all the virtual machine names.

: **Field**: `name`

`platforms`
: A list of virtual machine operation system platforms. Supported values are `windows` and `linux`.

: **Field**: `platform`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

{{% inspec_filter_table %}}

## Examples

**Test If Any Virtual Machines Exist in the Resource Group.**

```ruby
describe azure_virtual_machines(resource_group: 'MyResourceGroup') do
  it { should exist }
end
```
**Filters Based on Platform.**

```ruby
describe azure_virtual_machines(resource_group: 'MyResourceGroup').where(platform: 'windows') do
  it { should exist }
end
```   
**Loop through Virtual Machines by Their Ids  .**

```ruby
azure_virtual_machines.ids.each do |id|
  describe azure_virtual_machine(resource_id: id) do
    it { should exist }
  end
end  
``` 
**Test If There are Windows Virtual Machines     .**

```ruby
describe azure_virtual_machines(resource_group: 'MyResourceGroup').where(platform: 'windows') do
  it { should exist }
end
```    
**Test that There are Virtual Machines that Includes a Certain String in their Names (Client Side Filtering)   .**

```ruby
describe azure_virtual_machines(resource_group: 'MyResourceGroup').where { name.include?('WindowsVm') } do
  it { should exist }
end
```    
**Test that There are Virtual Machine that Includes a Certain String in their Names (Server Side Filtering via Generic Resource - Recommended)   .**

```ruby
describe azure_generic_resources(resource_group: 'MyResourceGroup', resource_provider: 'Microsoft.Compute/virtualMachine', substring_of_name: 'WindowsVm') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no virtual machines are in the resource group

describe azure_virtual_machines(resource_group: 'MyResourceGroup') do
  it { should_not exist }
end

# Should exist if the filter returns a single virtual machine

describe azure_virtual_machines(resource_group: 'MyResourceGroup').where(platform: 'windows') do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
