+++
title = "azure_virtual_networks Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_networks"
identifier = "inspec/resources/azure/azure_virtual_networks Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_networks` InSpec audit resource to test properties related to virtual networks within your subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_virtual_networks` resource block returns all Azure virtual networks, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_virtual_networks do
  #...
end
```
or
```ruby
describe azure_virtual_networks(resource_group: 'my-rg') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`locations`
: A list of locations for all the virtual networks.

: **Field**: `location`

`names`
: A list of all the virtual network names.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

`etags`
: A list of etags defined on the resources.

: **Field**: `etag`

{{% inspec_filter_table %}}

## Examples

**Exists If Any Virtual Networks Exist in the Resource Group.**

```ruby
describe azure_virtual_networks(resource_group: 'MyResourceGroup') do
  it { should exist }
end
```
**Filters the Results to Only Those that Match the Given Name (Client Side).**

```ruby
**Insist that MyVnetName exists.**

describe azure_virtual_networks(resource_group: 'MyResourceGroup').where(name: 'MyVnetName') do
  it { should exist }
end
```
```ruby
**Insist that you have at least one virtual network that starts with 'prefix'.**

describe azure_virtual_networks(resource_group: 'MyResourceGroup').where { name.include?('project_A') } do
  it { should exist }
end
```
**Filters the Networks at Azure API to Only Those that Match the Given Name via Generic Resource (Recommended).**

```ruby
**Fuzzy string matching.**

describe azure_generic_resources(resource_group: 'MyResourceGroup', resource_provider: 'Microsoft.Network/virtualNetworks', substring_of_name: 'project_A') do
  it { should exist }
end
```
```ruby
**Exact name matching.**

describe azure_generic_resources(resource_group: 'MyResourceGroup', resource_provider: 'Microsoft.Network/virtualNetworks', name: 'MyVnetName') do
  it { should exist }
end
```    

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no virtual networks are in the resource group

describe azure_virtual_networks(resource_group: 'MyResourceGroup') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
