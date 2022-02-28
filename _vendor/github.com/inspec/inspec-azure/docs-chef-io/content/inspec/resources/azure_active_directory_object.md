+++
title = "azure_active_directory_object Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_active_directory_object"
identifier = "inspec/resources/azure/azure_active_directory_object Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_active_directory_object` InSpec audit resource to test properties of an Azure Active Directory object.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

```ruby
describe azure_active_directory_object(id: 'ACTIVE_DIRECTORY_OBJECT_ID') do
  it { should exist }
end
```

## Parameters

parameter `id` is mandatory.

`id`
: The Active Directory object ID.

: **Example**: `0bf29229-50d7-433c-b08e-2a5d8b293cb5`

## Properties

`id`
: The object's globally unique ID.

`deletedDateTime`
: The date and time that the object was deleted.

`classification`
: The classification of the AD object.

`createdDateTime`
: The created Datetime of the AD object.

`creationOptions`
: The creationOptions of the AD object.

`description`
: The description of the AD object.

`displayName`
: The display name of the AD object.

`expirationDateTime`
: The expiration Datetime of the AD object.

`groupTypes`
: The group types of the AD object group.

`isAssignableToRole`
: The roles assignable to AD object.

`mail`
: The configured mail for AD object.

`mailEnabled`
: The mail enabled configuration parameter.

`mailNickname`
: The mail nick name configuration.

`membershipRule`
: The membership rule for the AD object.

`membershipRuleProcessingState`
: The processing state of the membership rule.

`onPremisesDomainName`
: The domain name for the given on premises.

`onPremisesLastSyncDateTime`
: The on-premises latest sync datetime.

`onPremisesNetBiosName`
: The on-premises net bios name.

`onPremisesSamAccountName`
: The on-premises sam account name.

`onPremisesSecurityIdentifier`
: The on-premises security identifier.

`onPremisesSyncEnabled`
: The on-premises sync enabled configuration.

`onPremisesProvisioningErrors`
: The on-premises provisioning errors.

`preferredDataLocation`
: The preferred data location.

`preferredLanguage`
: The preferred language.

`proxyAddresses`
: The proxy addresses for the object.

`renewedDateTime`
: The renewed date time of the AD object.

`resourceBehaviorOptions`
: The behavior options set for the resource.

`resourceProvisioningOptions`
: The resource provisioning options set.

`securityEnabled`
: The security enabled configured.

`securityIdentifier`
: The security identifier configured.

`theme`
: The theme of the object.

`visibility`
: The visibility status of the object.

## Examples

**Test if an Active Directory object is referenced with a valid ID.**

```ruby
describe azure_active_directory_object(id: 'ACTIVE_DIRECTORY_OBJECT_ID') do
  it { should exist }
end
```

**Test if an Active Directory object is referenced with an invalid ID.**

```ruby
describe azure_active_directory_object(id: 'ACTIVE_DIRECTORY_OBJECT_ID') do
  it { should_not exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
describe azure_active_directory_object(id: 'ACTIVE_DIRECTORY_OBJECT_ID') do
  it { should exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal.
Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.