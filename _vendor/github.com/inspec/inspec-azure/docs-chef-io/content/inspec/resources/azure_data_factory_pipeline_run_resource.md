+++
title = "azure_data_factory_pipeline_run_resource Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_factory_pipeline_run_resource"
identifier = "inspec/resources/azure/azure_data_factory_pipeline_run_resource Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_factory_pipeline_run_resource` InSpec audit resource to test the properties of an Azure Data Factory pipeline run.

For additional information, see the [`Azure API documentation on Data Factory pipeline runs`](https://docs.microsoft.com/en-us/rest/api/datafactory/pipeline-runs/query-by-factory).

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_data_factory_pipeline_run_resource(resource_group: `RESOURCE_GROUP`, factory_name: `FACTORY_NAME`, run_id: `RUN_ID`) do
  #...
end
```

## Parameters

`resource_group` _(required)_

: Azure resource group where the targeted resource resides.

`factory_name` _(required)_

: The factory name.

`run_id` _(required)_

: The name of the pipeline runs.

## Properties

`invokedBy.name`
: The unique resource names.

`pipelineName`
: The pipeline name.

`status`
: The status of a pipeline run.

`runId`
: Identifiers of a run.

`runStart`
: Start time of a pipeline run in ISO8601 format.

`runEnd`
: End time of a pipeline run in ISO8601 format.

`runStart`
: The properties of the resource.

## Examples

### Test properties of a pipeline runs

```ruby
describe azure_data_factory_pipeline_run_resource(resource_group: `RESOURCE_GROUP`, name: 'FACTORY_NAME', run_id: `RUN_ID`) do
  its('invokedBy.name') { should include 'INVOKED_BY_NAME' }
  its('pipelineNames') { should include 'PIPELINE_NAME' }
  its('status') { should include 'PIPELINE_STATUS' }
end
```

## Matchers

### Test that a pipeline runs exists

```ruby
describe azure_data_factory_pipeline_run_resource(resource_group: `RESOURCE_GROUP`, factory_name: `FACTORY_NAME`, run_id: `RUN_ID`) do
  it { should exist }
end
```

### Test that a pipeline runs does not exist

```ruby
describe azure_data_factory_pipeline_run_resource(resource_group: `RESOURCE_GROUP`, factory_name: `FACTORY_NAME`, run_id: 'RUN_ID') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
