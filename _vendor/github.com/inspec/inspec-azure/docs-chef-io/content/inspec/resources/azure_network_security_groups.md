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

Use the `azure_network_security_groups` InSpec audit resource to enumerate the Network Security groups.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_network_security_groups` resource block returns all Azure network security groups within a resource group or an entire subscription.

```ruby
describe azure_network_security_groups do
  #...
end
```

Or

```ruby
describe azure_network_security_groups(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource IDs.

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
{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that an example resource group has the named network security group

```ruby
describe azure_network_security_groups(resource_group: 'EXAMPLEGROUP') do
  its('names') { should include('ExampleNetworkSecurityGroup') }
end
```

### Filters the Network Security groups at Azure API to only those that match the specified name via a generic resource (Recommended)

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

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the resource returns a result. Use `should_not` if you expect zero matches.

```ruby
# If we expect the 'EXAMPLEGROUP' resource group to have Network Security groups.

describe azure_network_security_groups(resource_group: 'EXAMPLEGROUP') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect the 'EmptyExampleGroup' resource group to not have Network Security groups.

describe azure_network_security_groups(resource_group: 'EMPTYEXAMPLEGROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
