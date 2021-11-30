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

Use the `azure_data_factory_pipelines` InSpec audit resource to test properties related to pipeline for a resource group or the entire subscription.

## Azure Rest API Version, Endpoint, And HTTP Client Parameters

This resource interacts with API versions supported by the resource provider.
The `api_version` can be defined as a resource parameter.
If not provided, the latest version will be used.
For more information, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md" >}}).

Unless defined, `azure_cloud` global endpoint, and default values for the HTTP client will be used.
For more information, refer to the resource pack [README](https://github.com/inspec/inspec-azure/blob/main/README.md).
For api related info : [`Azure pipeline Docs`](https://docs.microsoft.com/en-us/rest/api/datafactory/pipelines/list-by-factory).

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_data_factory_pipelines` resource block returns all Azure pipeline, either within a resource group (if provided), or within an entire subscription.

```ruby
describe azure_data_factory_pipelines(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  #...
end
```

`resource_group` and `factory_name` must be given as parameters.

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in.

`factory_name`
: Azure Factory Name for which pipeline are being retrived.

## Properties

`names`
: A list of the unique resource names.

: **Field**: `name`

`ids`
: A list of pipeline IDs .

: **Field**: `id`

`properties`
: A list of properties for the resource.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Test If Any Pipeline Exist In The Resource Group.**

```ruby
describe azure_data_factory_pipelines(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  it { should exist }
  its('names') { should include 'pipeline_name' }
end
```

**Test that there aren't any pipeline in a resource group.**

```ruby
**Should not exist if no pipeline are in the resource group.**

describe azure_data_factory_pipelines(resource_group: 'example', factory_name: 'fake') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
