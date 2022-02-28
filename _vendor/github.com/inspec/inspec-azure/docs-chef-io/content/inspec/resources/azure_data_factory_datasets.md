+++
title = "azure_data_factory_datasets Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_factory_datasets"
identifier = "inspec/resources/azure/azure_data_factory_datasets Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_factory_datasets` InSpec audit resource to test properties of multiple Azure Data Factory datasets for a resource group or the entire subscription.

See the [`Azure Data Factories Dataset documentation`](https://docs.microsoft.com/en-us/rest/api/datafactory/datasets/get) for additional information.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_data_factory_datasets` resource block returns all Azure dataset, either within a Resource Group (if provided), or within an entire Subscription.

```ruby
describe azure_data_factory_datasets(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  #...
end
```

## Parameters

`resource_group` _(required)_
: Azure resource group that the targeted resource resides in.

`factory_name` _(required)_
: The Azure Data factory name.

## Properties

`names`
: A list of the unique resource names.

: **Field**: `name`

`ids`
: A list of dataset IDs.

: **Field**: `id`

`properties`
: A list of properties for the resources.

: **Field**: `properties`

`types`
: A list of types for each resource.

: **Field**: `type`

`descriptions`
: A list of descriptions of the resources.

: **Field**: `description`

`linkedServiceName_referenceNames`
: The list of LinkedService names.

: **Field**: `linkedServiceName_referenceName`

`linkedServiceName_types`
: The list of LinkedService types.

: **Field**: `linkedServiceName_type`

{{% inspec_filter_table %}}

## Examples

**Test if Properties Match.**

```ruby
describe azure_data_factory_datasetsazure_data_factory_datasets(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  its('names') { should include 'DATASET_NAME' }
  its('types') { should include 'Microsoft.SecurityInsights/alertRules' }
  its('enableds') { should include true }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### Test if Any Dataset Exists in the Data Factory

```ruby
describe azure_data_factory_datasetsazure_data_factory_datasets(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  it { should exist }
end
```

### Test That There Aren’t Any Datasets in a Data Factory

```ruby
# Should not exist if no dataset are in the data factory

describe azure_data_factory_datasetsazure_data_factory_datasets(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
