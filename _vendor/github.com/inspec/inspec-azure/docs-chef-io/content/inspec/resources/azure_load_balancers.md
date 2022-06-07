+++
title = "azure_load_balancers Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_load_balancers"
identifier = "inspec/resources/azure/azure_load_balancers Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_load_balancers` InSpec audit resource to test properties and configuration of Azure Load Balancers.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_load_balancers` resource block returns all Azure Load Balancers, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_load_balancers do
  #...
end
```
or
```ruby
describe azure_load_balancers(resource_group: 'my-rg') do
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
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`types`
: A list of the types of resources being interrogated.

: **Field**: `type`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

`skus`
: A list of the SKUs of the resources being interrogated.

: **Field**: `sku`

{{% inspec_filter_table %}}

## Examples

**Check Load balancers are Present.**

````ruby
describe azure_load_balancers do
    it            { should exist }
    its('names')  { should include 'my-lb' }
end
````
**Filter the Results to Include Only those with Names Match the Given String Value.**

```ruby
describe azure_load_balancers.where{ name.eql?('production-lb') } do
  it { should exist }
end
```
**Filter the Results to Include Only those with Location Match the Given String Value.**

```ruby
describe azure_load_balancers.where{ location.eql?('eastus-2') } do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
# If we expect 'ExampleGroup' Resource Group to have Load Balancers
describe azure_load_balancers(resource_group: 'ExampleGroup') do
  it { should exist }
end

# If we expect 'EmptyExampleGroup' Resource Group to not have Load Balancers
describe azure_load_balancers(resource_group: 'ExampleGroup') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
