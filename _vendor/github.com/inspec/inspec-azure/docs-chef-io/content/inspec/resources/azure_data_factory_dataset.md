+++
title = "azure_data_factory_dataset Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_factory_dataset"
identifier = "inspec/resources/azure/azure_data_factory_dataset Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_factory_dataset` InSpec audit resource to test the properties related to an Azure Data Factory dataset.

See the [`Azure Data Factories Dataset documentation`](https://docs.microsoft.com/en-us/rest/api/datafactory/datasets/get) for additional information.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_data_factory_dataset(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME', dataset_name: 'DATASET_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

`dataset_name` _(required)_
: Name of the Azure resource to test.

`factory_name` _(required)_
: The factory name.

## Properties

`name`
: Name of the Azure resource to test.

`id`
: The azure_sentinel_alert_rule type.

`properties`
: The properties of the resource.

`type`
: Azure resource type.

`description`
: The description of dataset type.

`properties.linkedServiceName.referenceName`
: Reference LinkedService name.

`properties.linkedServiceName.type`
: Linked service reference type.

`properties.type`
: The dataset type.`AmazonMWSObjectDataset`, `AvroDataset`.

## Examples

### Test if properties match

```ruby
describe azure_data_factory_dataset(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME', dataset_name: 'DATASET_NAME') do
  it { should exist }
  its('name') { should eq 'DATASET_NAME'}
  its('type') { should eq 'Microsoft.DataFactory/factories/datasets' }
  its('properties.description') { should eq 'Description of dataset.' }
  its('properties.linkedServiceName.referenceName') { should eq 'LINKED_SERVICE_NAME' }
  its('properties.linkedServiceName.type') { should eq 'LinkedServiceReference' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If a dataset should exist.

describe azure_data_factory_dataset(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME', dataset_name: 'DATASET_NAME') do
  it { should exist }
end
```

### not_exists

```ruby

# If a dataset should not exist.

describe azure_data_factory_dataset(resource_group: 'RESOURCE_GROUP', factory_name: 'FACTORY_NAME', dataset_name: 'DATASET_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
