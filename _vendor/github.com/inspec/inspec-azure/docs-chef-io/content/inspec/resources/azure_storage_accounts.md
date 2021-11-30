+++
title = "azure_storage_accounts Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_storage_accounts"
identifier = "inspec/resources/azure/azure_storage_accounts Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_storage_accounts` InSpec audit resource to test properties and configuration of multiple Azure Storage Accounts.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_storage_accounts` resource block returns all Azure storape accounts, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_storage_accounts do
  #...
end
```
or
```ruby
describe azure_storage_accounts(resource_group: 'my-rg') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`locations`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`type`
: A list of types of all the resources being interrogated.

: **Field**: `type`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`properties`
: A list of all properties of all the resources.

: **Field**: `properties`
{{% inspec_filter_table %}}

## Examples

**Check If a Specific Storage Account Exists.**

```ruby
describe azurerm_storage_accounts(resource_group: 'rg') do
  its('names') { should include('mysa') }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
# If we expect at least one account to exist in a resource group

describe azure_storage_accounts(resource_group: 'rg') do
  it { should exist }
end

# If we expect no storage accounts to exist in a resource group

describe azure_storage_accounts(resource_group: 'rg') do
  it { should_not exist }
end

```

## Azure Permissions

{{% azure_permissions_service_principal role="reader" %}}
