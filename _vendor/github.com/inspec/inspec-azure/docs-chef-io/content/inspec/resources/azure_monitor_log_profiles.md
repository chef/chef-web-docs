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

Use the `azure_monitor_log_profiles` InSpec audit resource to test the properties and configuration of multiple Azure Log profiles.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_monitor_log_profiles` resource block returns all Azure Log profiles within an entire subscription.

```ruby
describe azure_monitor_log_profiles do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check if a specific Log profile is present

```ruby
describe azure_monitor_log_profiles do
  its('names')  { should include 'LOG_PROFILE' }
end
```

### Filter the results by the 'name' property if it includes a certain string

```ruby
describe azure_monitor_log_profiles.where{ name.include?('production') } do
  it { should exist }
end
```

### Filter the results to include only those Log profiles that retention policy is enabled

```ruby
describe azure_monitor_log_profiles.where{ properties.dig(:retentionPolicy, :enabled) == true } do
  it { should exist }
  its('count') { should be 4 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_monitor_log_profiles do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
