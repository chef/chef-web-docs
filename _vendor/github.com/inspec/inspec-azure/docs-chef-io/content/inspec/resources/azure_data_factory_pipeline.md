+++
title = "azure_data_factory_pipeline Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_factory_pipeline"
identifier = "inspec/resources/azure/azure_data_factory_pipeline Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_factory_pipeline` InSpec audit resource to test the properties of an Azure pipeline.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `pipeline_name`, or `factory_name` are required parameters.

```ruby
describe azure_data_factory_pipeline(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME', pipeline_name: 'PIPELINE_NAME') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`factory_name`
: Data factory name where you want to create your pipeline.

`pipeline_name`
: The pipeline name.

All the parameter sets need to be provided for a valid query: `resource_group` , `factory_name`, and `pipeline_name`

## Properties

`name`
: Name of the Azure resource to test.

`id`
: The pipeline type.

`properties`
: The properties of the resource.

## Examples

### Test that a pipeline exists

```ruby
describe azure_data_factory_pipeline(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME', pipeline_name: 'PIPELINE_NAME') do
  it { should exist }
end
```

### Test that a pipeline does not exist

```ruby
describe azure_data_factory_pipeline(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME', pipeline_name: 'PIPELINE_NAME') do
  it { should_not exist }
end
 ```

### Test properties of a pipeline

```ruby
describe azure_data_factory_pipeline(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME', pipeline_name: 'PIPELINE_NAME') do
  its('name') { should eq 'PIPELINE_NAME' }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
