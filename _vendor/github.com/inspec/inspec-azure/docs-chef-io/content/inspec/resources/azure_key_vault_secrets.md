+++
title = "azure_key_vault_secrets Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_key_vault_secrets"
identifier = "inspec/resources/azure/azure_key_vault_secrets Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_key_vault_secrets` InSpec audit resource to test the properties and configuration of multiple Azure secrets within vaults.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_key_vault_secrets` resource block returns all secrets within a vault.

```ruby
describe azure_key_vault_secrets(vault_name: 'EXAMPLE_VAULT') do
  #...
end
```

## Parameters

`vault_name`

: The name of the vault.

## Properties

`attributes`
: A list of the secret management attributes in [this](https://docs.microsoft.com/en-us/rest/api/keyvault/secrets/get-secrets/get-secrets?tabs=HTTP#secretattributes) format.

: **Field**: `attributes`

`ids`
: A list of secret IDs.

: **Field**: `id`

`managed`
: A list of boolean values indicating if the secrets are managed by key vault or not.

: **Field**: `managed`

`contentTypes`
: A list of secrets content type being interrogated.

: **Field**: `contentType`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that a vault has the named secret

```ruby
describe azure_key_vault_secrets(vault_name: 'EXAMPLE_VAULT').where { id.include?('SECRET')} do
  it { should exist }
  its('count') { should be 1 }
end
```

### Loop through secrets by their IDs

```ruby
azure_key_vault_secrets(vault_name: 'EXAMPLE_VAULT').ids.each do |id|
  describe azure_key_vault_secret(secret_id: id) do
    it { should exist }
  end 
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
# If we expect to have at least one secret in a vault.
describe azure_key_vault_secrets(vault_name: 'EXAMPLE_VAULT') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect not have any secrets in a vault.
describe azure_key_vault_secrets(vault_name: 'EXAMPLE_VAULT') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
