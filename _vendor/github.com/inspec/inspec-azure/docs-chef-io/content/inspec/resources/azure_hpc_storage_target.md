+++
title = "azure_hpc_storage_target Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_hpc_storage_target"
identifier = "inspec/resources/azure/azure_hpc_storage_target Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_hpc_storage_target` InSpec audit resource to test the properties related to an Azure HPC Storage Target.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name`, `cache_name`, and `resource_group` are required parameters.

```ruby
describe azure_hpc_storage_target(resource_group: 'RESOURCE_GROUP', cache_name: 'HPC_CACHE_NAME', name: 'HPC_STORAGE_TARGET_NAME') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.StorageCache/Cache/StorageTarget' }
  its('location')                         { should eq 'East US' }
end
```

```ruby
describe azure_hpc_storage_target(resource_group: 'RESOURCE_GROUP', cache_name: 'HPC_CACHE_NAME', name: 'HPC_STORAGE_TARGET_NAME') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: Name of the Azure HPC Storage Targets to test.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

`cache_name` _(required)_
: Azure HPC Cache name.

## Properties

`id`
: Resource ID of the Storage Target.

`name`
: Name of the Storage Target.

`type`
: Resource type.

`location`
: Region name string.

`properties`
: The properties of the HPC Storage Target.

`properties.blobNfs`
: The properties when the **targetType** is `blobNfs`.

`properties.state`
: The storage target operational state.

`properties.nfs3`
: Properties when the **targetType** is `nfs3`.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storagecache/storage-targets/get#storagetarget) for other properties available.

## Examples

### Test that the HPC Storage Target is ready

```ruby
describe azure_hpc_storage_target(resource_group: 'RESOURCE_GROUP', cache_name: 'HPC_CACHE_NAME', name: 'HPC_STORAGE_TARGET_NAME') do
  its('properties.state') { should eq 'Ready' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If an HPC Storage Target is found, it will exist.

describe azure_hpc_storage_target(resource_group: 'RESOURCE_GROUP', cache_name: 'HPC_CACHE_NAME', name: 'HPC_STORAGE_TARGET_NAME') do
  it { should exist }

```

### not_exists

```ruby
# if HPC Storage Target is not found, it will not exist.

describe azure_hpc_storage_target(resource_group: 'RESOURCE_GROUP', cache_name: 'HPC_CACHE_NAME', name: 'HPC_STORAGE_TARGET_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
