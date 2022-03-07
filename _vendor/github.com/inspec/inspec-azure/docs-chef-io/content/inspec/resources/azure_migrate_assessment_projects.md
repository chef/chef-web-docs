+++
title = "azure_migrate_assessment_projects Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_assessment_projects"
identifier = "inspec/resources/azure/azure_migrate_assessment_projects Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_assessment_projects` InSpec audit resource to test the properties related to all Azure Migrate assessment projects within a subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_migrate_assessment_projects` resource block returns all Azure Migrate projects within a subscription.

```ruby
describe azure_migrate_assessment_projects do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: Path reference to the projects.

: **Field**: `id`

`names`
: Name of the projects.

: **Field**: `name`

`types`
: Type of the project.

: **Field**: `type`

`eTags`
: A list of eTags for all the assessments.

: **Field**: `eTag`

`locations`
: Azure locations in which project is created.

: **Field**: `location`

`tags`
: A list of Tags provided by Azure Tagging service.

: **Field**: `tags`

`properties`
: A list of Properties for all the projects.

: **Field**: `properties`

`assessmentSolutionIds`
: Assessment solution ARM ids tracked by `Microsoft.Migrate/migrateProjects`.

: **Field**: `assessmentSolutionId`

`createdTimestamps`
: Times when this project was created. Date-Time represented in ISO-8601 format.

: **Field**: `createdTimestamp`

`customerStorageAccountArmIds`
: The ARM ids of the storage account used for interactions when public access is disabled.

: **Field**: `customerStorageAccountArmId`

`customerWorkspaceIds`
: The ARM ids of service map workspace created by customer.

: **Field**: `customerWorkspaceId`

`customerWorkspaceLocations`
: Locations of service map workspace created by customer.

: **Field**: `customerWorkspaceLocation`

`lastAssessmentTimestamps`
: Times when last assessment is created.

: **Field**: `lastAssessmentTimestamp`

`numberOfAssessments`
: Number of assessments created in the project.

: **Field**: `numberOfAssessments`

`numberOfGroups`
: Number of groups created in all the projects.

: **Field**: `numberOfGroups`

`numberOfMachines`
: Number of machines in all the projects.

: **Field**: `numberOfMachines`

`privateEndpointConnections`
: The list of private endpoint connections to the projects.

: **Field**: `privateEndpointConnections`

`projectStatuses`
: Assessment project statuses.

: **Field**: `projectStatus`

`provisioningStates`
: Provisioning states of all the projects.

: **Field**: `provisioningState`

`publicNetworkAccesses`
: Public Network Access for all the projects.

: **Field**: `publicNetworkAccess`

`serviceEndpoints`
: Service Endpoints of all the projects.

: **Field**: `serviceEndpoint`

`updatedTimestamps`
: Times when this project is last updated.

: **Field**: `updatedTimestamp`

{{% inspec_filter_table %}}

## Examples

**Loop through migrate assessment projects by their names.**

```ruby
azure_migrate_assessment_projects.names.each do |name|
  describe azure_migrate_assessment_project(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

**Test to ensure that migrate assessment projects in West Europe location.**

```ruby
describe azure_migrate_assessment_projects.where(location: 'westeurope') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no Migrate Assessment Projects are present in the subscription

describe azure_migrate_assessment_projects do
  it { should_not exist }
end

# Should exist if the filter returns at least one Migrate Assessment Projects in the subscription

describe azure_migrate_assessment_projects do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
