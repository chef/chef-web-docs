+++
title = "azure_migrate_project_database_instances Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_project_database_instances"
identifier = "inspec/resources/azure/azure_migrate_project_database_instances Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_project_database_instances` InSpec audit resource to test properties of all Azure Migrate project database instances in a migrate project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_migrate_project_database_instances` resource block returns all Azure Migrate project database instances within a project.

```ruby
describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group` _(required)_

: Name of the Azure Resource Group that migrate project is part of.

`project_name` _(required)_

: Name of the Azure Migrate project.

## Properties

`ids`
: Path reference to the project database instances.

: **Field**: `id`

`names`
: Unique names for all project database instances.

: **Field**: `name`

`types`
: Type of the objects.

: **Field**: `type`

`properties`
: A list of properties for all the project database instances.

: **Field**: `properties`

`discoveryDatas`
: The assessment details of the database published by various sources.

: **Field**: `assessmentData`

`summaries`
: The database instances summaries per solution.

: **Field**: `summary`

`lastUpdatedTimes`
: The time of the last modification of the database instance details.

: **Field**: `lastUpdatedTime`

`enqueueTimes`
: The times the message were enqueued.

: **Field**: `enqueueTimes`

`extendedInfos`
: The extended properties of the database servers.

: **Field**: `extendedInfos`

`hostNames`
: The host names of the database servers.

: **Field**: `hostNames`

`instanceIds`
: The database instance IDs.

: **Field**: `instanceIds`

`instanceNames`
: The database instance names.

: **Field**: `instanceNames`

`instanceTypes`
: The database instance types.

: **Field**: `instanceTypes`

`instanceVersions`
: The database instance versions.

: **Field**: `instanceVersions`

`ipAddresses`
: The IP addresses of the database server. IP addresses could be IPV4 or IPV6.

: **Field**: `ipAddresses`

`portNumbers`
: The port numbers of the database server.

: **Field**: `portNumbers`

`solutionNames`
: The names of the solution that sent the data.

: **Field**: `solutionNames`

{{% inspec_filter_table %}}

## Examples

**Loop through Migrate project database instances by their names.**

```ruby
azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').names.each do |name|
  describe azure_migrate_project_database_instance(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: name) do
    it { should exist }
  end
end
```

**Test that there are Migrate project database instances that are of SQL instance types.**

```ruby
describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').where{ instanceTypes.include?('SQL') } do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no Migrate project database instances are present in the project and in the resource group

describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should_not exist }
end
# Should exist if the filter returns at least one Migrate project database instances in the project and in the resource group

describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
