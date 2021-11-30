+++
title = "azure_resource_groups Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_resource_groups"
identifier = "inspec/resources/azure/azure_resource_groups Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_resource_groups` InSpec audit resource to test properties and configuration of multiple Azure resource groups.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_resource_groups` resource block returns all resource groups within a subscription.

```ruby
describe azure_resource_groups do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the unique resource group ids.

: **Field**: `id`

`names`
: A list of names of all the resource groups.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resource groups.

: **Field**: `tags`

`locations`
: A list of locations of all the resource groups.

: **Field**: `location`

{{% inspec_filter_table %}}

## Examples

**Check if a specific resource group is present.**

```ruby
describe azure_resource_groups do
  its('names')  { should include 'my-resource-group' }
end
```

**Filters the Results to Include Only Those Resource Groups which Include the Given Name.**

```ruby
describe azure_resource_groups.where{ name.include?('my-resource-group') } do
  it { should exist }
end
```

**Filters the Results to Include Only The Resource Groups that Have Certain Tag.**

```ruby
describe azure_resource_groups.where{ tags.has_key?('owner') && tags['owner'] == "InSpec" } do
  it { should exist }
  its('count') { should be 15 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_resource_groups do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
