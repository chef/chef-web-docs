+++
title = "azure_graph_user Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_graph_user"
identifier = "inspec/resources/azure/azure_graph_user Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_graph_user` InSpec audit resource to test properties of an Azure Active Directory user within a Tenant.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

```ruby
describe azure_graph_user(user_principal_name: 'jdoe@contoso.com') do
  it { should exist }
end
```

## Parameters

Either one of the following parameters is mandatory.

`user_principal_name`
: The user principal name.

: **Example**: `jdoe@contoso.com`

`id`
: Globally unique identifier.

: **Example**: `abcd-1234-efabc-5678`

`user_id`
: Globally unique identifier. (For backward compatibility.).

: **Example**: `abcd-1234-efabc-5678`
## Properties

`id`
: The user's globally unique ID.

`account_enabled`
: Whether the account is enabled.

`city`
: The user's city.

`country`
: The user's country.

`department`
: The user's department.

`display_name`
: The display name of the user.

`facsimile_telephone_number`
: The user's facsimile (fax) number.

`given_name`
: The given name for the user.

`job_title`
: The user's job title.

`mail`
: The primary email address of the user.

`mail_nickname`
: The mail alias for the user.

`mobile`
: The user's mobile (cell) phone number.

`password_policies`
: The password policies for the user.

`password_profile`
: The password profile for the user.

`postal_code`
: The user's postal (ZIP) code.

`state`
: The user's state.

`street_address`
: The user's street address.

`surname`
: The user's surname (family name or last name).

`telephone_number`
: The user's telephone number.

`usage_location`
: A two letter country code (ISO standard 3166). Examples include: `US`, `JP`, and `GB`.

`user_principal_name`
: The principal name of the user.

`user_type`
: A string value that can be used to classify user types in your directory, such as `Member` or `Guest`.

## Examples

**Test If an Active Directory User Account is Referenced with a Valid ID.**

```ruby
describe azure_graph_user(id: 'someValidId')
  it { should exist }
end
```
**Test If an Active Directory User Account is Referenced with an Invalid ID.**

```ruby
describe azure_graph_user(id: 'someInvalidId')
  it { should_not exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
describe azure_graph_user(user_id: 'someUserId') do
  it { should exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal.
Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.