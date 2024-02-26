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

Use the `azure_policy_definition` InSpec audit resource to test the properties and configuration of an Azure Policy definition.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` or the `resource_id` are required parameters.

```ruby
describe azure_policy_definition(name: 'MY_POLICY') do
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

`built_in` _Optional_
: Indicates whether the policy definition is built-in. Defaults to `false` if not supplied. This should not be used when `resource_id` is provided.

`resource_id`
: The unique resource ID.

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

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/policy/policy-definitions/get) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test a policy definition display name

```ruby
describe azure_policy_definition(name: 'MY_POLICY') do
  its('properties.displayName') { should cmp "Enforce 'owner' tag on resource groups" }
end
```

### Test a policy definition rule

```ruby
describe azure_policy_definition(name: 'MY_POLICY', built_in: true ) do
  its('properties.policyRule.then.effect') { should cmp 'deny' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### custom

Test if a policy definition type is `Custom` or not.

```ruby
describe azure_policy_definition(name: 'MY_POLICY') do
  it { should be_custom }
end
```

### exists

```ruby
# If we expect a resource to always exist.

describe azure_policy_definition(name: 'MY_POLICY', built_in: true ) do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_policy_definition(name: 'MY_POLICY') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
