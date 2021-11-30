---
title: About the azure_migrate_project_database_instances Resource
platform: azure
---

# azure_migrate_project_database_instances

Use the `azure_migrate_project_database_instances` InSpec audit resource to test properties of all Azure Migrate project database instances in a migrate project.

## Azure REST API version, endpoint and http client parameters

This resource interacts with api versions supported by the resource provider.
The `api_version` can be defined as a resource parameter.
If not provided, the latest version will be used.
For more information, refer to [`azure_generic_resource`](azure_generic_resource.md).

Unless defined, `azure_cloud` global endpoint, and default values for the http client will be used.
For more information, refer to the resource pack [README](../../README.md).

## Availability

### Installation

This resource is available in the [InSpec Azure resource pack](https://github.com/inspec/inspec-azure).
For an example `inspec.yml` file and how to set up your Azure credentials, refer to resource pack [README](../../README.md#Service-Principal).

## Syntax

An `azure_migrate_project_database_instances` resource block returns all Azure Migrate project database instances within a project.

```ruby
describe azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group` _(required)_

Name of the Azure Resource Group that migrate project is part of.

`project_name` _(required)_

Name of the Azure Migrate project.

## Properties

|Property                        | Description                                                            | Filter Criteria<superscript>*</superscript> |
|--------------------------------|------------------------------------------------------------------------|------------------|
| ids                            | Path reference to the project database instances.                      | `id`             |
| names                          | Unique names for all project database instances.                       | `name`           |
| types                          | Type of the objects.                                                   | `type`           |
| properties                     | A list of properties for all the project database instances.           | `properties`     |
| discoveryDatas                 | The assessment details of the database published by various sources.   | `assessmentData` |
| summaries                      | The database instances summaries per solution.                         | `summary`        |
| lastUpdatedTimes               | The time of the last modification of the database instance details.    | `lastUpdatedTime`|
| enqueueTimes                   | The times the message were enqueued.                                   | `enqueueTimes`   |
| extendedInfos                  | The extended properties of the database servers.                       | `extendedInfos`  |
| hostNames                      | The host names of the database servers.                                | `hostNames`      |
| instanceIds                    | The database instance IDs.                                             | `instanceIds`    |
| instanceNames                  | The database instance names.                                           | `instanceNames`  |
| instanceTypes                  | The database instance types.                                           | `instanceTypes`  |
| instanceVersions               | The database instance versions.                                        | `instanceVersions`|
| ipAddresses                    | The IP addresses of the database server. IP addresses could be IPV4 or IPV6.| `ipAddresses` |
| portNumbers                    | The port numbers of the database server.                               | `portNumbers`    |
| solutionNames                  | The names of the solution that sent the data.                          | `solutionNames`  |

<superscript>*</superscript> For information on how to use filter criteria on plural resources refer to [FilterTable usage](https://github.com/inspec/inspec/blob/master/dev-docs/filtertable-usage.md).

## Examples

### Loop through Migrate project database instances by their names.

```ruby
azure_migrate_project_database_instances(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').names.each do |name|
  describe azure_migrate_project_database_instance(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: name) do
    it { should exist }
  end
end
```

### Test that there are Migrate project database instances that are of SQL instance types.

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

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be setup with a `contributor` role on the subscription you wish to test.