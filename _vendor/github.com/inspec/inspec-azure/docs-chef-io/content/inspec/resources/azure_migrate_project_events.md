+++
title = "azure_migrate_project_events Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_project_events"
identifier = "inspec/resources/azure/azure_migrate_project_events Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_project_events` InSpec audit resource to test the properties related to all Azure Migrate project events within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_migrate_project_events` resource block returns all Azure Migrate project events within a project.

```ruby
describe azure_migrate_project_events(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in.

`project_name`
: Azure Migrate Project.

The parameter set should be provided for a valid query:

- `resource_group` and `project_name`.

## Properties

`ids`
: Path reference to the project events.

: **Field**: `id`

`names`
: Unique names for all project events.

: **Field**: `name`

`types`
: Type of the objects.

: **Field**: `type`

`properties`
: A list of properties for all the project events.

: **Field**: `properties`

`instanceTypes`
: The instance types.

: **Field**: `instanceType`

`machines`
: The machines for which the error is reported.

: **Field**: `machine`

`errorCodes`
: The error codes.

: **Field**: `errorCode`

`errorMessages`
: The error messages.

: **Field**: `errorMessage`

`recommendations`
: The recommendations for the error.

: **Field**: `recommendation`

`possibleCauses`
: The possible causes for the error.

: **Field**: `possibleCause`

`solutions`
: The solutions for which the error is reported.

: **Field**: `solution`

`clientRequestIds`
: The client request Ids of the payload for which the event is reported.

: **Field**: `clientRequestId`

{{% inspec_filter_table %}}

For more details on the available properties, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/projects/events/enumerate-events).

## Examples

**Loop through migrate project events by their names.**

```ruby
azure_migrate_project_events(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').names.each do |name|
  describe azure_migrate_project_event(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: `PROJECT_EVENT_NAME`) do
    it { should exist }
  end
end
```

**Test that there are migrate project events for databases.**

```ruby
describe azure_migrate_project_events(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').where(instanceType: 'Databases') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist, if no migrate project events are present in the project and in the resource group
describe azure_migrate_project_events(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should_not exist }
end
# Should exist, if the filter returns at least one migrate project events in the project and in the resource group
describe azure_migrate_project_events(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
