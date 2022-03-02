+++
title = "azure_data_lake_storage_gen2_filesystem Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_lake_storage_gen2_filesystem"
identifier = "inspec/resources/azure/azure_data_lake_storage_gen2_filesystem Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_lake_storage_gen2_filesystem` InSpec audit resource to test the properties related to Azure Data Lake Storage Gen2 Filesystem.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name` and `account_name` are required parameters, and `dns_suffix` is an optional parameter.

```ruby
describe azure_data_lake_storage_gen2_filesystem(account_name: 'ACCOUNT_NAME', name: 'FILE_SYSTEM') do
  it  { should exist }
end
```

```ruby
describe azure_data_lake_storage_gen2_filesystem(account_name: 'ACCOUNT_NAME', name: 'FILE_SYSTEM')  do
  it  { should exist }
end
```

## Parameters

`name` _(required)_

: Name of the Azure Date Lake Storage Gen2 to test.

`account_name` _(required)_

: Azure storage account name.

`dns_suffix` _(optional)_

: The DNS suffix for the Azure Data Lake Storage endpoint.

## Properties

`last_modified`
: Last modified timestamp of the resource.

`etag`
: HTTP strong entity tag value.

`x_ms_properties`
: Properties of the filesystem.

`x_ms_namespace_enabled`
: Boolean string for namespace enablement.

`x_ms_default_encryption_scope`
: Default encryption scope.

`x_ms_deny_encryption_scope_override`
: Boolean string for deny encryption scope.

`x_ms_request_id`
: Request ID.

`x_ms_version`
: Version of the API.

`date`
: Date string of the request.


For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storageservices/datalakestoragegen2/filesystem/get-properties) for other properties available.

## Examples

**Test that the Data Lake Storage Gen2 filesystem has namespace enabled.**

```ruby
describe azure_data_lake_storage_gen2_filesystem(account_name: 'ACCOUNT_NAME', name: 'FILE_SYSTEM')  do
  its('x_ms_namespace_enabled') { should eq 'false' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If the Data Lake Storage Gen2 Filesystem is found, it exists
describe azure_data_lake_storage_gen2_filesystem(account_name: 'ACCOUNT_NAME', name: 'FILE_SYSTEM')  do
  it { should exist }
end

# Ff the Data Lake Storage Gen2 Filesystem is not found, it exists
describe azure_data_lake_storage_gen2_filesystem(account_name: 'ACCOUNT_NAME', name: 'FILE_SYSTEM')  do
  it { should_not exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `contributor` role on the subscription and `Storage Blob Data Contributor` role on the ADLS Gen2 Storage Account you wish to test.
