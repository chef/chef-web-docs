+++
title = "azure_key_vault Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_key_vault"
identifier = "inspec/resources/azure/azure_key_vault Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_key_vault` InSpec audit resource to test the properties related to a key vault.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_key_vault(resource_group: 'RESOURCE_GROUP', name: 'VAULT-101') do
  it            { should exist }
  its('name')   { should cmp 'vault-101' }    
end
```

```ruby
describe azure_key_vault(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.KeyVault/vaults/{vaultName}') do
  it            { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: Name of the Azure resource to test.

`vault_name`
: Name of the Azure resource to test (for backward compatibility).

`resource_id`
: The unique resource ID.

`diagnostic_settings_api_version`
: The endpoint API version for the `diagnostic_settings` property. `2017-05-01-preview` will be used for backward compatibility unless provided.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `vault_name`

## Properties

`diagnostic_settings`
: The active diagnostic settings list for the key vault.

`diagnostic_settings_logs`
: The logs enabled status of every category for the key vault.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/keyvault/keyvault/vaults/get) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test key vault's SKU family

```ruby
describe azure_key_vault(resource_group: 'RESOURCE_GROUP', name: 'VAULT_NAME') do
  its('properties.sku.family') { should eq 'A' }
end
```

### Test if the key vault is enabled for disk encryption

```ruby
describe azure_key_vault(resource_group: 'RESOURCE_GROUP', name: 'VAULT_NAME') do
  its('properties.enabledForDiskEncryption') { should be_true }
end
```

### Test if Azure key vault audit logging is enabled

```ruby
describe azure_key_vault(resource_group: 'RESOURCE_GROUP', name: 'VAULT_NAME') do
  its('diagnostic_settings_logs') { should include(true) }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a key vault is found, it will exist.

describe azure_key_vault(resource_group: 'RESOURCE_GROUP', name: 'VAULT_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# Key vaults that aren't found, will not exist.

describe azure_key_vault(resource_group: 'RESOURCE_GROUP', name: 'VAULT_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
