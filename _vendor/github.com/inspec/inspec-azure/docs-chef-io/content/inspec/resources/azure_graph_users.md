+++
title = "azure_graph_users Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_graph_users"
identifier = "inspec/resources/azure/azure_graph_users Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_graph_users` InSpec audit resource to test the properties of some or all Azure Active Directory users within a Tenant.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_graph_users` resource block returns all Azure Active Directory user accounts within the configured Tenant and then tests that group of users.

```ruby
describe azure_graph_users do
  #...
end
```

## Parameters

The following parameters can be passed for targeting specific users.

`filter`
: A hash containing the filtering options and their values. The `starts_with_` operator can be used for fuzzy string matching. Parameter names are in the snake case.

: **Example**: `{ starts_with_given_name: 'J', starts_with_department: 'Core', country: 'United Kingdom', given_name: John}`

`filter_free_text`
: [OData](https://www.odata.org/getting-started/basic-tutorial/) query string in double quotes, `"`. Property names are in the camel case. Refer to [here](https://docs.microsoft.com/en-us/graph/query-parameters#filter-parameter) for more information.

: **Example**: `"startswith(displayName,'J') and surname eq 'Doe'"` or `"userType eq 'Guest'"`

It is advised to use these parameters to narrow down the targeted resources at the server side, Azure Graph API, for a more efficient test.

## Properties

`ids`
: The unique identifiers of users.

: **Field**: `id`

`object_ids`
: The unique identifiers of users. This is for backward compatibility. Use `ids` instead.

: **Field**: `id`

`display_names`
: The display names of users.

: **Field**: `displayName`

`given_names`
: The given names of users.

: **Field**: `givenName`

`job_titles`
: The job titles of users.

: **Field**: `jobTitle`

`mails`
: The email addresses of users.

: **Field**: `mail`

`user_types`
: The user types of users. For example, `Member`, `Guest`.

: **Field**: `userType`

`user_principal_names`
: The user principal names of users. For example, `jdoe@contoso.com`.

: **Field**: `userPrincipalName`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

The following examples show how to use this InSpec audit resource.

### Check users with some filtering parameters applied at server side (Using 'filter')

```ruby
describe azure_graph_users(filter: {given_name: 'John', starts_with_department: 'Customer'}) do
  it { should exist }
end
```

### Check users with some filtering parameters applied at server side (Using 'filter_free_text')

```ruby
describe azure_graph_users(filter_free_text: "startswith(givenName,'J') and startswith(department,'customer') and country eq 'United States'") do
  it { should exist }
end
```

### Ensure there are no guest accounts active (Client Side Filtering)

```ruby
describe azure_graph_users.guest_accounts do
  it { should_not exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_graph_users do
  it { should exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal.
Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.
