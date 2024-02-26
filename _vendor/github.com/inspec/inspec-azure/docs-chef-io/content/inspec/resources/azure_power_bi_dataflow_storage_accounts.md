+++
title = "azure_power_bi_dataflow_storage_accounts Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_dataflow_storage_accounts"
identifier = "inspec/resources/azure/azure_power_bi_dataflow_storage_accounts Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_dataflow_storage_accounts` InSpec audit resource to test the properties related to all Azure Power BI dataflow storage accounts.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_dataflow_storage_accounts` resource block returns all Azure Power BI dataflow storage accounts.

```ruby
describe azure_power_bi_dataflow_storage_accounts do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: List of all Power BI dataflow storage account IDs.

: **Field**: `id`

`names`
: List of all the dataflow storage account names.

: **Field**: `name`

`isEnableds`
: List of the flags that indicates if workspaces can be assigned to the storage accounts.

: **Field**: `isEnabled`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/dataflow-storage-accounts/get-dataflow-storage-accounts) for other properties available.

## Examples

### Test that the Power BI dataflow storage account is enabled

```ruby
describe azure_power_bi_dataflow_storage_accounts.where(isEnabled: true) do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Power BI dataflow storage account is present.

describe azure_power_bi_dataflow_storage_accounts do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Power BI dataflow storage account.

describe azure_power_bi_dataflow_storage_accounts do
  it { should exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `StorageAccount.Read.All` role on the Azure Power BI dataflow storage Account you wish to test.
