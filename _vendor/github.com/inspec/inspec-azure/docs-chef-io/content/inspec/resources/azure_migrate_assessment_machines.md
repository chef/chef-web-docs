+++
title = "azure_migrate_assessment_machines Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_assessment_machines"
identifier = "inspec/resources/azure/azure_migrate_assessment_machines Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_assessment_machines` InSpec audit resource to test properties related to all Azure Migrate assessment machines within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_migrate_assessment_machines` resource block returns all Azure Migrate assessment machines within a project.

```ruby
describe azure_migrate_assessment_machines(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group` _(required)_

: Azure resource group that the targeted resource resides in.

`project_name` _(required)_

: The Azure Migrate Assessment Project.

## Properties

`ids`
: Path reference to the assessment machines.

: **Field**: `id`

`names`
: Unique names for all assessment machines.

: **Field**: `name`

`types`
: Type of the objects.

: **Field**: `type`

`eTags`
: A list of eTags for all the assessment machines.

: **Field**: `eTag`

`properties`
: A list of properties for all the assessment machines.

: **Field**: `properties`

`bootTypes`
: A list of boot type of the machines.

: **Field**: `bootType`

`createdTimestamps`
: Times when this machine was created.

: **Field**: `createdTimestamp`

`datacenterManagementServerArmIds`
: A list of ARM IDs of the data center as tracked by the Microsoft.OffAzure.

: **Field**: `datacenterManagementServerArmId`

`datacenterManagementServerNames`
: Name of the servers hosting the datacenter management solution.

: **Field**: `datacenterManagementServerName`

`descriptions`
: Descriptions of all the machines.

: **Field**: `description`

`discoveryMachineArmIds`
: A list of ARM IDs of the machine as tracked by the Microsoft.OffAzure.

: **Field**: `discoveryMachineArmId`

`disks`
: Dictionary of disks attached to all the machines. Key is ID of disk. Value is a disk object.

: **Field**: `disks`

`displayNames`
: User readable names of all the machines as defined by the user in their private datacenter.

: **Field**: `displayName`

`groups`
: A List of references to the groups that the machine is member of.

: **Field**: `groups`

`megabytesOfMemories`
: A list of Memories in Megabytes.

: **Field**: `megabytesOfMemory`

`networkAdapters`
: Dictionary of network adapters attached to all the machines. Key is ID of network adapter. Value is a network adapter object.

: **Field**: `networkAdapters`

`numberOfCores`
: Processor counts.

: **Field**: `numberOfCores`

`operatingSystemTypes`
: Operating system types of all the machines.

: **Field**: `operatingSystemType`

`operatingSystemNames`
: Operating system names of all the machines.

: **Field**: `operatingSystemName`

`operatingSystemVersions`
: Operating system versions of all the machines.

: **Field**: `operatingSystemVersion`

`updatedTimestamps`
: Time when the machines were last updated.

: **Field**: `updatedTimestamp`

{{% inspec_filter_table %}}

## Examples

**Loop through Migrate assessment machines by their names.**

```ruby
azure_migrate_assessment_machines(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME').names.each do |name|
  describe azure_migrate_assessment_machine(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME', group_name: 'MACHINE_GROUP_NAME', name: name) do
    it { should exist }
  end
end
```

**Test that there are Migrate assessment machines with BIOS boot type.**

```ruby
describe azure_migrate_assessment_machines(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME').where(bootType: 'BIOS') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no Migrate assessment machines are present in the project and in the resource group

describe azure_migrate_assessment_machines(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME') do
  it { should_not exist }
end

# Should exist if the filter returns at least one Migrate assessment machines in the project and in the resource group

describe azure_migrate_assessment_machines(resource_group: 'RESOURCE_GROUP', project_name: 'MIGRATE_ASSESSMENT_PROJECT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
