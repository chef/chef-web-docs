+++
title = "azure_virtual_machine_disks Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_machine_disks"
identifier = "inspec/resources/azure/azure_virtual_machine_disks Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_machine_disks` InSpec audit resource to test the properties related to disks for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_virtual_machine_disks` resource block returns all disks within a resource group (if provided) or an entire subscription.

```ruby
describe azure_virtual_machine_disks do
  it { should exist }
end
```

Or

```ruby
describe azure_virtual_machine_disks(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`attached`
: Indicates whether the disk is currently mounted to a running VM.

: **Field**: `attached`

`resource_group`
: A list of resource groups for all the disks.

: **Field**: `resource_group`

`names`
: A list of names for all the disks.

: **Field**: `name`

`locations`
: A list of locations of the disks.

: **Field**: `location`

`properties`
: A list of properties of the disks.

: **Field**: `properties`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Filter the attached disks

```ruby
describe azure_virtual_machine_disks(resource_group: 'RESOURCE_GROUP').where(attached: true) do
  it { should exist }
  its('count') { should eq 3}
end
```

### Loop through disks by their IDs

```ruby
azure_virtual_machine_disks.ids.each do |id|
  describe azure_virtual_machine_disk(resource_id: id) do
    it { should exist }
  end
end
```

### Test that there are disks that include a certain string in their names (Client Side Filtering)

```ruby
describe azure_virtual_machine_disks(resource_group: 'RESOURCE_GROUP').where { name.include?('Windows') } do
  it { should exist }
end
```

### Test that there are disks that include a certain string in their names (Server Side Filtering via Generic Resource - Recommended)

```ruby
describe azure_generic_resources(resource_provider: 'Microsoft.Compute/disks', substring_of_name: 'Windows') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no disks are in the resource group.

describe azure_virtual_machine_disks(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns a single virtual machine.

describe azure_virtual_machine_disks.where(attached: true ) do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
