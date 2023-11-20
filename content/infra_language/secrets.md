+++
title = "Chef Infra Language: Secrets"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Secrets Management Integrations"
    identifier = "chef_infra/infra_language/secrets.md Secrets Management Integrations"
    parent = "chef_infra/infra_language"
+++

The Secrets Management Integration helper is a beta feature starting in Chef Infra Client 17.5 and became a fully supported feature in Chef Infra Client 18.
This helper allows you to access secrets from the following secrets management systems within your Infra recipes or resources:

- AWS Secrets Manager
- Akeyless Vault
- Azure Key Vault
- HashiCorp Vault

## Syntax

Use the following syntax to fetch secrets:

```ruby
secret(name: '<SECRET_NAME>', version: '<VERSION>', service: <SERVICE>, config: {key: value})
```

<!-- markdownlint-disable MD006 MD007 -->

Replace the following:

`<SECRET_NAME>`
: The identifier or name for this secret.

`<VERSION>`
: The secret version. If a service supports versions and you don't provide a version, the Secrets Management Integration helper fetches the latest version.

  Secret versions supported with:

  - AWS Secrets Manager
  - Azure Key Vault

`<SERVICE>`
: The secret manager.

  Allowed values:

  - `:akeyless_vault`
  - `:aws_secrets_manager`
  - `:azure_key_vault`
  - `:hashi_vault`

`config`
: Use `config` to set key/value settings passed to a secrets manager. For example, to set the AWS region that a secret is stored in with AWS Secrets Manager, add `config: {region: 'us-west-2'}`.

<!-- markdownlint-enable MD006 MD007 -->

### Set defaults

You can set a default service and service configuration and then the Secrets Management Integration helper will use those settings every time you request a secret.
This is useful if you want to request more than one secret from the same service.

Use the `default_secret_service` and `default_secret_config` to define a default service and service configuration:

```ruby
default_secret_service(<SERVICE>)
default_secret_config(key: "value")

value1 = secret(name: "<SECRET_NAME_1>")
value2 = secret(name: "<SECRET_NAME_2>")
value3 = secret(name: "<SECRET_NAME_3>")
```

Or wrap your secret definitions using `with_secret_service` and `with_secret_config`:

```ruby
with_secret_service(<SERVICE>) do
  with_secret_config(key: "value") do
    value1 = secret(name: "<SECRET_NAME_1>")
    value2 = secret(name: "<SECRET_NAME_2>")
    value3 = secret(name: "<SECRET_NAME_3>")
  end
end
```

Define a default secret service and then fetch secrets with different configs:

```ruby
default_secret_service(<SERVICE>)

with_secret_config(key: "<VALUE>") do
  secret_1 = secret(name: "<SECRET_NAME_1>")
  secret_2 = secret(name: "<SECRET_NAME_2>")
end

with_secret_config(key: "<OTHER_VALUE>") do
  secret_3 = secret(name: "<SECRET_NAME_3>")
  secret_4 = secret(name: "<SECRET_NAME_4>")
end
```

## Examples

### Akeyless Vault

Fetch secrets from Akeyless Vault using the access key and access ID:

```ruby
secret(name: '<SECRET_NAME>',
       service: :akeyless_vault,
       config: {
         access_key: '<ACCESS_KEY>',
         access_id: '<ACCESS_ID>'
      })
```

### AWS Secrets Manager

Fetch a secret from AWS Secrets Manager:

```ruby
secret(name: '<SECRET_NAME>', service: :aws_secrets_manager)
```

Specify an AWS region:

```ruby
secret(name: '<SECRET_NAME>', service: :aws_secrets_manager, config: { region: '<AWS_REGION>' })
```

### Azure Key Vault

Fetch secrets from Azure Key Vault:

```ruby
secret(name: '<VAULT_NAME/SECRET_NAME>', service: :azure_key_vault)
```

Specify the vault name in the config:

```ruby
secret(name: '<SECRET_NAME>', service: :azure_key_vault, config: { vault: '<VAULT_NAME>' })
```

Fetch a specific version of an Azure Key Vault secret:

```ruby
secret(name: '<VAULT_NAME/SECRET_NAME>', version: 'v1', service: :azure_key_vault)
```

### HashiCorp Vault

Fetch secrets from HashiCorp Vault using AWS IAM:

```ruby
secret(name: '<PATH/TO/SECRET>',
      service: :hashi_vault,
      config: {
        vault_addr: 'vault.example.com',
        role_name: '<ROLE>'
      })
```

Fetch secrets from HashiCorp Vault using tokens:

```ruby
secret(name: '<PATH/TO/SECRET>',
      service: :hashi_vault,
      config: {
        vault_addr: 'vault.example.com',
        auth_method: :token,
        token: '<TOKEN_STRING>'
      })
```

Fetch secrets from HashiCorp Vault using AppRole ID and an associated AppRole Secret ID:

```ruby
secret(name: '<PATH/TO/SECRET>',
      service: :hashi_vault,
      config: {
        vault_addr: 'vault.example.com',
        auth_method: :approle,
        approle_id: "<APPROLE_ID_STRING>",
        approle_secret_id: "<APPROLE_SECRET_ID_STRING>"
      })
```

Fetch secrets using a token and an AppRole name creates a Secret ID associated with that AppRole:

```ruby
secret(name: '<PATH/TO/SECRET>',
      service: :hashi_vault,
      config: {
        vault_addr: 'vault.example.com',
        auth_method: :approle,
        approle_name: "<APPROLE_NAME>",
        token: '<TOKEN_STRING>'
      })
```

### Fetch secrets in cookbooks

The secrets helper returns a text string, so you can use it anywhere in Chef Infra where you might hard code a value or access a value from a data bag.

Write a secret to a file:

```ruby
file '/home/ubuntu/aws-secret' do
  content secret(name: '<SECRET_NAME>', service: :aws_secrets_manager)
end
```

Pass a secret to a template:

```ruby
template '/etc/my_fancy_service/my_fancy_service.conf' do
  source 'config.erb'
  variables(
    db_token: secret(name: 'db_token', service: :aws_secrets_manager)
  )
end
```
