+++
title = "azure_storage_account_blob_container Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_storage_account_blob_container"
identifier = "inspec/resources/azure/azure_storage_account_blob_container Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_storage_account_blob_container` InSpec audit resource to test properties related to a Blob Container in an Azure Storage Account.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group`, `storage_account_name` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_storage_account_blob_container(resource_group: 'rg', storage_account_name: 'production', name: 'logs')  do
  it { should exist }
end
```
```ruby
describe azure_storage_account_blob_container(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}')  do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`storage_account_name`
: The name of the storage account within the specified resource group. `accountName`.

`name`
: The name of the blob container within the specified storage account. `containerName`.

`blob_container_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/blobServices/default/containers/{containerName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group`, `storage_account_name` and `name`
- `resource_group`, `storage_account_name` and `blob_container_name`

## Properties

`properties.deleted`
: Indicates whether the blob container was deleted.

`properties.lastModifiedTime`
: Returns the date and time the container was last modified.

`properties.remainingRetentionDays`
: Remaining retention days for soft deleted blob container.

`properties.publicAccess`
: Specifies whether data in the container may be accessed publicly and the level of access. See [here](https://docs.microsoft.com/en-us/rest/api/storagerp/blobcontainers/get#publicaccess) for valid values.

For properties applicable to all resources, such as `type`, `tags`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storagerp/blobcontainers/get#blobcontainer) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test if a Blob Container is Deleted.**

```ruby
describe azure_storage_account_blob_container(resource_group: 'rg', storage_account_name: 'default', name: 'logs') do
  its('properties.deleted') { should be true }
end
```
**Ensure that the Blob Container is private.**

```ruby
describe azure_storage_account_blob_container(resource_group: 'rg', storage_account_name: 'production', name: 'logs') do
  its('properties') { should have_attributes(publicAccess: 'None') }
end
```
**Loop through Resources via `resource_id`.**

```ruby
azure_storage_account_blob_containers.(resource_group: 'rg', storage_account_name: 'production').ids.each do |id|
  describe azure_storage_account_blob_container(resource_id: id) do
    its('properties') { should have_attributes(publicAccess: 'None') }
  end
end 
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist

describe azure_storage_account_blob_container(resource_group: 'rg', storage_account_name: 'production', name: 'logs') do
  it { should exist }
end

# If we expect the resource to never exist

describe azure_storage_account_blob_container(resource_group: 'rg', storage_account_name: 'production', name: 'logs') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
