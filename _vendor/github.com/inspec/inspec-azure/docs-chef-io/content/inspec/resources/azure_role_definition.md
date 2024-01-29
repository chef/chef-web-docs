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

Use the `azure_role_definition` InSpec audit resource to test the properties and configuration of an Azure role definition.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` or the `resource_id` are required parameters.

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
: Name of the role definition.

`resource_id`
: The unique resource ID.

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

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/authorization/roledefinitions/get#roledefinition) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test allowed permissions on a role definition

```ruby
describe azure_role_definition(name: 'policy-reader-only')
  it { should exist }
  its('permissions_allowed') { should include 'Microsoft.Authorization/policyassignments/read'}
  its('permissions_allowed') { should_not include 'Microsoft.Authorization/policyassignments/write'}
  its('permissions_allowed') { should_not include '*'}
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If we expect a resource to always exist.

describe azure_role_definition(name: 'abcd-1234') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_role_definition(name: 'abcd-1234') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
