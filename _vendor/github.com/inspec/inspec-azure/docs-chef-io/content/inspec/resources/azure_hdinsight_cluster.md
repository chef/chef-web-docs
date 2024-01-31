+++
title = "azure_hdinsight_cluster Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_hdinsight_cluster"
identifier = "inspec/resources/azure/azure_hdinsight_cluster Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_hdinsight_cluster` InSpec audit resource to test the properties of an Azure HDInsight Cluster.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_hdinsight_cluster` resource block identifies a HDInsight Cluster by `name` and `resource_group`, or the `resource_id`.

```ruby
describe azure_hdinsight_cluster(resource_group: 'RESOURCE_GROUP', name: 'CLUSTER_NAME') do
  it { should exist }
end
```

```ruby
describe azure_hdinsight_cluster(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: The unique name of the cluster.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`

## Properties

`properties.clusterVersion`
: The version of the cluster.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/hdinsight/2021-06-01/clusters/get?tabs=HTTP) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test that a specified HDInsight Cluster is successfully provisioned

```ruby
describe azure_hdinsight_cluster(resource_group: 'RESOURCE_GROUP', name: 'CLUSTER_NAME') do
  its('properties.provisioningState') { should cmp 'Succeeded' }
end
```

```ruby
describe azure_hdinsight_cluster(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}') do
  its('properties.provisioningState') { should cmp 'Succeeded' }
end
```

### Test the version of an HDInsight Cluster

```ruby
describe azure_hdinsight_cluster(resource_group: 'RESOURCE_GROUP', name: 'CLUSTER_NAME') do
  its('properties.clusterVersion') { should cmp  '4.0' }
end
```

See [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_hdinsight_cluster.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist.

describe azure_hdinsight_cluster(resource_group: 'RESOURCE_GROUP', name: 'CLUSTER_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the resource not to exist.

describe azure_hdinsight_cluster(resource_group: 'RESOURCE_GROUP', name: 'CLUSTER_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
