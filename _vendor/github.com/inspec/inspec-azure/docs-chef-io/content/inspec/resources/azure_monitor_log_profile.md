+++
title = "azure_monitor_log_profile Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_monitor_log_profile"
identifier = "inspec/resources/azure/azure_monitor_log_profile Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_monitor_log_profile` InSpec audit resource to test the properties and configuration of an Azure Log profile.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` or the `resource_id` are required parameters.

```ruby
describe azure_monitor_log_profile(name: 'LOG_PROFILE') do
  it { should exist }
end
```

```ruby
describe azure_monitor_log_profile(resource_id: '/subscriptions/{subscriptionId}/providers/microsoft.insights/logprofiles/{logProfileName}') do
  it { should exist }
end
```

## Parameters

`name`
: Name of the log profile to test.

`resource_id`
: The unique resource ID.

## Properties

`retention_policy`
: The retention policy for the events in the log with [these](https://docs.microsoft.com/en-us/rest/api/monitor/logprofiles/get#retentionpolicy) properties.

`retention_days`
: The number of days for the log retention in days. A value of `0` means that the events will be retained indefinitely.

`storage_account`
: A hash containing the `name` and the `resouce_group` of the storage account in which the activity logs are kept.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/monitor/logprofiles/get#logprofileresource) for other properties available.

Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test if a Log profile is referenced with a valid name

```ruby
describe azure_monitor_log_profile(name: 'LOG_PROFILE') do
  it { should exist }
end
```

### Test if a Log profile is referenced with an invalid name

```ruby
describe azure_monitor_log_profile(name: 'i-dont-exist') do
  it { should_not exist }
end
```

### Test the retention days of a Log profile

```ruby
describe azure_monitor_log_profile(name: 'LOG_PROFILE') do
  its('retention_days') { should be 90 }
end
```

### Test the storage account of a Log profile

```ruby
describe azure_monitor_log_profile(resource_id: '/subscriptions/{subscriptionId}/providers/microsoft.insights/logprofiles/{logProfileName}') do
  its('storage_account') { should eql(resource_group: 'RESOURCE_GROUP', name: 'STORAGE_ACCOUNT') }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### have_log_retention_enabled

Test whether the log retention is enabled.

```ruby
describe azure_monitor_log_profile(name: 'LOG_PROFILE') do
  it { should have_log_retention_enabled }
end
```

### exists

```ruby
# If we expect a resource to always exist.

describe azure_monitor_log_profile(name: 'LOG_PROFILE') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_monitor_log_profile(name: 'LOG_PROFILE') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
