+++
title = "azure_migrate_project_event Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_project_event"
identifier = "inspec/resources/azure/azure_migrate_project_event Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_project_event` InSpec audit resource to test the properties related to an Azure Migrate project event.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group`, `project_name` and `name` are required parameters.

```ruby
describe azure_migrate_project_event(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_EVENT_NAME') do
  it                             { should exist }
  its('properties.instanceType') { should eq 'SERVERS' }
end
```

```ruby
describe azure_migrate_project_event(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_EVENT_NAME') do
  it  { should exist }
end
```

## Parameters

`name`
: Name of the Azure Migrate project event to test.

`resource_group`
: Azure resource group that the targeted resource resides in.

`project_name`
: Azure Migrate assessment project name.

The parameter set should be provided for a valid query:

- `resource_group`, `project_name`, and `name`.

## Properties

`id`
: Path reference to the Migrate project event.

`name`
: Unique name of a Migrate project event.

`type`
: Type of the object. `Microsoft.Migrate/MigrateProjects/Databases`.

`properties`
: Properties of the assessment.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/projects/events/get-event) for other properties available.

Any attribute in the response nested within properties is accessed with the key names separated by dots (`.`), and attributes nested in the assessmentData are pluralized and listed as a collection.

## Examples

**Test that the migrate project event is of servers instanceType.**

```ruby
describe azure_migrate_project_event(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_EVENT_NAME') do
  its('properties.instanceType') { should eq 'SERVERS' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a migrate project event is found, it will exist
describe azure_migrate_project_event(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_EVENT_NAME') do
  it { should exist }
end
# if migrate project event is not found, it will not exist
describe azure_migrate_project_event(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_EVENT_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
