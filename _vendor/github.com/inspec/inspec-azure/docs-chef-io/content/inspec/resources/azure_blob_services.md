+++
title = "azure_blob_services Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_blob_services"
identifier = "inspec/resources/azure/azure_blob_services Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_blob_services` Chef InSpec audit resource to test the properties and configuration of multiple Azure storage accounts' Blob services.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_blob_services` resource block returns all Azure Blob Service, either within a Resource Group (if provided) or within an entire Subscription.

```ruby
describe azure_blob_services(resource_group: 'RESOURCE_GROUP_NAME', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`storage_account_name`
: Name of the Storage account to test.

## Properties

`ids`
: Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}

: **Field**: `id`

`names`
: The name of the resource.

: **Field**: `name`

`properties`
: The property of the resource.

: **Field**: `properties`

`skus`
: Sku name and tier.

: **Field**: `sku`

`types`
: The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"

: **Field**: `type`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

See [Azure's documentation on Blob services](https://learn.microsoft.com/en-us/rest/api/storagerp/blob-services/list?tabs=HTTP) for a full list of available properties.

## Examples

### Test that an example Resource Group has the named storage account

```ruby
describe azure_blob_services(resource_group: 'RESOURCE_GROUP_NAME', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  its('names') { should include('STORAGE_ACCOUNT_NAME') }
end
```

See [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_blob_services.rb) for more examples.

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_blob_services(resource_group: 'RESOURCE_GROUP_NAME', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  it { should exist }
end
```

```ruby
describe azure_blob_services(resource_group: 'RESOURCE_GROUP_NAME', storage_account_name: 'STORAGE_ACCOUNT_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
