+++
title = "azure_migrate_assessment_groups Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_assessment_groups"
identifier = "inspec/resources/azure/azure_migrate_assessment_groups Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_assessment_groups` InSpec audit resource to test the properties related to all Azure Migrate assessment groups within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_migrate_assessment_groups` resource block returns all Azure Migrate assessment groups within a project.

```ruby
describe azure_migrate_assessment_groups(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`project_name`
: Azure Migrate assessment project.

The parameter set that should be provided for a valid query is `resource_group` and `project_name`.

## Properties

`ids`
: Path reference to all the groups.

: **Field**: `id`

`names`
: Unique names for all groups.

: **Field**: `name`

`types`
: Type of the objects.

: **Field**: `type`

`eTags`
: A list of eTags for all the groups.

: **Field**: `eTag`

`properties`
: A list of properties for all the groups.

: **Field**: `properties`

`areAssessmentsRunnings`
: A list of boolean describing the assessment run state.

: **Field**: `areAssessmentsRunning`

`assessments`
: List of references to assessments created on this group.

: **Field**: `assessments`

`createdTimestamps`
: List of creation times of the groups.

: **Field**: `createdTimestamp`

`groupStatuses`
: List of creation status of the groups.

: **Field**: `groupStatus`

`groupTypes`
: List of group types.

: **Field**: `groupType`

`machineCounts`
: List of machine counts.

: **Field**: `machineCount`

`updatedTimestamps`
: List of updated timestamps of the groups.

: **Field**: `updatedTimestamp`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through migrate assessment groups by their names

```ruby
azure_migrate_assessment_groups(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').names.each do |name|
  describe azure_migrate_assessment_group(resource_group: `RESOURCE_GROUP`, project_name: `PROJECT_NAME`, name: `NAME`) do
    it { should exist }
  end
end
```

### Test that the assessments are running for migrating assessment groups

```ruby
describe azure_migrate_assessment_groups(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').where(areAssessmentsRunning: true) do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Migrate Assessment groups are present in the project.

describe azure_migrate_assessment_groups(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Migrate Assessment groups in the project.

describe azure_migrate_assessment_groups(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
