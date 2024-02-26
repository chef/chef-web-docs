+++
title = "azure_policy_insights_query_result Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_policy_insights_query_result"
identifier = "inspec/resources/azure/azure_policy_insights_query_result Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_policy_insights_query_result` InSpec audit resource to test the properties and configuration of an Azure Policy Insights query result.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

The `policy_definition` and the `resource_id` are required parameters.

```ruby
describe azure_policy_insights_query_result(policy_definition: 'de875639-505c-4c00-b2ab-bb290dab9a54', resource_id: '/subscriptions/80b824de-ec53-4116-9868-3deeab10b0cd/resourcegroups/jfm-winimgbuilderrg2/providers/microsoft.virtualmachineimages/imagetemplates/win1021h1') do
  it { should exist }
end
```

```ruby
describe azure_policy_insights_query_result(policy_definition: 'de875639-505c-4c00-b2ab-bb290dab9a54', resource_id: '/subscriptions/80b824de-ec53-4116-9868-3deeab10b0cd/resourcegroups/jfm-winimgbuilderrg2/providers/microsoft.virtualmachineimages/imagetemplates/win1021h1') do
  it { should exist }
end
```

## Parameters

`policy_definition`
: Name of the policy definition. `policyDefinitionName`.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{resourceProviderId}`.

Submit both parameters for a valid query:

- `resource_id`
- `policy_definition`

## Properties

`resource_id`
: Resource ID.

`policy_assignment_id`
: Policy assignment ID.

`policy_definition_id`
: Policy definition ID.

`policy_assignment_name`
: Policy assignment name.

`policy_definition_name`
: Policy definition name.

`policy_definition_action`
: Policy definition action. For example, `effect`.

`compliance_state`
: Compliance state of the resource.

`effective_parameters`
: Effective parameters for the policy assignment.

`is_compliant`
: Flag indicating whether the resource is compliant against the policy assignment it was evaluated.

{{< note >}}

This property is deprecated; please use `ComplianceState` instead.

{{< /note >}}

`policy_assignment_owner`
: Policy assignment owner.

`policy_assignment_parameters`
: Policy assignment parameters.

`policy_assignment_scope`
: Policy assignment scope.

`subscription_id`
: Subscription ID.

`resource_type`
: Resource type.

`resource_location`
: Resource location.

`resource_group`
: Resource group name.

`resource_tags`
: List of resource tags.

`policy_definition_category`
: Policy definition category.

`management_group_ids`
: Comma separated list of management group IDs, which represent the hierarchy of the management groups the resource is part of.

`compliance_reason_code`
: Populated with the failure error code sometimes.

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/policy/policystates/listqueryresultsforsubscription#policystate) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test a policy definition resource type

```ruby
describe azure_policy_insights_query_result(policy_definition: 'de875639-505c-4c00-b2ab-bb290dab9a54',  resource_id: '/subscriptions/80b824de-ec53-4116-9868-3deeab10b0cd/resourcegroups/jfm-winimgbuilderrg2/providers/microsoft.virtualmachineimages/imagetemplates/win1021h1') do
  its('resourceType') { should eq 'Microsoft.VirtualMachineImages/imageTemplates' }
end
```

### Test a policy definition and policy assignment scope

```ruby
describe azure_policy_insights_query_result(policy_definition: 'de875639-505c-4c00-b2ab-bb290dab9a54', resource_id: '/subscriptions/80b824de-ec53-4116-9868-3deeab10b0cd/resourcegroups/jfm-winimgbuilderrg2/providers/microsoft.virtualmachineimages/imagetemplates/win1021h1') do
  its('policyAssignmentScope') { should cmp '/subscriptions/80b824de-ec53-4116-9868-3deeab10b0cd' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### compliant

Test if a policy definition type is `Compliant` or not.

```ruby
describe azure_policy_insights_query_result(policy_definition: 'de875639-505c-4c00-b2ab-bb290dab9a54', resource_id: '/subscriptions/80b824de-ec53-4116-9868-3deeab10b0cd/resourcegroups/jfm-winimgbuilderrg2/providers/microsoft.virtualmachineimages/imagetemplates/win1021h1') do
  it { should be_compliant }
end
```

### exists

```ruby
# If we expect a resource to always exist.

describe azure_policy_insights_query_result(policy_definition: 'de875639-505c-4c00-b2ab-bb290dab9a54', resource_id: '/subscriptions/80b824de-ec53-4116-9868-3deeab10b0cd/resourcegroups/jfm-winimgbuilderrg2/providers/microsoft.virtualmachineimages/imagetemplates/win1021h1') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_policy_insights_query_result(policy_definition: 'de875639-505c-4c00-b2ab-bb290dab9a54', resource_id: '/subscriptions/80b824de-ec53-4116-9868-3deeab10b0cd/resourcegroups/jfm-winimgbuilderrg2/providers/microsoft.virtualmachineimages/imagetemplates/win1021h1') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
