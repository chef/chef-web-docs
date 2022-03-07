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

Use the `azure_virtual_machine_disk` InSpec audit resource to test properties and configuration of an Azure disk.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_virtual_machine_disk(resource_group: 'inspec-resource-group-9', name: 'example_disk') do
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
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: Name of the disk to test. `MyDisk`.

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

For properties applicable to all resources, such as `type`, `name`, `location`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/compute/disks/get#disk) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test If a Disk is Referenced with a Valid Name.**

```ruby
describe azure_virtual_machine_disk(resource_group: 'my-rg', name: 'os_disk') do
  it { should exist }
end
```
**Test If a Disk is Referenced with an Invalid Name.**

```ruby
describe azure_virtual_machine_disk(resource_group: 'my-rg', name: 'i-dont-exist') do
  it { should_not exist }
end
```    
**Test the VM that the Disk is Attached.**

```ruby
describe azure_virtual_machine_disk(resource_group: 'my-rg', name: 'os_disk') do
  its('managedBy') { should cmp '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/{vmName}' }
end
```   
**Test the Type of Key Used to Encrypt the Data at Rest.**

```ruby
describe azure_virtual_machine_disk(resource_group: 'my-rg', name: 'os_disk') do
  its('rest_encryption_type') { should cmp 'EncryptionAtRestWithPlatformKey' }
end
```        
**Test a Disk's Size in Bytes.**

```ruby
describe azure_virtual_machine_disk(resource_group: 'my-rg', name: 'os_disk') do
  its('properties.diskSizeBytes') { should cmp 136367308800 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### attached

Test if a disk is attached to a virtual machine.
```ruby
describe azure_virtual_machine_disk(resource_group: 'my-rg', name: 'os_disk') do
  it { should be_attached }
end
```

### exists

```ruby
# If we expect a resource to always exist

describe azure_virtual_machine_disk(resource_group: 'my-rg', name: 'os_disk') do
  it { should exist }
end
# If we expect a resource to never exist

describe azure_virtual_machine_disk(resource_group: 'my-rg', name: 'os_disk') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
