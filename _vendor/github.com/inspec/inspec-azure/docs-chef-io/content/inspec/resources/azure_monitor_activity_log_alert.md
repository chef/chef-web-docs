+++
title = "azure_monitor_activity_log_alert Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_monitor_activity_log_alert"
identifier = "inspec/resources/azure/azure_monitor_activity_log_alert Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_monitor_activity_log_alert` InSpec audit resource to test the properties of an Azure Monitor Activity Log Alert.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_monitor_activity_log_alert` resource block identifies an Azure Monitor Activity Log Alert by `name` and `resource_group`, or the `resource_id`.

```ruby
describe azure_monitor_activity_log_alert(resource_group: 'RESOURCE_GROUP', name: 'ALERT_NAME') do
  it { should exist }
end
```

```ruby
describe azure_monitor_activity_log_alert(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/activityLogAlerts/{activityLogAlertName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: Name of the Activity Log Alert to test.

`resource_id`
: The unique resource ID. 

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`

## Properties

`operations`
: The list of operations. `['Microsoft.Authorization/policyAssignments/write']`.

`conditions`
: The list of activity log alert conditions that will cause this alert to activate.

`scopes`
: A list of resource ID prefixes. The alert will only apply to activity logs with resource IDs that fall under one of these prefixes.

`enabled?`
: Indicates whether this activity log alert is enabled. Valid values are `true` or `false`.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/monitor/activitylogalerts/get#activitylogalertresource) for other properties available.

Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test an Activity Log Alert has the correct operation

```ruby
describe azure_monitor_activity_log_alert(resource_group: 'RESOURCE_GROUP', name: 'ALERT_NAME') do
  its('operations') { should include 'Microsoft.Authorization/policyAssignments/write' }
end
```

### Test the scope of an Activity Log Alert

```ruby
describe azure_monitor_activity_log_alert(resource_group: 'RESOURCE_GROUP', name: 'ALERT_NAME') do
  its('scopes') { should include 'subscriptions/{SUBSCRIPTION_ID}' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### enabled

Test if a resource is enabled. If an activity log alert is not enabled, then none of its actions will be activated.

```ruby
describe azure_monitor_activity_log_alert(resource_group: 'RESOURCE_GROUP', name: 'ALERT_NAME') do
  it { should be_enabled }
end
```

### exists

```ruby
# If we expect a resource to always exist.

describe azure_monitor_activity_log_alert(resource_group: 'RESOURCE_GROUP', name: 'ALERT_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_monitor_activity_log_alert(resource_group: 'RESOURCE_GROUP', name: 'ALERT_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
