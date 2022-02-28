+++
title = "azure_policy_definition Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_policy_definition"
identifier = "inspec/resources/azure/azure_policy_definition Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_policy_definition` InSpec audit resource to test properties and configuration of an Azure policy definition.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_policy_definition(name: 'my_policy') do
  it { should exist }
end
```
```ruby
describe azure_policy_definition(resource_id: '/subscriptions/{subscriptionId}/providers/Microsoft.Authorization/policyDefinitions/{policyDefinitionName}') do
  it { should exist }
end
```

## Parameters

`name`
: Name of the policy definition. `policyDefinitionName`.

`built_in`
: Indicates whether the policy definition is built-in. Optional. Defaults to `false` if not supplied. This should not be used when `resource_id` is provided.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/providers/Microsoft.Authorization/policyDefinitions/{policyDefinitionName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `name`
- `name` and `built_in`

## Properties

`properties.description`
: The policy definition description.

`properties.displayName`
: The display name of the policy definition.

`properties.policyType`
: The type of policy definition. Possible values are `NotSpecified`, `BuiltIn`, `Custom`, and `Static`.

`properties.policyRule`
: The policy rule.


For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/resources/policydefinitions/get#policydefinition) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test a Policy Definition Display Name.**

```ruby
describe azure_policy_definition(name: 'my_policy') do
  its('properties.displayName') { should cmp "Enforce 'owner' tag on resource groups" }
end
```
**Test a Policy Definition Rule.**

```ruby
describe azure_policy_definition(name: 'my_policy', built_in: true ) do
  its('properties.policyRule.then.effect') { should cmp 'deny' }
end
```    

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### custom

Test if a policy definition type is `Custom` or not.
```ruby
describe azure_policy_definition(name: 'my_policy') do
  it { should be_custom }
end
```
### exists

```ruby
# If we expect a resource to always exist

describe azure_policy_definition(name: 'my_policy', built_in: true ) do
  it { should exist }
end
# If we expect a resource to never exist

describe azure_policy_definition(name: 'my_policy') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
