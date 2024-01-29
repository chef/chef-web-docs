+++
title = "azure_migrate_project_database Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_project_database"
identifier = "inspec/resources/azure/azure_migrate_project_database Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_project_database` InSpec audit resource to test the properties related to an Azure Migrate Project database.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` is a required parameter and `resource_group` is an optional parameter.

```ruby
describe azure_migrate_project_database(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_DB_NAME') do
  it                                      { should exist }
  its('name')                             { should eq 'PROJECT_DB_NAME' }
  its('type')                             { should eq 'Microsoft.Migrate/MigrateProjects/Databases' }
  its('solutionNames')                    { should include 'MIGRATEDBSOLUTION' }
end
```

```ruby
describe azure_migrate_project_database(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_DB_NAME') do
  it  { should exist }
end
```

## Parameters

`name`
: Name of the Azure Migrate project database to test.

`resource_group`
: Azure resource group where the targeted resource resides.

`project_name`
: Azure Migrate assessment project.

The parameter set should be provided for a valid query are `resource_group`, `project_name`, and `name`.

## Properties

`id`
: Path reference to the migrate project database.

`name`
: Unique name of a migrate project database.

`type`
: Type of the object. `Microsoft.Migrate/MigrateProjects/Databases`.

`properties`
: Properties of the assessment.

`properties.assessmentData`
: Assessment details of the database published by various sources.

`assessmentIds`
: The database assessment scope/IDs.

`migrationBlockersCounts`
: The number of blocking changes found.

`breakingChangesCounts`
: The number of breaking changes found.

`assessmentTargetTypes`
: The assessed target database types.

`solutionNames`
: The names of the solutions that sent the data.

`instanceIds`
: The database servers' instance IDs.

`databaseNames`
: The name of the databases.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/projects/databases/get-database) for other properties available. Any attribute in the response nested within properties is accessed with the key names separated by dots (`.`), and attributes nested in the assessmentData are pluralized and listed as a collection.

## Examples

### Test that Migrate Project database has a SQL 'assessmentTargetType'

```ruby
describe azure_migrate_project_database(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_DB_NAME') do
  its('assessmentTargetTypes') { should include 'SQL' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a Migrate Project database is found, it will exist.

describe azure_migrate_project_database(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_DB_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# if Migrate Project Database is not found, it will not exist.

describe azure_migrate_project_database(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'PROJECT_DB_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
