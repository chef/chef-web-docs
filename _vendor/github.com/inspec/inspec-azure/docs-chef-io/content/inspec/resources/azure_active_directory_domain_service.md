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

Use the `azure_active_directory_domain_service` InSpec audit resource to test the properties of an Azure Active Directory service within a tenant.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

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
: The fully qualified name of the domain. Key, immutable, not nullable, and unique.

`authenticationType`
: Indicates the configured authentication type for the domain. The value is either `Managed` or `Federated`.

`availabilityStatus`
: This property is always `null` except when the verify action is used.

`isAdminManaged`
: The value of the property is `false` if the DNS record management of the domain has been delegated to Microsoft 365.

`isDefault`
: `true` if this is the default domain used for user creation. There is only one default domain per company. Not nullable.

`isInitial`
: `true` if this is the initial domain created by Microsoft Online Services (`companyname.onmicrosoft.com`). There is only one initial domain per company.

`isRoot`
: `true` if the domain is a verified root domain. Otherwise, `false` if the domain is a subdomain or unverified.

`isVerified`
: `true` if the domain has completed domain ownership verification.

`passwordNotificationWindowInDays`
: Specifies the number of days before a user receives notification that their password will expire. A default value of `14 days` will be used if the property is not set.

`passwordValidityPeriodInDays`
: Specifies the length of time that a password is valid before it must be changed. A default value of `90 days` will be used if the property is not set.

`supportedServices`
: The capabilities assigned to the domain.

`state`
: Status of asynchronous operations scheduled for the domain.

## Examples

### Test if an active directory domain is referenced with a valid ID

```ruby
describe azure_active_directory_domain_service(id: 'example.com') do
  it { should exist }
end
```

### Test if an active directory domain is referenced with an invalid ID

```ruby
describe azure_active_directory_domain_service(id: 'example.com') do
  it { should_not exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
describe azure_active_directory_domain_service(id: 'example.onmicrosoft.com') do
  it { should exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal. Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.
