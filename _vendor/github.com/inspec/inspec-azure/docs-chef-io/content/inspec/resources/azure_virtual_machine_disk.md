+++
title = "azure_virtual_machine_disk Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_machine_disk"
identifier = "inspec/resources/azure/azure_virtual_machine_disk Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_machine_disk` InSpec audit resource to test the properties and configuration of an Azure disk.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'EXAMPLE_DISK') do
  it { should exist }
end
```

```ruby
describe azure_virtual_machine_disk(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/disks/{diskName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: Name of the disk to test.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`

## Properties

`encryption_enabled<superscript>*</superscript>`
: Indicates whether the `properties.EncryptionSettingsCollection.enabled` is `true` or `false`. Note that this will return `nil` unless the encryption status is defined on the resource explicitly.

`rest_encryption_type`
: The type of key used to encrypt the data of the disk.

`sku`
: The SKU (pricing tier) of the disk.

`managedBy`
: A relative URI containing the ID of the VM that has the disk attached.

`properties.diskSizeBytes`
: The size of the disk in bytes.

<superscript>*</superscript> The disk can still be encrypted at rest with a platform key, even though the `encryption_enabled` is `nil`. It is recommended to see [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/disk-encryption) for more details on disk encryption.

For properties applicable to all resources, such as `type`, `name`, `location`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/compute/disks/get#disk) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test if a disk is referenced with a valid name

```ruby
describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'OS_DISK') do
  it { should exist }
end
```

### Test if a disk is referenced with an invalid name

```ruby
describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'i-dont-exist') do
  it { should_not exist }
end
```

### Test the VM that the disk is attached

```ruby
describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'OS_DISK') do
  its('managedBy') { should cmp '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/{vmName}' }
end
```

### Test the key type used to encrypt the data at rest

```ruby
describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'OS_DISK') do
  its('rest_encryption_type') { should cmp 'EncryptionAtRestWithPlatformKey' }
end
```

### Test a disk's size in bytes

```ruby
describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'OS_DISK') do
  its('properties.diskSizeBytes') { should cmp 136367308800 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### attached

Test if a disk is attached to a virtual machine.

```ruby
describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'OS_DISK') do
  it { should be_attached }
end
```

### exists

```ruby
# If we expect a resource to always exist.

describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'OS_DISK') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_virtual_machine_disk(resource_group: 'RESOURCE_GROUP', name: 'OS_DISK') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
