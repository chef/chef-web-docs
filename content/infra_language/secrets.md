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

Chef Infra Client 17.5 and later includes a beta Secrets Management Integration helper. This helper allows accessing secrets from the following secrets management systems within your Infra recipes or resources:

- AWS Secrets Manager
- Akeyless Vault
- Azure Key Vault
- HashiCorp Vault

{{< note >}}

This helper is a beta release, meaning it under active development and may change over time. If you have feedback on any functionality you'd like to see in this helper please reach out at secrets_management_beta@progress.com.

{{</ note >}}

## Secrets Manager Support

### AWS Secrets Manager

The secrets helper supports fetching secrets from AWS Secrets Manager from IAM roles applied to instances.

#### Fetching an AWS Secrets Manager secret

```ruby
secret(name: 'test1', service: :aws_secrets_manager)
```

#### Specifying the AWS Region containing the secret

```ruby
secret(name: 'test1', service: :aws_secrets_manager, config: { region: 'us-west-2' })
```

### Akeyless Vault

The secrets helper supports fetching secrets from Akeyless Vault using Akeyless' access key and access id.

#### Fetching Secrets From Akeyless Vault Using Access Key/ID

```ruby
secret(name: '/secret/data/my_secret',
       service: :akeyless_vault,
       config: {
         access_key: '12345678910=',
         access_id: 'p-12345678910'
      })
```

### Azure Key Vault

The secrets helper supports fetching secrets from Akeyless Vault using Akeyless' access key and access id.

#### Fetching Secrets From Azure Key Vault

```ruby
secret(name: 'vault-name/test-secret-1', service: :azure_key_vault)
```

#### Fetching a specific version of an Azure Key Vault secret

```ruby
secret(name: 'vault-name/test1', version: 'v1', service: :azure_key_vault)
```

### HashiCorp Vault

#### Fetching Secrets From HashiCorp Vault Using AWS IAM

```ruby
secret(name: 'secret/example', 
      service: :hashi_vault,
      config: {
        vault_addr: 'vault.example.com',
        role_name: 'example-role'
      })
```

#### Fetching Secrets From HashiCorp Vault Using Tokens

```ruby
secret(name: 'secret/example',
      service: :hashi_vault,
      config: {
        vault_addr: 'vault.example.com',
        token: '123456'
      })
```

## Using in Cookbooks

The secrets helper returns a text string, so it can be used anywhere in Chef Infra where you might hard code a value or access a value from a data bag.

### Writing a Secret To a File

```ruby
file '/home/ubuntu/aws-secret' do
  content secret(name: 'test1', service: :aws_secrets_manager)
end
```

### Passing a Secret to a Template

```ruby
template '/etc/my_fancy_service/my_fancy_service.conf' do
  source 'config.erb'
  variables(
    db_token: secret(name: 'db_token', service: :aws_secrets_manager)
  )
end
```
