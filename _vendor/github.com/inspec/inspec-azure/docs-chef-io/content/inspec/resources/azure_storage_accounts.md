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

Use the `azure_storage_accounts` InSpec audit resource to test the properties and configuration of multiple Azure Storage accounts.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_storage_accounts` resource block returns all Azure storage accounts, either within a resource group (if provided) or an entire subscription.

```ruby
describe azure_storage_accounts do
  #...
end
```

Or

```ruby
describe azure_storage_accounts(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

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

`type`
: A list of types of all the resources being interrogated.

: **Field**: `type`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`properties`
: A list of all properties of all the resources.

: **Field**: `properties`
{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check if a specific storage account exists

```ruby
describe azurerm_storage_accounts(resource_group: 'RESOURCE_GROUP') do
  its('names') { should include('mysa') }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
# If we expect at least one account to exist in a resource group.

describe azure_storage_accounts(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect no storage accounts to exist in a resource group.

describe azure_storage_accounts(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
