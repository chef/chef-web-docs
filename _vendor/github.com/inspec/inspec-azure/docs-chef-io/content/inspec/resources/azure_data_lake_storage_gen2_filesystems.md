+++
title = "azure_data_lake_storage_gen2_filesystems Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_lake_storage_gen2_filesystems"
identifier = "inspec/resources/azure/azure_data_lake_storage_gen2_filesystems Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_lake_storage_gen2_filesystems` InSpec audit resource to test the properties related to all Azure Data Lake Storage Gen2 Filesystems within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_data_lake_storage_gen2_filesystems` resource block returns all Azure Data Lake Storage Gen2 filesystems within a project.

```ruby
describe azure_data_lake_storage_gen2_filesystems(account_name: 'ACCOUNT_NAME') do
  #...
end
```

## Parameters

`account_name` _(required)_

: The Azure Storage account name.

`dns_suffix` _(optional)_

: The DNS suffix for the Azure Data Lake Storage endpoint.

## Properties

`names`
: Unique names for all Azure Storage Account Filesystems.

: **Field**: `name`

`lastModifieds`
: Last modified timestamps of Azure Storage Account Filesystem.

: **Field**: `lastModified`

`eTags`
: A list of eTags for all the Azure Storage Account Filesystems.

: **Field**: `eTag`

`DefaultEncryptionScopes`
: A list of all Encryption scopes of the ADLS Filesystems.

: **Field**: `DefaultEncryptionScope`

`DenyEncryptionScopeOverrides`
: A list of all Deny Encryption Scope Overrides.

: **Field**: `DenyEncryptionScopeOverrides`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storageservices/datalakestoragegen2/filesystem/list) for other properties available.

## Examples

### Loop through Data Lake Storage Gen2 Filesystems by their names and verify that each exists

```ruby
azure_data_lake_storage_gen2_filesystems(account_name: 'ACCOUNT_NAME').names.each do |name|
  describe azure_data_lake_storage_gen2_filesystem(account_name: 'ACCOUNT_NAME', name: name) do
    it { should exist }
  end
end
```

### Test To ensure Data Lake Storage Gen2 Filesystems With ‘$account-encryption-key’ encryption scope

```ruby
describe azure_data_lake_storage_gen2_filesystems(account_name: 'ACCOUNT_NAME').where(DefaultEncryptionScope: '$account-encryption-key') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Data Lake Storage Gen2 filesystems are present in the project and the resource group.

describe azure_data_lake_storage_gen2_filesystems(account_name: 'ACCOUNT_NAME') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Data Lake Storage Gen2 filesystem in the project and the resource group.

describe azure_data_lake_storage_gen2_filesystems(account_name: 'ACCOUNT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
