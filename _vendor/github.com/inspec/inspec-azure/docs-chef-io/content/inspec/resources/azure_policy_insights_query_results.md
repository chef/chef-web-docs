+++
title = "azure_policy_insights_query_results Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_policy_insights_query_results"
identifier = "inspec/resources/azure/azure_policy_insights_query_results Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_policy_insights_query_results` InSpec audit resource to test properties and configuration of multiple Azure Policy Insights query results.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_policy_insights_query_results` resource block returns all policy insights query results, either compliant, or not within a subscription.

```ruby
describe azure_policy_insights_query_results do
  it { should exist }
end
```

or

```ruby
describe azure_policy_insights_query_results do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`resource_ids`
: A list of the unique resource IDs.

: **Field**: `resource_id`

`policy_assignment_ids`
: A list of all Policy assignment IDs.

: **Field**: `policyAssignment_id`

`policy_definition_ids`
: A list of all Policy definition IDs.

: **Field**: `policyDefinition_id`

`is_compliant`
: A list of boolean flags which states whether the resource is compliant or not.

: **Field**: `is_compliant`

`subscription_ids`
: A list of Subscription IDs.

: **Field**: `subscription_id`

`resource_types`
: A list of Resource types.

: **Field**: `resource_type`

`resource_locations`
: A list of Resource locations.

: **Field**: `resource_location`

`resource_groups`
: A list of Resource group names.

: **Field**: `resource_group`

`resource_tags`
: A list of resource tags.

: **Field**: `resource_tags`

`policy_assignment_names`
: A list of Policy assignment names.

: **Field**: `policy_assignment_name`

`policy_definition_names`
: A list of Policy definition names.

: **Field**: `policy_definition_name`

`policy_assignment_scopes`
: A list of Policy assignment scopes.

: **Field**: `policy_assignment_scope`

`policy_assignment_parameters`
: A list of policy assignment parameter.

: **Field**: `policy_assignment_parameters`

`policy_definition_actions`
: A list of Policy definition actions.

: **Field**: `policy_definition_action`

`policy_definition_categories`
: A list of Policy definition categories.

: **Field**: `policy_definition_category`

`management_group_ids`
: A list of management group IDs.

: **Field**: `management_group_ids`

`compliance_states`
: A list compliance state of the resource.

: **Field**: `compliance_state`

`compliance_reason_codes`
: A list of reason codes recorded for failure.

: **Field**: `compliance_reason_code`

{{% inspec_filter_table %}}

## Examples

**Check if a specific resource type is present.**

```ruby
describe azure_policy_insights_query_results do
  its('resource_types')  { should include 'Microsoft.VirtualMachineImages/imageTemplates' }
end
```

**Filters the results to include only those Policy Insights query results which include the given resource location.**

```ruby
describe azure_policy_insights_query_results.where(resource_location: 'RESOURCE_LOCATION') do
  it { should exist }
end
```

**Filters the results to include only the compliant Policy Insights query results.**

```ruby
describe azure_policy_insights_query_results.where(is_compliant: true) do
  it { should exist }
  its('count') { should be 120  }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_policy_insights_query_results do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
