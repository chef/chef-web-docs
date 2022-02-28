+++
title = "azure_migrate_project_database_instance Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_project_database_instance"
identifier = "inspec/resources/azure/azure_migrate_project_database_instance Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_project_database_instance` InSpec audit resource to test properties of a single Azure Migrate project database instance.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

```ruby
describe azure_migrate_project_database_instance(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'DB_NAME') do
  it                                      { should exist }
  its('name')                             { should eq 'sql_db' }
  its('type')                             { should eq 'Microsoft.Migrate/MigrateProjects/DatabaseInstances' }
  its('solutionNames')                    { should include 'migrateDBSolution' }
end
```

```ruby
describe azure_migrate_project_database_instance(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'DB_NAME') do
  it  { should exist }
end
```

## Parameters


`name` _(required)_

: Unique name of a database in Azure migration hub.

`resource_group` _(required)_

: Name of the Azure Resource Group that migrate project is part of.

`project_name` _(required)_

: Name of the Azure Migrate project.

## Properties

`id`
: Path reference to the Migrate project database instance.

`name`
: Unique name of an Migrate project database instance.

`type`
: Type of the object. `Microsoft.Migrate/MigrateProjects/Databases`.

`properties`
: The properties of the machine.

`properties.discoveryData`
: The assessment details of the database instance published by various sources.

`properties.summary`
: The database instances summary per solution.

`enqueueTimes`
: The times the message were enqueued.

`extendedInfos`
: The extended properties of the database server.

`hostNames`
: The host names of the database servers.

`instanceIds`
: The database instance IDs.

`instanceNames`
: The database instance names.

`instanceTypes`
: The database instance types.

`instanceVersions`
: The database instance versions.

`ipAddresses`
: The IP addresses of the database server. IP addresses could be IPv4 or IPv6.

`lastUpdatedTimes`
: The time of the last modification of the database instance details.

`portNumbers`
: The port numbers of the database server.

`solutionNames`
: The names of the solution that sent the data.


For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/projects/databases/get-database) for other properties available.
Any attribute in the response nested within properties may be accessed with the key names separated by dots (`.`) and attributes nested in the assessment data is pluralized and listed as collection.

## Examples

**Test that the Migrate project database instance has a SQL instanceType.**

```ruby
describe azure_migrate_project_database_instance(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'DB_NAME') do
  its('instanceTypes') { should include 'SQL' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a Migrate project database instance is found it will exist

describe azure_migrate_project_database_instance(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'DB_NAME') do
  it { should exist }
end
# if Migrate project database instance is not found it will not exist

describe azure_migrate_project_database_instance(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: 'DB_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
