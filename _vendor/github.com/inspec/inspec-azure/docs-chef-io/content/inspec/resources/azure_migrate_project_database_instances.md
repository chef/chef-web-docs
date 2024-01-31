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

Use the `azure_migrate_project_database_instances` InSpec audit resource to test the properties of all Azure Migrate Project database instances in a migrate project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_migrate_project_database_instances` resource block returns all Azure Migrate project database instances within a project.

```ruby
describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group` _(required)_

: Name of the Azure Resource Group where the migrate project is part.

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
: The time when the message was enqueued.

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

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through Migrate Project database instances by their names

```ruby
azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').names.each do |name|
  describe azure_migrate_project_database_instance(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: name) do
    it { should exist }
  end
end
```

### Test that there are Migrate Project database instances that are of SQL instance types

```ruby
describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').where{ instanceTypes.include?('SQL') } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Migrate Project database instances are present in the project and the resource group.

describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Migrate project database instance in the project and the resource group.

describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
