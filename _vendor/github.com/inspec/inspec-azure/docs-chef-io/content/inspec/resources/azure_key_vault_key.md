+++
title = "azure_key_vault_key Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_key_vault_key"
identifier = "inspec/resources/azure/azure_key_vault_key Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_key_vault_key` InSpec audit resource to test the properties and configuration of an Azure key within a vault.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_key_vault_key` resource block identifies an Azure key by `vault_name` and `key_name`, or the `key_id`. You may also specify a `key_version`. If no version is specified, the most recent version of the key will be used.

```ruby
describe azure_key_vault_key(vault_name: 'EXAMPLE_VAULT', key_name: 'EXAMPLE_KEY') do
  it { should exist }
end
```

```ruby
describe azure_key_vault_key(vault_name: 'EXAMPLE_VAULT', key_name: 'EXAMPLE_KEY', key_version: '78deebed173b48e48f55abf87ed4cf71') do
  it { should exist }
end
```

```ruby
describe azure_key_vault_key(key_id: 'https://example_vault.vault.azure.net/keys/key/7df9bf2c3b4347bab213ebe233f0e350') do
  it { should exist }
end
```

## Parameters

`vault_name`
: The name of the key vault where the targeted key resides.

`key_name`
: The name of the key to interrogate.

`name`
: Alias for the `key_name` parameter.

`key_version`
: (Optional) - The version of a key. For example, `7df9bf2c3b4347bab213ebe233f0e350`.

`key_id`
: The unique ID of the key. For example, `https://example_vault.vault.azure.net/keys/key/7df9bf2c3b4347bab213ebe233f0e350`.

Either one of the parameter sets can be provided for a valid query:

- `vault_name` and `key_name`
- `vault_name` and `name`
- `key_id`

## Properties

`attributes`
: The key management attributes in [this](https://docs.microsoft.com/en-us/rest/api/keyvault/keys/get-key/get-key?tabs=HTTP#keyattributes) format.

`key`
: The JSON web key in [this](https://docs.microsoft.com/en-us/rest/api/keyvault/keys/get-key/get-key?tabs=HTTP#jsonwebkey) format.

`managed`
: `true` if the key's lifetime is managed by key vault. If this is a key backing a certificate, then managed will be `true`.

`tags`
: Application-specific metadata in the form of key-value pairs.

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/keyvault/keys/get-key/get-key?tabs=HTTP) for more details. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test the key identifier

```ruby
describe azure_key_vault_key(vault_name: 'EXAMPLE_VAULT', key_name: 'EXAMPLE_KEY', key_version: '7df9bf2c3b4347bab213ebe233f0e350') do
  its('key.kid') { should cmp 'https://example_vault.vault.azure.net/keys/key/7df9bf2c3b4347bab213ebe233f0e350' }
end
```

### Test if the key is enabled

```ruby
describe azure_key_vault_key(vault_name: 'EXAMPLE_VAULT', key_name: 'EXAMPLE_KEY') do
  its('attributes.enabled') { should eq true }
end
```
### Test if the rotationploicy is enabled

```ruby
describe azure_key_vault_key(vault_name: 'EXAMPLE_VAULT', key_name: 'EXAMPLE_KEY') do
  it { should have_rotation_policy_enabled }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the key to always exist.

describe azure_key_vault_key(vault_name: 'EXAMPLE_VAULT', key_name: 'EXAMPLE_KEY') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the key to never exist.

describe azure_key_vault_key(vault_name: 'EXAMPLE_VAULT', key_name: 'EXAMPLE_KEY') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
