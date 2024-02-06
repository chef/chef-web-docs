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

Use the `azure_storage_account_blob_container` InSpec audit resource to test the properties related to a Blob Container in an Azure Storage account.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group`, `storage_account_name`, and `name` or the `resource_id` are required parameters.

```ruby
describe azure_storage_account_blob_container(resource_group: 'RESOURCE_GROUP', storage_account_name: 'ACCOUNT_NAME', name: 'LOGS')  do
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
: Azure resource group where the targeted resource resides.

`storage_account_name`
: The name of the storage account within the specified resource group.

`name`
: The name of the blob container within the specified storage account.

`blob_container_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group`, `storage_account_name` and `name`
- `resource_group`, `storage_account_name` and `blob_container_name`

## Properties

`properties.deleted`
: Indicates whether the Blob Container was deleted.

`properties.lastModifiedTime`
: Returns the date and time the container was last modified.

`properties.remainingRetentionDays`
: Remaining retention days for soft deleted blob container.

`properties.publicAccess`
: Specifies whether data in the container may be accessed publicly and the level of access. See [here](https://docs.microsoft.com/en-us/rest/api/storagerp/blobcontainers/get#publicaccess) for valid values.

For properties applicable to all resources, such as `type`, `tags`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storagerp/blobcontainers/get#blobcontainer) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test if a Blob Container is deleted

```ruby
describe azure_storage_account_blob_container(resource_group: 'RESOURCE_GROUP', storage_account_name: 'DEFAULT', name: 'LOGS') do
  its('properties.deleted') { should be true }
end
```

### Ensure that the Blob Container is private

```ruby
describe azure_storage_account_blob_container(resource_group: 'RESOURCE_GROUP', storage_account_name: 'PRODUCTION', name: 'LOGS') do
  its('properties') { should have_attributes(publicAccess: 'None') }
end
```

### Loop through resources via 'resource_id'

```ruby
azure_storage_account_blob_containers.(resource_group: 'RESOURCE_GROUP', storage_account_name: 'PRODUCTION').ids.each do |id|
  describe azure_storage_account_blob_container(resource_id: id) do
    its('properties') { should have_attributes(publicAccess: 'None') }
  end
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist.

describe azure_storage_account_blob_container(resource_group: 'RESOURCE_GROUP', storage_account_name: 'PRODUCTION', name: 'LOGS') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the resource to never exist.

describe azure_storage_account_blob_container(resource_group: 'RESOURCE_GROUP', storage_account_name: 'PRODUCTION', name: 'LOGS') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
