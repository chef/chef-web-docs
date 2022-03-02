+++
title = "azure_data_lake_storage_gen2_paths Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_lake_storage_gen2_paths"
identifier = "inspec/resources/azure/azure_data_lake_storage_gen2_paths Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_lake_storage_gen2_paths` InSpec audit resource to test the properties related to all Azure Data Lake Storage Gen2 Filesystem Paths within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_data_lake_storage_gen2_paths` resource block returns all Azure Data Lake Storage Gen2 Filesystem Paths within a project.

```ruby
describe azure_data_lake_storage_gen2_paths(account_name: 'ACCOUNT_NAME', filesystem: 'ADLS FILESYSTEM') do
  #...
end
```

## Parameters

`account_name` _(required)_
: The Azure Storage account name.

`filesystem` _(required)_
: The filesystem identifier.

`dns_suffix` _(optional)_
: The DNS suffix for the Azure Data Lake Storage endpoint.

## Properties

`names`
: Unique names for all the paths in the filesystem.

: **Field**: `name`

`lastModifieds`
: Last modified timestamps of all the paths in the filesystem.

: **Field**: `lastModified`

`eTags`
: A list of eTags for all the paths in the filesystem.

: **Field**: `eTag`

`contentLengths`
: A list of Content Length of all the paths in the filesystem .

: **Field**: `contentLength`


{{% inspec_filter_table %}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storageservices/datalakestoragegen2/path/list) for other properties available.

## Examples

**Loop through Data Lake Storage Gen2 Filesystem Paths by their names.**

```ruby
azure_data_lake_storage_gen2_paths(account_name: 'ACCOUNT_NAME', filesystem: 'ADLS FILESYSTEM').names.each do |name|
  describe azure_data_lake_storage_gen2_path(account_name: 'ACCOUNT_NAME', filesystem: 'ADLS FILESYSTEM', name: name) do
    it { should exist }
  end
end
```

**Test to ensure Data Lake Storage Gen2 Filesystem Paths with file size greater than 2 MB.**

```ruby
describe azure_data_lake_storage_gen2_paths(account_name: 'ACCOUNT_NAME', filesystem: 'ADLS FILESYSTEM').where{ contentLength > 2097152 } do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no Data Lake Storage Gen2 Filesystems are present in the project and in the resource group

describe azure_data_lake_storage_gen2_paths(account_name: 'ACCOUNT_NAME', filesystem: 'ADLS FILESYSTEM') do
  it { should_not exist }
end

# Should exist if the filter returns at least one Migrate Assessment in the project and in the resource group

describe azure_data_lake_storage_gen2_paths(account_name: 'ACCOUNT_NAME', filesystem: 'ADLS FILESYSTEM') do
  it { should exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `contributor` role on the subscription and `Storage Blob Data Contributor` role on the ADLS Gen2 Storage Account you wish to test.