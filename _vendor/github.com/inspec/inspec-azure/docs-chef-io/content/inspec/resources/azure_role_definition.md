+++
title = "azure_role_definition Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_role_definition"
identifier = "inspec/resources/azure/azure_role_definition Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_role_definition` InSpec audit resource to test properties and configuration of an Azure role definition.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_role_definition(name: 'abcd-1234') do
  it { should exist }
end
```
```ruby
describe azure_role_definition(resource_id: '/{scope}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionId}') do
  it { should exist }
end
```

## Parameters

`name`
: Name of the role definition. `roleDefinitionName`.

`resource_id`
: The unique resource ID. `/{scope}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionId}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `name`

## Properties

`role_name`
: The role name.

`role_type`
: The role type. `BuiltInRole`.

`assignable_scopes`
: Role definition assignable scopes.

`permissions_allowed`
: A list of allowed actions within role definition permissions.

`permissions_not_allowed`
: A list of denied actions within role definition permissions.


For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/authorization/roledefinitions/get#roledefinition) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test Allowed Permissions on a Role Definition.**

```ruby
describe azure_role_definition(name: 'policy-reader-only')
  it { should exist }
  its('permissions_allowed') { should include 'Microsoft.Authorization/policyassignments/read'}
  its('permissions_allowed') { should_not include 'Microsoft.Authorization/policyassignments/write'}
  its('permissions_allowed') { should_not include '*'}
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# If we expect a resource to always exist

describe azure_role_definition(name: 'abcd-1234') do
  it { should exist }
end
# If we expect a resource to never exist

describe azure_role_definition(name: 'abcd-1234') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
