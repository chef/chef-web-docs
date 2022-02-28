+++
title = "azure_aks_cluster Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_aks_cluster"
identifier = "inspec/resources/azure/azure_aks_cluster Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_aks_cluster` InSpec audit resource to test properties of an Azure AKS Cluster.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_aks_cluster` resource block identifies an AKS Cluster by `name` and `resource_group` or the `resource_id`.
```ruby
describe azure_aks_cluster(resource_group: 'example', name: 'ClusterName') do
  it { should exist }
end
```
```ruby
describe azure_aks_cluster(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.ContainerService/managedClusters/{ClusterName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: Name of the AKS cluster to test. `ClusterName`.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.ContainerService/managedClusters/{ClusterName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group` and `name`

## Properties

`identity`
: The identity of the managed cluster, if configured. It is a [managed cluster identity object](https://docs.microsoft.com/en-us/rest/api/aks/managedclusters/get#managedclusteridentity).

`sku`
: The SKU (pricing tier) of the resource.

`diagnostic_settings`
: The diagnostic settings for the resource group that the AKS cluster is within.

`enabled_logging_types`
: The logging types that are enabled for the AKS cluster.

`disabled_logging_types`
: The logging types that are disabled for the AKS cluster.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/aks/managedclusters/get#managedcluster) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test that an AKS Cluster has the Desired Network Plug-in.**

```ruby
describe azure_aks_cluster(resource_group: 'example', name: 'ClusterName') do
  its('properties.networkProfile.networkPlugin') { should cmp 'kubenet' }
end
```

**Loop through All Clusters within The Subscription.**

```ruby
azure_aks_clusters.ids.each do |resource_id|
  describe azure_aks_cluster(resource_id: resource_id) do
    its('properties.networkProfile.networkPlugin') { should cmp 'kubenet' }
  end
end 
```
**Test that a Specified AKS Cluster has the Correct Number of Nodes in Pool.**

```ruby
describe azure_aks_cluster(resource_group: 'example', name: 'ClusterName') do
  its('properties.agentPoolProfiles.first.count') { should cmp 5 }
end
```
**Test that a Specified AKS Cluster has kube-audit logging enabled.**

```ruby
describe azure_aks_cluster(resource_group: 'example', name: 'ClusterName') do
  its('enabled_logging_types') { should include "kube-audit" }
end
```
**Test that a Specified AKS Cluster has logging enabled on it and no forms of logging disabled.**

```ruby
describe azure_aks_cluster(resource_group: 'example', name: 'ClusterName') do
  its('disabled_logging_types.count') { should eq 0 }
end
```
See [integration tests](../../test/integration/verify/controls/azurerm_aks_cluster.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect 'ClusterName' to always exist
describe azure_aks_cluster(resource_group: 'example', name: 'ClusterName') do
  it { should exist }
end

# If we expect 'ClusterName' to never exist
describe azure_aks_cluster(resource_group: 'example', name: 'ClusterName') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
