+++
title = "azure_migrate_project_solution Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_project_solution"
identifier = "inspec/resources/azure/azure_migrate_project_solution Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_project_solution` InSpec audit resource to test the properties related to an Azure Migrate Project Solution.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name` and `resource_group` are required parameters.

```ruby
describe azure_migrate_project_solution(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_SOLUTION_NAME') do
  it                                      { should exist }
  its('name')                             { should cmp 'PROJECT_SOLUTION_NAME' }
  its('type')                             { should cmp 'Microsoft.Migrate/MigrateProjects/Solutions' }
end
```

```ruby
describe azure_migrate_project_solution(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_SOLUTION_NAME') do
  it  { should exist }
end
```

## Parameters

`name`
: Name of the Azure Migrate project solution to test.

`resource_group`
: Azure resource group that the targeted resource resides in.

`project_name`
: Azure Migrate project.

The parameter set should be provided for a valid query:

- `resource_group`, `project_name`, and `name`.

## Properties

`id`
: Path reference to the project solution.

`name`
: Unique name of the project solution.

`type`
: Object type. `Microsoft.Migrate/MigrateProjects/Solutions`.

`eTag`
: For optimistic concurrency control.

`properties`
: Properties of the project Solution.

`properties.cleanupState`
: The cleanup state of the solution.

`properties.details`
: The details of the solution.

`properties.summary`
: The summary of the solution.

`properties.purpose`
: The purpose of the solution.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/projects/solutions/get-solution) for other properties available. Any attribute in the response is accessed with the key names separated by dots (`.`).

## Examples

**Test that the migrate project solution is defined for assessment.**

```ruby
describe azure_migrate_project_solution(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_SOLUTION_NAME') do
  its('properties.purpose') { should eq 'ASSESSMENT' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a Migrate Project Solution is found, it will exist
describe azure_migrate_project_solution(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_SOLUTION_NAME') do
  it { should exist }
end

# if Migrate Project Solution are not found, it will not exist
describe azure_migrate_project_solution(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_SOLUTION_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
