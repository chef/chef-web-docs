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

Use the `azure_aks_clusters` InSpec audit resource to test the properties and configuration of multiple Azure AKS Clusters.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_aks_clusters` resource block returns all AKS Clusters, either within a Resource Group (if provided) or within an entire Subscription.

```ruby
describe azure_aks_clusters do
  #...
end
```

Or

```ruby
describe azure_aks_clusters(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource IDs.

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

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that an example Resource Group has the named AKS Cluster

```ruby
describe azure_aks_clusters(resource_group: 'RESOURCE_GROUP') do
  its('names') { should include('ClusterName') }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
# If we expect 'EXAMPLEGROUP' Resource Group to have AKS Clusters.

describe azure_aks_clusters(resource_group: 'EXAMPLEGROUP') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect 'EMPTYEXAMPLEGROUP' Resource Group not to have AKS Clusters.

describe azure_aks_clusters(resource_group: 'EMPTYEXAMPLEGROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
