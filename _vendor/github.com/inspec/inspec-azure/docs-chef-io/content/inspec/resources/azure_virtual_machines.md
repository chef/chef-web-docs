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

Use the `azure_virtual_machines` InSpec audit resource to test the properties related to virtual machines for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_virtual_machines` resource block returns all Azure virtual machines within a resource group (if provided) or an entire subscription.

```ruby
describe azure_virtual_machines do
  #...
end
```

Or

```ruby
describe azure_virtual_machines(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource IDs.

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

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test if any virtual machines exist in the resource group

```ruby
describe azure_virtual_machines(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

**Filters Based on Platform.**

```ruby
describe azure_virtual_machines(resource_group: 'RESOURCE_GROUP').where(platform: 'windows') do
  it { should exist }
end
```

### Loop through virtual machines by their IDs

```ruby
azure_virtual_machines.ids.each do |id|
  describe azure_virtual_machine(resource_id: id) do
    it { should exist }
  end
end
```

### Test if there are Windows virtual machines

```ruby
describe azure_virtual_machines(resource_group: 'RESOURCE_GROUP').where(platform: 'windows') do
  it { should exist }
end
```

### Test that there are virtual machines that includes a certain string in their names (Client Side Filtering)

```ruby
describe azure_virtual_machines(resource_group: 'MyResourceGroup').where { name.include?('WindowsVm') } do
  it { should exist }
end
```

### Test that there are virtual machine that includes a certain string in their names (Server Side Filtering via Generic Resource - Recommended)

```ruby
describe azure_generic_resources(resource_group: 'RESOURCE_GROUP', resource_provider: 'Microsoft.Compute/virtualMachine', substring_of_name: 'WindowsVm') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no virtual machines are in the resource group.

describe azure_virtual_machines(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns a single virtual machine.

describe azure_virtual_machines(resource_group: 'RESOURCE_GROUP').where(platform: 'windows') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
