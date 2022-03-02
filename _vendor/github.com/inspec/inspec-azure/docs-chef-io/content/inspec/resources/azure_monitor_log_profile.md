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

Use the `azure_monitor_log_profile` InSpec audit resource to test properties and configuration of an Azure log profile.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_monitor_log_profile(name: 'my_log_profile') do
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
: Name of the log profile to test. `logProfileName`.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/providers/microsoft.insights/logprofiles/{logProfileName}`.

## Properties

`retention_policy`
: The retention policy for the events in the log with [these](https://docs.microsoft.com/en-us/rest/api/monitor/logprofiles/get#retentionpolicy) properties.

`retention_days`
: The number of days for the log retention in days. A value of `0` means that the events will be retained indefinitely.

`storage_account`
: A hash containing the `name` and the `resouce_group` of the storage account in which the activity logs are kept.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/monitor/logprofiles/get#logprofileresource) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test If a Log Profile is Referenced with a Valid Name.**

```ruby
describe azure_monitor_log_profile(name: 'my_log_profile') do
  it { should exist }
end
```
**Test If a Log Profile is Referenced with an Invalid Name.**

```ruby
describe azure_monitor_log_profile(name: 'i-dont-exist') do
  it { should_not exist }
end
```    
**Test the Retention Days of a Log Profile.**

```ruby
describe azure_monitor_log_profile(name: 'my_log_profile') do
  its('retention_days') { should be 90 }
end
```        
**Test the Storage Account of a Log Profile.**

```ruby
describe azure_monitor_log_profile(resource_id: '/subscriptions/{subscriptionId}/providers/microsoft.insights/logprofiles/{logProfileName}') do
  its('storage_account') { should eql(resource_group: 'InSpec_rg', name: 'my_storage_account') }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### have_log_retention_enabled

Test whether the log retention is enabled.
```ruby
describe azure_monitor_log_profile(name: 'my_log_profile') do
  it { should have_log_retention_enabled }
end
```

### exists

```ruby
# If we expect a resource to always exist

describe azure_monitor_log_profile(name: 'my_log_profile') do
  it { should exist }
end
# If we expect a resource to never exist

describe azure_monitor_log_profile(name: 'my_log_profile') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
