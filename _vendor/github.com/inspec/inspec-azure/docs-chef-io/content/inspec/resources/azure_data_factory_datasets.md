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

Use the `azure_data_factory_datasets` InSpec audit resource to test the properties of multiple Azure Data Factory datasets for a resource group or the entire subscription.

See the [`Azure Data Factories Dataset documentation`](https://docs.microsoft.com/en-us/rest/api/datafactory/datasets/get) for additional information.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_data_factory_datasets` resource block returns all Azure datasets, either within a resource group (if provided) or within an entire Subscription.

```ruby
describe azure_data_factory_datasets(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  #...
end
```

## Parameters

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

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

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test if properties match

```ruby
describe azure_data_factory_datasetsazure_data_factory_datasets(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  its('names') { should include 'DATASET_NAME' }
  its('types') { should include 'Microsoft.SecurityInsights/alertRules' }
  its('enableds') { should include true }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### Test if any Dataset exists in the Data Factory

```ruby
describe azure_data_factory_datasetsazure_data_factory_datasets(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  it { should exist }
end
```

### Test that there are not any Datasets in a Data Factory

```ruby
# Should not exist if no datasets are in the data factory.

describe azure_data_factory_datasetsazure_data_factory_datasets(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
