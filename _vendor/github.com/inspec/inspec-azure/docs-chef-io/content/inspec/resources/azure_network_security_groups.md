+++
title = "azure_network_security_groups Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_network_security_groups"
identifier = "inspec/resources/azure/azure_network_security_groups Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_network_security_groups` InSpec audit resource to enumerate Network Security Groups.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_network_security_groups` resource block returns all Azure network security groups, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_network_security_groups do
  #...
end
```
or
```ruby
describe azure_network_security_groups(resource_group: 'my-rg') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`locations`
: A list of locations for all the network security groups.

: **Field**: `location`

`names`
: A list of all the network security group names.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

`etags`
: A list of etags defined on the resources.

: **Field**: `etag`

`properties`
: A list of all properties of all the resources.

: **Field**: `properties`
{{% inspec_filter_table %}}

## Examples

**Test that an Example Resource Group Has the Named Network Security Group.**

```ruby
describe azure_network_security_groups(resource_group: 'ExampleGroup') do
  its('names') { should include('ExampleNetworkSecurityGroup') }
end
```

**Filters the Network Security Groups at Azure API to Only Those that Match the Given Name via Generic Resource (Recommended).**

```ruby
**Fuzzy string matching.**

describe azure_generic_resources(resource_provider: 'Microsoft.Network/networkSecurityGroups', substring_of_name: 'project_A') do
  it { should exist }
end

**Exact name matching.**

describe azure_generic_resources(resource_provider: 'Microsoft.Network/networkSecurityGroups', name: 'project_A') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the resource returns a result. Use `should_not` if you expect zero matches.
```ruby
# If we expect 'ExampleGroup' Resource Group to have Network Security Groups
describe azure_network_security_groups(resource_group: 'ExampleGroup') do
  it { should exist }
end

# If we expect 'EmptyExampleGroup' Resource Group to not have Network Security Groups
describe azure_network_security_groups(resource_group: 'EmptyExampleGroup') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="reader" %}}
