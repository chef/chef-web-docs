+++
title = "azure_policy_assignments Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_policy_assignments"
identifier = "inspec/resources/azure/azure_policy_assignments Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_policy_assignments` InSpec resource to examine assignments of Azure policy to resources and resource groups.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

```ruby
describe azure_policy_assignments do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

Please review the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/policy/policyassignments/list#policyassignment) for a full description of the available properties.

`ids`
: The ID of this policy assignment.

: **Filter**: id

`types`
: The Azure resource type.

: **Filter**: type

`names`
: The names of the policy assignments.

: **Filter**: name

`locations`
: The locations of the policy assignments.

: **Filter**: location

`tags`
: The tags of the policy assignments.

: **Filter**: tags

`displayNames`
: The display names of the policy assignments.

: **Filter**: displayName

`policyDefinitionIds`
: The IDs of the policies being assigned by these policy assignments.

: **Filter**: policyDefinitionId

`scopes`
: The scope of the policy assignments (which resources they are being attached to).

: **Filter**: scope

`notScopes`
: The scopes which are excluded from these policy assignments (blocks inheritance).

: **Filter**: notScopes

`parameters`
: The override parameters passed to the base policy by this assignment.

: **Filter**: parameters

`enforcementMode`
: The enforcement modes of these policy assignments.

: **Filter**: enforcementModes

`assignedBys`
: The IDs that assigned these policies.

: **Filter**: assignedBy

`parameterScopes`
: Unknown - no data observed in this field in the wild.

: **Filter**: parameterScopes

`created_bys`
: The IDs that created these policy assignments.

: **Filter**: created_by

`createdOns`
: The dates these policy assignments were created (as a Ruby Time object).

: **Filter**: createdOn

`updatedBys`
: The IDs that updated these policy assignments.

: **Filter**: updatedBy

`updatedOns`
: The dates these policy assignments were updated (as a Ruby Time object).

: **Filter**: updatedOn

`identityPrincipalIds`
: The principal IDs of the associated managed identities.

: **Filter**: identityPrincipalId

`identityTenantIds`
: The tenant IDs of the associated managed identities.

: **Filter**: identityTenantId

`identityTypes`
: The identity types of the associated managed identities.

: **Filter**: identityType

## Examples

**Check that all assigned policies are in enforcing mode.**

```ruby
describe azure_policy_assignments.where{ enforcement_mode == 'DoNotEnforce' } do
    it {should_not exist}
    its('display_names') {should eq []}
end
```

**Check that no policies were modified in the last 30 days.**

```ruby
last_30_days = Time.now() - (60*60*24*30)

describe azure_policy_assignments.where{ (updatedOn > last_30_days) || (createdOn > last_30_days) } do
  it {should_not exist}
  its('ids') {should eq []}
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
