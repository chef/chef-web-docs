+++
title = "azure_power_bi_dataflow Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_dataflow"
identifier = "inspec/resources/azure/azure_power_bi_dataflow Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_dataflow` InSpec audit resource to test the properties of a single Azure Power BI dataflow.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

```ruby
describe azure_power_bi_dataflow(group_id: 'GROUP_ID', name: 'DATAFLOW_ID') do
  it  { should exist }
end
```

```ruby
describe azure_power_bi_dataflow(group_id: 'GROUP_ID', name: 'DATAFLOW_ID')  do
  it  { should exist }
end
```

## Parameters

`name` _(required)_

: The dataflow ID.

`group_id` _(required)_

: The workspace ID.


## Properties

`name`
: The dataflow name.

`objectId`
: The dataflow ID.

`description`
: The dataflow description.

`modelUrl`
: A URL to the dataflow definition file (model.json).


For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/dataflows/get-dataflows) for other properties available.

## Examples

**Test that the Power BI dataflow name exists.**

```ruby
describe azure_power_bi_dataflow(group_id: 'GROUP_ID', name: 'DATAFLOW_ID')  do
  it { should exist }
  its('name') { should eq 'DATAFLOW_NAME' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

Use `should` to test that the entity exists.

```ruby
describe azure_power_bi_dataflow(group_id: 'GROUP_ID', name: 'DATAFLOW_ID')  do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe azure_power_bi_dataflow(group_id: 'GROUP_ID', name: 'DATAFLOW_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Dataflow.Read.All` role on the Azure Power BI dataflow you wish to test.