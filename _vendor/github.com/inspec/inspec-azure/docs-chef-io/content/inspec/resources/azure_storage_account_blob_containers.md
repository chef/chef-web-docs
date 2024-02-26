+++
title = "azure_storage_account_blob_containers Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_storage_account_blob_containers"
identifier = "inspec/resources/azure/azure_storage_account_blob_containers Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_storage_account_blob_containers` InSpec audit resource to test the properties and configuration of Blob Containers within an Azure Storage Account.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

The `resource_group` and `storage_account_name` are required parameters.

```ruby
describe azurerm_storage_account_blob_containers(resource_group: 'RESOURCE_GROUP', storage_account_name: 'PRODUCTION') do
  its('names') { should include 'my-container'}
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`storage_account_name`
: The name of the storage account within the specified resource group.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`locations`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`etags`
: A list of etags defined on the resources.

: **Field**: `etag`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check if a specific container exists

```ruby
describe azurerm_storage_account_blob_containers(resource_group: 'RESOURCE_GROUP', storage_account_name: 'PRODUCTION') do
  its('names') { should include('my-container') }
end
```

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
**If we expect at least one resource to exist on a specified account.**

describe azurerm_storage_account_blob_containers(resource_group: 'RESOURCE_GROUP', storage_account_name: 'PRODUCTION') do
  it { should exist }
end
```

### not_exists

```ruby
**If we expect not to exist containers on a specified account.**

describe azurerm_storage_account_blob_containers(resource_group: 'RESOURCE_GROUP', storage_account_name: 'PRODUCTION') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
