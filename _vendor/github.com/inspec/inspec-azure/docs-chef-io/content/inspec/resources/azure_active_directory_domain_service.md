+++
title = "azure_active_directory_domain_service Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_active_directory_domain_service"
identifier = "inspec/resources/azure/azure_active_directory_domain_service Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_active_directory_domain_service` InSpec audit resource to test properties of an Azure Active Directory service within a tenant.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

```ruby
describe azure_active_directory_domain_service(id: 'example.com') do
  it { should exist }
end
```

## Parameters

Either one of the following parameters is mandatory.

`id`
: Domain ID.

: **Example**: `example.com`

## Properties

`id`
: The fully qualified name of the domain. Key, immutable, not nullable, unique.

`authenticationType`
: Indicates the configured authentication type for the domain.The value is either `Managed` or `Federated`.

`availabilityStatus`
: This property is always `null` except when the verify action is used.

`isAdminManaged`
: The value of the property is `false` if the DNS record management of the domain has been delegated to Microsoft 365.

`isDefault`
: `true` if this is the default domain that is used for user creation. There is only one default domain per company. Not nullable.

`isInitial`
: `true` if this is the initial domain created by Microsoft Online Services (companyname.onmicrosoft.com). There is only one initial domain per company.

`isRoot`
: `true` if the domain is a verified root domain. Otherwise, `false` if the domain is a subdomain or unverified.

`isVerified`
: `true` if the domain has completed domain ownership verification.

`passwordNotificationWindowInDays`
: Specifies the number of days before a user receives notification that their password will expire. If the property is not set, a default value of 14 days will be used.

`passwordValidityPeriodInDays`
: Specifies the length of time that a password is valid before it must be changed. If the property is not set, a default value of 90 days will be used.

`supportedServices`
: The capabilities assigned to the domain.

`state`
: Status of asynchronous operations scheduled for the domain.

## Examples

**Test If an Active Directory Domain is Referenced with a Valid ID.**

```ruby
describe azure_active_directory_domain_service(id: 'example.com') do
  it { should exist }
end
```

**Test If an Active Directory Domain is Referenced with an Invalid ID.**

```ruby
describe azure_active_directory_domain_service(id: 'example.com') do
  it { should_not exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
describe azure_active_directory_domain_service(id: 'example.onmicrosoft.com') do
  it { should exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal.
Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.