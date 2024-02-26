+++
title = "azure_blob_service Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_blob_service"
identifier = "inspec/resources/azure/azure_blob_service Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_blob_service` Chef InSpec audit resource to test the properties of an Azure Storage account’s Blob service.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_blob_service` resource block identifies an Azure Blob Service by `resource_group`, or the `storage_account_name`.

```ruby
describe azure_blob_service(resource_group: 'RESOURCE_GROUP', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`storage_account_name`
: Name of the Storage account to test.

## Properties

`identity`
: The identity of the managed cluster, if configured. It is a [managed cluster identity object](https://docs.microsoft.com/en-us/rest/api/aks/managedclusters/get#managedclusteridentity).

`id`
: Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}

`name`
: The name of the resource

`properties.automaticSnapshotPolicyEnabled`
: Deprecated in favor of isVersioningEnabled property.

`properties.changeFeed`
: The blob service properties for change feed events.

`properties.containerDeleteRetentionPolicy`
: The blob service properties for container soft delete.

`properties.cors`
: Specifies CORS rules for the Blob service. You can include up to five CorsRule elements in the request. If no CorsRule elements are included in the request body, all CORS rules will be deleted, and CORS will be disabled for the Blob service.

`properties.defaultServiceVersion`
: DefaultServiceVersion indicates the default version to use for requests to the Blob service if an incoming request’s version is not specified. Possible values include version 2008-10-27 and all more recent versions.

`properties.deleteRetentionPolicy`
: The blob service properties for blob soft delete.

`properties.isVersioningEnabled`
: Versioning is enabled if set to true.

`properties.lastAccessTimeTrackingPolicy`
: The blob service property to configure last access time based tracking policy.

`properties.restorePolicy`
: The blob service properties for blob restore policy.

`sku`
: Sku name and tier.

`type`
: The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"

See [Azure's documentation on Blob service](https://learn.microsoft.com/en-us/rest/api/storagerp/blob-services/get-service-properties?tabs=HTTP) for a full list of available properties. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test sku name in the Blob Service

```ruby
describe azure_blob_service(resource_group: 'RESOURCE_GROUP', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  its('sku.name') { should eq 'Standard_RAGRS' }
end
```

### Test that type 

```ruby
describe azure_blob_service(resource_group: 'RESOURCE_GROUP', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  its('type') { should eq 'Microsoft.Storage/storageAccounts/blobServices' }
end
```

See [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_blob_service.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_blob_service(resource_group: 'RESOURCE_GROUP', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  it { should exist }
end
```


```ruby
describe azure_blob_service(resource_group: 'RESOURCE_GROUP', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
