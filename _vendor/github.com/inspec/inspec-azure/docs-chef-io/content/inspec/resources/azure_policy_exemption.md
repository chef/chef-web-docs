+++
title = "azure_policy_exemption Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_policy_exemption"
identifier = "inspec/resources/azure/azure_policy_exemption Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_policy_exemption` InSpec audit resource to test the properties related to an Azure Policy Exemption.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_policy_exemption(resource_group: 'RESOURCE_GROUP', name: 'POLICY_EXEMPTION_NAME') do
  it                                      { should exist }
  its('name')                             { should cmp '3b8b3f3bbec24cd6af583694' }
  its('type')                             { should cmp 'Microsoft.Authorization/policyExemptions' }
  its('properties.exemptionCategory')     { should cmp 'Waiver' }
  its('properties.policyAssignmentId')    { should cmp '/subscriptions/ae640e6b-ba3e-4256-9d62-2993eecfa6f2/providers/Microsoft.Authorization/policyAssignments/CostManagement' }
  its('systemData.createdByType')         { should cmp 'User' }
end
```

```ruby
describe azure_policy_exemption(name: 'POLICY_EXEMPTION_NAME') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_

: The name of the Azure Policy Exemption to test.

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`id`
: Resource ID.

`name`
: Policy Exemption Name.

`type`
: Resource type.

`properties.policyAssignmentId`
: The ID of the policy assignment that is being exempted.

`properties.policyDefinitionReferenceIds`
: The policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition.

`properties.exemptionCategory`
: The policy exemption category. Possible values are `Waiver` and `Mitigated`.

`properties.displayName`
: The display name of the policy exemption.

`properties.description`
: The description of the policy exemption.

`systemData.createdBy`
: The identity that created the resource.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/policy/policy-exemptions/get) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test that the policy exemption category is `Waiver`

```ruby
describe azure_policy_exemption(name: 'POLICY_EXEMPTION_NAME') do
  its('properties.exemptionCategory') { should eq 'Waiver' }
end
```

### Test that the definition reference ID list includes a particular reference ID

```ruby
describe azure_policy_exemption(resource_group: 'RESOURCE_GROUP', name: 'POLICY_EXEMPTION_NAME') do
  its('properties.policyDefinitionReferenceIds') { should include 'POLICY_DEFINITION_REFERENCE_ID' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a policy exemption is found, it will exist.

describe azure_policy_exemption(name: 'POLICY_EXEMPTION_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# policy exemptions that aren't found will not exist.

describe azure_policy_exemption('3b8b3f3bbec24cd6af583694') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
