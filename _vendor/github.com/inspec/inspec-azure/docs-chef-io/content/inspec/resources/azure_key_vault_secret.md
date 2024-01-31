+++
title = "azure_key_vault_secret Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_key_vault_secret"
identifier = "inspec/resources/azure/azure_key_vault_secret Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_key_vault_secret` InSpec audit resource to test the properties and configuration of an Azure secret within a vault.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_key_vault_secret` resource block identifies an Azure secret by `vault_name` and `secret_name`, or the `secret_id`. You may also specify a `secret_version`. If no version is specified, the most recent version of the secret is used.

```ruby
describe azure_key_vault_secret(vault_name: 'EXAMPLE_VAULT', secret_name: 'EXAMPLE_SECRET') do
  it { should exist }
end
```

```ruby
describe azure_key_vault_secret(vault_name: 'EXAMPLE_VAULT', secret_name: 'EXAMPLE_SECRET', secret_version: '78deebed173b48e48f55abf87ed4cf71') do
  it { should exist }
end
```

```ruby
describe azure_key_vault_secret(secret_id: 'https://example_vault.vault.azure.net/secrets/secret_name/7df9bf2c3b4347bab213ebe233f0e350') do
  it { should exist }
end
```

## Parameters

`vault_name`
: The key vault name where the targeted secret resides.

`secret_name`
: The name of the secret to interrogate.

`name`
: Alias for the `secret_name` parameter.

`secret_version` _Optional_
: The version of a secret. For example, `7df9bf2c3b4347bab213ebe233f0e350`.

`secret_id`
: The unique ID of the secret. For example, `https://example_vault.vault.azure.net/secrets/secret_name/7df9bf2c3b4347bab213ebe233f0e350`.

Either one of the parameter sets can be provided for a valid query:

- `vault_name` and `secret_name`
- `vault_name` and `name`
- `secret_id`

## Properties

`id`
: The secret ID. `https://example_vault.vault.azure.net/secrets/secret_name`.

`kid`
: If this is a secret backing a KV certificate, then this field specifies the corresponding key backing the KV certificate.

`attributes`
: The secret management attributes in [this](https://docs.microsoft.com/en-us/rest/api/keyvault/secrets/get-secrets/get-secrets?tabs=HTTP#secretattributes) format.

`contentType`
: The content type of the secret.

`content_type`
: Alias for the `contentType`.

`managed`
: `true` if the secret's lifetime is managed by key vault. If this is a secret backing a certificate, then managed will be `true`.

`tags`
: Application specific metadata in the form of key-value pairs.

`value`
: The secret's value.

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/keyvault/secrets/get-secrets/get-secrets) for more details.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test the secret identifier

```ruby
describe azure_key_vault_secret(vault_name: 'EXAMPLE_VAULT', secret_name: 'EXAMPLE_SECRET') do
  its('id') { should cmp 'https://example_vault.vault.azure.net/secrets/example_secret' }
end
```

### Test if the secret is enabled

```ruby
describe azure_key_vault_secret(vault_name: 'EXAMPLE_VAULT', secret_name: 'EXAMPLE_SECRET') do
  its('attributes.enabled') { should eq true }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the secret to always exist.
describe azure_key_vault_secret(vault_name: 'EXAMPLE_VAULT', secret_name: 'EXAMPLE_SECRET') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the secret to never exist.
describe azure_key_vault_secret(vault_name: 'EXAMPLE_VAULT', secret_name: 'EXAMPLE_SECRET') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
