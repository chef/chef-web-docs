+++
title = "azure_aks_clusters Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_aks_clusters"
identifier = "inspec/resources/azure/azure_aks_clusters Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_aks_clusters` InSpec audit resource to test properties and configuration of multiple Azure AKS Clusters.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_aks_clusters` resource block returns all AKS Clusters, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_aks_clusters do
  #...
end
```
or
```ruby
describe azure_aks_clusters(resource_group: 'my-rg') do
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

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Test that an Example Resource Group has the Named AKS Cluster.**

```ruby
describe azure_aks_clusters(resource_group: 'ExampleGroup') do
  its('names') { should include('ClusterName') }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
# If we expect 'ExampleGroup' Resource Group to have AKS Clusters
describe azure_aks_clusters(resource_group: 'ExampleGroup') do
  it { should exist }
end

# If we expect 'EmptyExampleGroup' Resource Group to not have AKS Clusters
describe azure_aks_clusters(resource_group: 'EmptyExampleGroup') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
