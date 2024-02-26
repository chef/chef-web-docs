+++
title = "azure_migrate_assessment_project Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_assessment_project"
identifier = "inspec/resources/azure/azure_migrate_assessment_project Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_assessment_project` InSpec audit resource to test the properties related to an Azure Migrate assessment project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` and `resource_group` are required parameters.

```ruby
describe azure_migrate_assessment_project(resource_group: 'RESOURCE_GROUP', name: 'ASSESSMENT_PROJECT_NAME') do
  it                                      { should exist }
  its('name')                             { should cmp 'ASSESSMENT_PROJECT_NAME' }
  its('type')                             { should cmp 'Microsoft.Migrate/assessmentprojects' }
end
```

```ruby
describe azure_migrate_assessment_project(resource_group: 'RESOURCE_GROUP', name: 'ASSESSMENT_PROJECT_NAME') do
  it  { should exist }
end
```

## Parameters

`name`
: Name of the Azure Migrate assessment project to test.

`resource_group`
: Azure resource group where the targeted project resides.

The parameter set that should be provided for a valid query is `resource_group` and `name`.

## Properties

`id`
: Path reference to the project.

`name`
: Project name.

`type`
: Type of the object.

`eTag`
: For optimistic concurrency control.

`properties`
: Properties of the project.

`location`
: Azure location in which the project is created.

`properties.assessmentSolutionId`
: Assessment solution ARM ID tracked by `Microsoft.Migrate/migrateProjects`.

`properties.customerStorageAccountArmId`
: The ARM ID of the storage account is used for interactions when public access is disabled.

`properties.privateEndpointConnections`
: The list of private endpoint connections to the project.

`properties.numberOfMachines`
: Number of machines in the project.

`tags`
: Tags provided by Azure Tagging service.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to the [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Refer to the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/assessment/projects/get) for other properties available. Access any attribute in the response by separating the key names with a period (`.`).

## Examples

### Test that the migrate assessment project has a minimum scaling factor

```ruby
describe azure_migrate_assessment_project(resource_group: 'RESOURCE_GROUP', name: 'ASSESSMENT_PROJECT_NAME') do
  its('properties.numberOfGroups') { should eq 2 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a Migrate Assessment project is found, it will exist.

describe azure_migrate_assessment_project(resource_group: 'RESOURCE_GROUP', name: 'ASSESSMENT_PROJECT_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If Migrate Assessment project is not found, it will not exist.

describe azure_migrate_assessment_project(resource_group: 'RESOURCE_GROUP', name: 'ASSESSMENT_PROJECT_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
