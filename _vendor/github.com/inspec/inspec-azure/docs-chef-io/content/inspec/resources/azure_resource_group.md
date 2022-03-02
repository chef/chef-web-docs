+++
title = "azure_resource_group Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_resource_group"
identifier = "inspec/resources/azure/azure_resource_group Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_resource_group` InSpec audit resource to test properties and configuration of an Azure resource group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_resource_group(name: 'my_resource_group') do
  it { should exist }
end
```
```ruby
describe azure_resource_group(resource_id: '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}') do
  it { should exist }
end
```

## Parameters

`name`
: Name of the resource group. `resourceGroupName`.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `name`

## Properties

`properties.provisioningState`
: The provisioning state. `Succeeded`.

For properties applicable to all resources, such as `type`, `name`, `id`, `location`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/resources/policydefinitions/get#policydefinition) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test a Resource Group Location.**

```ruby
describe azure_resource_group(name: 'my_resource_group') do
  its('location') { should cmp 'eastus' }
end
```
**Test a Resource Group Provisioning State.**

```ruby
describe azure_resource_group(name: 'my_resource_group') do
  its('properties.provisioningState') { should cmp 'Succeeded' }
end
```    
**Test a Resource Group Tags.**

```ruby
describe azure_resource_group(name: 'my_resource_group') do
  its('tags') { should include(:owner) }
  its('tags') { should include(owner: 'InSpec') }
end
```    

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# If we expect a resource group to always exist

describe azure_resource_group(name: 'my_resource_group') do
  it { should exist }
end
# If we expect a resource group to never exist

describe azure_resource_group(name: 'my_resource_group') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
