+++
title = "azure_migrate_assessment_machine Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_assessment_machine"
identifier = "inspec/resources/azure/azure_migrate_assessment_machine Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_assessment_machine` InSpec audit resource to test properties related to an Azure Migrate assessment machine.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name`, `project_name` and `resource_group`  are required parameters.

```ruby
describe azure_migrate_assessment_machine(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME' name: 'MIGRATE_ASSESSMENT_MACHINE_NAME') do
  it                                      { should exist }
  its('name')                             { should eq 'zoneA_machines_migrate_assessment' }
  its('type')                             { should eq 'Microsoft.Migrate/assessmentprojects/machines' }
end
```

```ruby
describe azure_migrate_assessment_machine(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME' name: 'MIGRATE_ASSESSMENT_MACHINE_NAME') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_

: Name of the Azure Migrate assessment machine to test.

`resource_group` _(required)_

: Azure resource group that the targeted resource resides in.

`project_name` _(required)_

: The Azure Migrate Assessment Project.

## Properties

`id`
: Path reference to the assessment.

`name`
: Unique name of an assessment.

`type`
: Type of the object. `Microsoft.Migrate/assessmentprojects/machines`.

`eTag`
: For optimistic concurrency control.

`properties`
: Properties of the assessment.

`properties.bootType`
: Boot type of the machine.

`properties.megabytesOfMemory`
: Memory in Megabytes.

`properties.numberOfCores`
: Processor count.

`properties.operatingSystemType`
: Operating System type of the machine.


For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/assessment/machines/get) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test the Boot Type of Migrate assessment machine.**

```ruby
describe azure_migrate_assessment_machine(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME', name: 'MIGRATE_ASSESSMENT_MACHINE_NAME') do
  its('properties.bootType') { should eq 'BIOS' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a Migrate assessment machine is found it exists

describe azure_migrate_assessment_machine(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME' name: 'MIGRATE_ASSESSMENT_MACHINE_NAME') do
  it { should exist }
end

# if Migrate assessment machine is not found it does not exist

describe azure_migrate_assessment_machine(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME' name: 'MIGRATE_ASSESSMENT_MACHINE_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
