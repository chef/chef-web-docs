+++
title = "azure_migrate_assessment_group Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_assessment_group"
identifier = "inspec/resources/azure/azure_migrate_assessment_group Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_assessment_group` InSpec audit resource to test the properties related to an Azure Migrate assessment group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name`, `project_name`, and `resource_group` are required parameters.

```ruby
describe azure_migrate_assessment_group(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'GROUP_NAME') do
  it                                      { should exist }
  its('name')                             { should eq 'GROUP_NAME' }
  its('type')                             { should cmp 'Microsoft.Migrate/assessmentProjects/groups' }
end
```

```ruby
describe azure_migrate_assessment_group(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'GROUP_NAME') do
  it  { should exist }
end
```

## Parameters

`name`
: Name of the Azure Migrate assessment group to test.

`resource_group`
: Azure resource group that the targeted resource resides in.

`project_name`
: Azure Migrate assessment project.

The parameter set should be provided for a valid query:

- `resource_group`, `project_name`, and `name`.

## Properties

`id`
: Path reference to the group.

`name`
: Name of the group.

`type`
: Object type. `Microsoft.Migrate/assessmentProjects/groups`.

`eTag`
: For optimistic concurrency control.

`properties`
: Properties of the group.

`properties.areAssessmentsRunning`
: If the assessments are in running state.

`properties.assessments`
: List of references to assessments created on this group.

`properties.machineCount`
: Number of machines part of this group.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/assessment/groups/get) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test the migrate assessment group has at least 5 machines.**

```ruby
describe azure_migrate_assessment_group(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'GROUP_NAME') do
  its('properties.machineCount') { should be >= 5 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a Migrate Assessment Group is found, it will exist
describe azure_migrate_assessment_group(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'GROUP_NAME') do
  it { should exist }
end
# if Migrate Assessment Group is not found, it will not exist
describe azure_migrate_assessment_group(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'GROUP_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
