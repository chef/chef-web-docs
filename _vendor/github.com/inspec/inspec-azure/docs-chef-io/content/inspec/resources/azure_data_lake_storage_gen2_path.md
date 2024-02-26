+++
title = "azure_data_lake_storage_gen2_path Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_lake_storage_gen2_path"
identifier = "inspec/resources/azure/azure_data_lake_storage_gen2_path Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_lake_storage_gen2_path` InSpec audit resource to test the properties related to Azure Data Lake Storage Gen2 Filesystem.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_data_lake_storage_gen2_path(account_name: 'ACCOUNT_NAME', filesystem: 'FILE_SYSTEM', name: 'PATHNAME') do
  it  { should exist }
end
```

```ruby
describe azure_data_lake_storage_gen2_path(account_name: 'ACCOUNT_NAME', filesystem: 'FILE_SYSTEM', name: 'PATH')  do
  it  { should exist }
end
```

## Parameters

`filesystem` _(required)_
: The filesystem identifier.

`account_name` _(required)_
: Azure Storage account name.

`name` _(required)_
: The file or directory path.

`dns_suffix` _(optional)_
: The DNS suffix for the Azure Data Lake Storage endpoint.

## Properties

`last_modified`
: Last modified timestamp of the resource.

`etag`
: HTTP strong entity tag value.

`x_ms_properties`
: Properties of the filesystem.

`x_ms_request_id`
: Request ID.

`x_ms_version`
: API version.

`date`
: Date string of the request.

`content_length`
: Content-Length of the file.

`content_type`
: Content type.

`content_md5`
: MD5 of the content uploaded.

`accept_ranges`
: File size described measurement. `bytes`.

`x_ms_resource_type`
: Resource type of the uploaded. `file`.

`x_ms_lease_state`
: If the file is available or not.

`x_ms_lease_status`
: Status of the lease.

`x_ms_server_encrypted`
: If the file is encrypted on the server.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storageservices/datalakestoragegen2/path/get-properties) for other properties available.

## Examples

### Test that the Data Lake Storage Gen 2 Filesystem Path is server encrypted

```ruby
describe azure_data_lake_storage_gen2_path(account_name: 'ACCOUNT_NAME', filesystem: 'FILE_SYSTEM', name: 'PATHNAME')  do
  its('x_ms_server_encrypted') { should eq 'true' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If the Data Lake Storage Gen 2 Filesystem is found, it will exist.

describe azure_data_lake_storage_gen2_path(account_name: 'ACCOUNT_NAME', filesystem: 'FILE_SYSTEM', name: 'PATHNAME')  do
  it { should exist }
end
```

### not_exists

```ruby
# if the Data Lake Storage Gen 2 Filesystem is not found, it will not exist.

describe azure_data_lake_storage_gen2_path(account_name: 'ACCOUNT_NAME', filesystem: 'FILE_SYSTEM', name: 'PATHNAME')  do
  it { should_not exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `contributor` role on the subscription and `Storage Blob Data Contributor` role on the **ADLS Gen2 Storage Account** you wish to test.
