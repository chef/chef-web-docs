+++
title = "azure_management_groups Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_management_groups"
identifier = "inspec/resources/azure/azure_management_groups Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_management_groups` InSpec audit resource to test properties and configuration of multiple Azure management groups.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_management_groups` resource block returns management groups for the authenticated user.
```ruby
describe azure_management_groups do
  #...
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

`types`
: A list of types of all the resources being interrogated.

: **Field**: `type`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Test that a Named Management Group Exist.**

```ruby
describe azure_management_groups do
  its('names') { should include('abcd-1234') }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
# If we expect at least one management group to exist

describe azure_management_groups do
  it { should exist }
end

# If we expect zero matches

describe azure_management_groups do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
