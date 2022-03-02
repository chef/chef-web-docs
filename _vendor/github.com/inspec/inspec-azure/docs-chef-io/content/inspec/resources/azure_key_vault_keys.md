+++
title = "azure_key_vault_keys Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_key_vault_keys"
identifier = "inspec/resources/azure/azure_key_vault_keys Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_key_vault_keys` InSpec audit resource to test properties and configuration of multiple of Azure keys within vaults.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_key_vault_keys` resource block returns all keys within a vault.

```ruby
describe azure_key_vault_keys(vault_name: 'example_vault') do
  #...
end
```

## Parameters

`vault_name`

: The name of the vault.

## Properties

`attributes`
: A list of the key management attributes in [this](https://docs.microsoft.com/en-us/rest/api/keyvault/getkey/getkey#keyattributes) format.

: **Field**: `attributes`

`kids`
: A list of key ids.

: **Field**: `kid`

`managed`
: A list of boolean values indicating if the keys are managed by key vault or not.

: **Field**: `managed`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

{{% inspec_filter_table %}}

## Examples

**Test that a Vault has the Named Key.**

```ruby
describe azure_key_vault_keys(vault_name: 'example_vault').where { kid.include?('my_key')} do
  it { should exist }
  its('count') { should be 1 }
end
```
**Loop through Keys by the Key ID.**

```ruby
azure_key_vault_keys(vault_name: 'example_vault').kids.each do |kid|
  describe azure_key_vault_key(key_id: kid) do
    it { should exist }
  end 
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
# If we expect to have at least one key in a vault

describe azure_key_vault_keys(vault_name: 'example_vault') do
  it { should exist }
end

# If we expect not have any keys in a vault

describe azure_key_vault_keys(vault_name: 'example_vault') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
