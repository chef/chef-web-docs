+++
title = "azure_storage_account Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_storage_account"
identifier = "inspec/resources/azure/azure_storage_account Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_storage_account` InSpec audit resource to test properties related to an Azure Storage Account.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_storage_account` resource block identifies an Azure storage account by `name` and `resource_group` or the `resource_id`.
```ruby
describe azure_storage_account(resource_group: 'rg', name: 'sa')  do
  it { should exist }
end
```
```ruby
describe azure_storage_account(resource_id: '/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: The name of the storage account within the specified resource group. `accountName`.

`resource_id`
: The unique resource ID. `/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}`.

`activity_log_alert_api_version`
: The activity log alerts endpoint api version used in `have_recently_generated_access_key` matcher. The latest version will be used unless provided.

`storage_service_endpoint_api_version`
: The storage service endpoint api version. `2019-12-12` wil be used unless provided.

`resource_data`
: In-memory cached Azure Network security group data. Passing data to this parameter can increase performance since it avoids multiple network calls to the same Azure resource. When provided, it binds the values directly to the resource. Data passed to the `resource_data` parameter could be stale. It is the user's responsibility to refresh the data.


Pass one of the following parameter sets for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_data`

## Properties

`queues<superscript>*</superscript>`
: Lists all of the queues in a given storage account. See [here](https://docs.microsoft.com/en-us/rest/api/storageservices/list-queues1) for more.

`queue_properties<superscript>*</superscript>`
: gets the properties of a storage account’s Queue service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. See [here](https://docs.microsoft.com/en-us/rest/api/storageservices/get-queue-service-properties) for more.

`blobs<superscript>*</superscript>`
: Lists all of the blob containers in a given storage account. See [here](https://docs.microsoft.com/en-us/rest/api/storageservices/list-containers2) for more.

`blob_properties<superscript>*</superscript>`
: gets the properties of a storage account’s Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. See [here](https://docs.microsoft.com/en-us/rest/api/storageservices/get-blob-service-properties) for more.

`table_properties<superscript>*</superscript>`
: gets the properties of a storage account’s Table service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. See [here](https://docs.microsoft.com/en-us/rest/api/storageservices/get-table-service-properties) for more.

<superscript>*</superscript>: Note that the Azure endpoints return data in XML format; however, they will be converted to Azure Resource Probe to make the properties accessible via dot notation.
The property names will be in snake case, `propety_name`. Therefore, `<EnumerationResults ServiceEndpoint="https://myaccount.queue.core.windows.net/">` can be tested via `its('enumeration_results.service_endpoint)`.

The property names will be in snake case, `propety_name`. Therefore, `<EnumerationResults ServiceEndpoint="https://myaccount.blob.core.windows.net/">` can be tested via `its('enumeration_results.service_endpoint)`.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storagerp/storageaccounts/getproperties#storageaccount) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test the Primary Endpoints.**

```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  its('properties.primaryEndpoints.blob') { should cmp 'https://mysa.blob.core.windows.net/' }
  its('properties.primaryEndpoints.queue') { should cmp 'https://mysa.queue.core.windows.net/' }
  its('properties.primaryEndpoints.table') { should cmp 'https://mysa.table.core.windows.net/' }
  its('properties.primaryEndpoints.file') { should cmp 'https://mysa.file.core.windows.net/' }
end
```
**Verify that Only HTTPs is Supported.**

```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  its('properties.supportsHttpsTrafficOnly') { should be true }
end
```
**Test Queues Service Endpoint.**

```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  its('queues.enumeration_results.service_endpoint') { should cmp 'https://mysa.queue.core.windows.net/' }
end
```
**Test Blobs Service Endpoint.**

```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  its('blobs.enumeration_results.service_endpoint') { should cmp 'https://mysa.blob.core.windows.net/' }
end
```
**Test Queue Properties Logging Version.**

```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  its('queue_properties.logging.version') { should cmp '1.0' }
end
```
**Test Blob Properties Logging Version.**

```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  its('blob_properties.logging.version') { should cmp '1.0' }
end
```
**Test Table Properties Logging Version.**

```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  its('table_properties.logging.version') { should cmp '1.0' }
end
```

**Loop through all storage accounts and test a blob service endpoint exists from already cached data.**

```ruby
azure_storage_accounts.entries.each do |azure_storage_account_data|
    describe azure_storage_account(resource_data: azure_storage_account_data) do
      its('blobs.enumeration_results.service_endpoint') { should cmp 'https://mysa.blob.core.windows.net/' }
    end
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### have_encryption_enabled

Test if encryption is enabled.
```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  it { should have_encryption_enabled }
end
```

### have_recently_generated_access_key

Test if an access key has been generated within the last **90** days.
```ruby
describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  it { should have_recently_generated_access_key }
end
```
### exists

```ruby
# If we expect the resource to always exist

describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  it { should exist }
end

# If we expect the resource to never exist

describe azure_storage_account(resource_group: 'rg', name: 'mysa') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="reader" %}}
