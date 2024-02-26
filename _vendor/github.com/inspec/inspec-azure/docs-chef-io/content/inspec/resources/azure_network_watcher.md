+++
title = "azure_network_watcher Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_network_watcher"
identifier = "inspec/resources/azure/azure_network_watcher Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_network_watcher` InSpec audit resource to test the properties of an Azure Network Watcher.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_network_watcher` resource block identifies a Network Watcher by `name` and `resource_group`, or the `resource_id`.

```ruby
describe azure_network_watcher(resource_group: 'RESOURCE_GROUP', name: 'NETWORK_WATCHER_NAME') do
  it { should exist }
end
```

```ruby
describe azure_network_watcher(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the network watcher resides.

`name`
: Name of the network watcher to test.

`resource_id`
: The unique resource ID.

`flow_logs_api_version`
: The flow log status endpoint API version used for creating `flow_logs` property. The latest version will be used unless provided. A network security group within the same region can be targeted for getting the flow log statuses. For more, see [here](https://docs.microsoft.com/en-us/rest/api/network-watcher/networkwatchers/getflowlogstatus).

`nsg_resource_id`
: The unique resource ID of the network security group being targeted to get the flow log statuses. `/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}`.

`nsg_resource_group`
: The resource group of the network security group being targeted to get the flow log statuses. This requires `nsg_name` to be provided.

`nsg_name`
: The name of the network security group being targeted to get the flow log statuses. This requires `nsg_resource_group` to be provided.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`

## Properties

`provisioning_state`
: The provisioning state of the network watcher resource. For the valid values, see [here](https://docs.microsoft.com/en-us/rest/api/network-watcher/networkwatchers/get#provisioningstate).

`flow_logs`
: Information on the configuration of flow log and traffic analytics (optional) in [this format](https://docs.microsoft.com/en-us/rest/api/network-watcher/networkwatchers/getflowlogstatus#flowloginformation). All properties can be accessed via dot notation. For example, `flow_logs.properties.enabled`. This resource supports targeting network security groups defined at resource creation only.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/network-watcher/networkwatchers/get#networkwatcher) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test the location of a Network Watcher

```ruby
describe azure_network_watcher(resource_group: 'RESOURCE_GROUP', name: 'NETWORK_WATCHER_NAME') do
  its('location') { should cmp 'eastus' }
end
```

### Test the Flow Log status of a Network Security group

```ruby
describe azure_network_watcher(resource_group: 'RESOURCE_GROUP', name: 'NETWORK_WATCHER_NAME', nsg_resource_group: 'NSG_RESOURCE_GROUP', nsg_name: 'nsg_eastus') do
  its('flow_logs.properties.enabled') { should be true }
  its('flow_logs.properties.retentionPolicy.days') { should be >= 90 }
end
```

### Loop through Network Security groups with the resource ID

```ruby
azure_network_security_groups.where(location: 'eastus').ids.each do |nsg_id|
  describe azure_network_watcher(resource_group: 'RESOURCE_GROUP', name: 'NETWORK_WATCHER_NAME', nsg_resource_id: nsg_id) do
    its('flow_logs.properties.enabled') { should be true }
    its('flow_logs.properties.retentionPolicy.days') { should be >= 90 }
  end
end
```

See [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_network_watcher.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect 'NETWORKWATCHERNAME' to always exist.

describe azure_network_watcher(resource_group: 'RESOURCE_GROUP', name: 'NETWORK_WATCHER_NAME') do
  it { should exist }
end

# If we expect 'NETWORKWATCHERNAME' to never exist.

describe azure_network_watcher(resource_group: 'RESOURCE_GROUP', name: 'NETWORK_WATCHER_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
