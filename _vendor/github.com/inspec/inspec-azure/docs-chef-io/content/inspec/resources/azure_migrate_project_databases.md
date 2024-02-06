+++
title = "azure_migrate_project_databases Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_project_databases"
identifier = "inspec/resources/azure/azure_migrate_project_databases Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_project_databases` InSpec audit resource to test the properties of all Azure Migrate Project databases within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_migrate_project_databases` resource block returns all Azure Migrate Project databases within a project.

```ruby
describe azure_migrate_project_databases(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`project_name`
: Azure Migrate Project.

The parameter set should be provided for a valid query is`resource_group` and `project_name`.

## Properties

`ids`
: Path reference to the project databases.

: **Field**: `id`

`names`
: Unique names for all project databases.

: **Field**: `name`

`types`
: Type of the objects.

: **Field**: `type`

`properties`
: A list of Properties for all the project databases.

: **Field**: `properties`

`assessmentDatas`
: The assessment details of the database published by various sources.

: **Field**: `assessmentData`

`assessmentIds`
: The database assessment scopes/IDs.

: **Field**: `assessmentId`

`assessmentTargetTypes`
: The assessed target database types.

: **Field**: `assessmentTargetType`

`breakingChangesCounts`
: The number of breaking changes found.

: **Field**: `breakingChangesCount`

`compatibilityLevels`
: The compatibility levels of the database.

: **Field**: `compatibilityLevel`

`databaseNames`
: The database names.

: **Field**: `databaseName`

`databaseSizeInMBs`
: The sizes of the databases.

: **Field**: `databaseSizeInMB`

`enqueueTimes`
: The list of times the message is enqueued.

: **Field**: `enqueueTime`

`extendedInfos`
: The extended properties of all the database.

: **Field**: `extendedInfo`

`instanceIds`
: The database server instance IDs.

: **Field**: `instanceId`

`isReadyForMigrations`
: The values indicating whether the database is ready for migration.

: **Field**: `isReadyForMigration`

`lastAssessedTimes`
: The time when the databases were last assessed.

: **Field**: `lastAssessedTime`

`lastUpdatedTimes`
: The time of the last modifications of the database details.

: **Field**: `lastUpdatedTime`

`migrationBlockersCounts`
: The number of blocking changes found.

: **Field**: `migrationBlockersCount`

`solutionNames`
: The names of the solution that sent the data.

: **Field**: `solutionName`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through Migrate Project databases by their names

```ruby
azure_migrate_project_databases(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').names.each do |name|
  describe azure_migrate_project_database(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'NAME') do
    it { should exist }
  end
end
```

### Test there are Migrate Project databases are ready for migration

```ruby
describe azure_migrate_project_databases(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').where{ isReadyForMigration.include?(true) } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Migrate Project databases are present in the project and the resource group.

describe azure_migrate_project_databases(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Migrate project databases in the project and the resource group.

describe azure_migrate_project_databases(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
