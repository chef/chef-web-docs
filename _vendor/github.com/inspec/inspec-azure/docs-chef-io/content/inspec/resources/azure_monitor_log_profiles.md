+++
title = "azure_monitor_log_profiles Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_monitor_log_profiles"
identifier = "inspec/resources/azure/azure_monitor_log_profiles Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_monitor_log_profiles` InSpec audit resource to test properties and configuration of multiple Azure log profiles.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_monitor_log_profiles` resource block returns all Azure log profiles within an entire subscription.
```ruby
describe azure_monitor_log_profiles do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Check if a Specific Log Profile is Present.**

```ruby
describe azure_monitor_log_profiles do
  its('names')  { should include 'my_log_profile' }
end
```
**Filter the Results by the `name` Property if it Includes a Certain String.**

```ruby
describe azure_monitor_log_profiles.where{ name.include?('production') } do
  it { should exist }
end
```   
**Filter the Results to Include Only Those Log Profiles that Retention Policy is Enabled.**

```ruby
describe azure_monitor_log_profiles.where{ properties.dig(:retentionPolicy, :enabled) == true } do
  it { should exist }
  its('count') { should be 4 }
end
```   

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
describe azure_monitor_log_profiles do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
