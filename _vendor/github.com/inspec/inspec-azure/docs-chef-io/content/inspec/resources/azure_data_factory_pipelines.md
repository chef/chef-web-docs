+++
title = "azure_data_factory_pipelines Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_factory_pipelines"
identifier = "inspec/resources/azure/azure_data_factory_pipelines Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_factory_pipelines` InSpec audit resource to test the properties related to a pipeline for a resource group or the entire subscription.

## Azure Rest API Version, Endpoint, And HTTP Client Parameters

This resource interacts with API versions supported by the resource provider. The `api_version` can be defined as a resource parameter.
If not provided, the latest version will be used. For more information, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md" >}}).

Unless defined, the `azure_cloud` global endpoint and default values for the HTTP client will be used. For more information, refer to the resource pack [README](https://github.com/inspec/inspec-azure/blob/main/README.md). For API related information, [`Azure pipeline Docs`](https://docs.microsoft.com/en-us/rest/api/datafactory/pipelines/list-by-factory).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_data_factory_pipelines` resource block returns all Azure pipelines, either within a resource group (if provided) or an entire subscription.

```ruby
describe azure_data_factory_pipelines(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  #...
end
```

`resource_group` and `factory_name` are required parameters.

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`factory_name`
: Azure Factory Name for which pipeline is being retrieved.

## Properties

`names`
: A list of the unique resource names.

: **Field**: `name`

`ids`
: A list of pipeline IDs.

: **Field**: `id`

`properties`
: A list of properties for the resource.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test if any pipeline exists in the resource group

```ruby
describe azure_data_factory_pipelines(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  it { should exist }
  its('names') { should include 'pipeline_name' }
end
```

### Test that there are not any pipelines in a resource group

```ruby
# Should not exist if no pipelines is in the resource group.

describe azure_data_factory_pipelines(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
