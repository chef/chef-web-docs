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

Use the `azure_key_vault_keys` InSpec audit resource to test the properties and configuration of multiple Azure keys within vaults.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_key_vault_keys` resource block returns all keys within a vault.

```ruby
describe azure_key_vault_keys(vault_name: 'EXAMPLE_VAULT') do
  #...
end
```

## Parameters

`vault_name`

: The name of the vault.

## Properties

`attributes`
: A list of the key management attributes in [this](https://docs.microsoft.com/en-us/rest/api/keyvault/keys/get-key/get-key?tabs=HTTP#keyattributes) format.

: **Field**: `attributes`

`kids`
: A list of key IDs.

: **Field**: `kid`

`managed`
: A list of boolean values indicating if the keys are managed by key vault or not.

: **Field**: `managed`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that a vault has the named key

```ruby
describe azure_key_vault_keys(vault_name: 'EXAMPLE_VAULT').where { kid.include?('KEY_NAME')} do
  it { should exist }
  its('count') { should be 1 }
end
```

### Loop through keys by the key ID

```ruby
azure_key_vault_keys(vault_name: 'EXAMPLE_VAULT').kids.each do |kid|
  describe azure_key_vault_key(key_id: kid) do
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
# If we expect to have at least one key in a vault.

describe azure_key_vault_keys(vault_name: 'EXAMPLE_VAULT') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect not to have any keys in a vault.

describe azure_key_vault_keys(vault_name: 'EXAMPLE_VAULT') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
