+++
title = "azure_monitor_activity_log_alerts Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_monitor_activity_log_alerts"
identifier = "inspec/resources/azure/azure_monitor_activity_log_alerts Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_monitor_activity_log_alerts` InSpec audit resource to test the properties and configuration of multiple Azure Monitor Activity Log Alerts.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_monitor_activity_log_alerts` resource block returns all activity log alerts within a resource group (if provided) or an entire subscription.

```ruby
describe azure_monitor_activity_log_alerts do
  it { should exist }
end
```

Or

```ruby
describe azure_monitor_activity_log_alerts(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`location`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`operations`
: A list of operations for all the resources being interrogated.

: **Field**: `operations`

`resource_group`
: Azure resource group where the targeted resource resides.

: **Field**: `resource_group`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that a subscription has the named activity log alert

```ruby
describe azure_monitor_activity_log_alerts do
  its('names') { should include('ExampleLogAlert') }
end
```

**Loop through all resources with `resource_id`.**

```ruby
azure_monitor_activity_log_alerts.ids.each do |id|
  describe azure_monitor_activity_log_alert(resource_id: id) do
    it { should be_enabled }
  end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
# If we expect 'EXAMPLEGROUP' resource group to have activity log alerts.

describe azure_monitor_activity_log_alerts(resource_group: 'EXAMPLEGROUP') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect 'EMPTYEXAMPLEGROUP' resource group not to have activity log alerts.

describe azure_monitor_activity_log_alerts(resource_group: 'EMPTYEXAMPLEGROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
