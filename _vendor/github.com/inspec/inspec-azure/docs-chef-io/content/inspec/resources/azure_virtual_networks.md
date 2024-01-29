+++
title = "azure_virtual_networks Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_virtual_networks"
identifier = "inspec/resources/azure/azure_virtual_networks Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_virtual_networks` InSpec audit resource to test the properties related to virtual networks within your subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_virtual_networks` resource block returns all Azure virtual networks within a resource group (if provided) or an entire subscription.

```ruby
describe azure_virtual_networks do
  #...
end
```

Or

```ruby
describe azure_virtual_networks(resource_group: 'RESOURCE_GROUP') do
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
: A list of locations for all the virtual networks.

: **Field**: `location`

`names`
: A list of all the virtual network names.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

`etags`
: A list of etags defined on the resources.

: **Field**: `etag`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Exists if any virtual networks exist in the resource group

```ruby
describe azure_virtual_networks(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

### Filters the results to only those that match the given name (Client Side)

```ruby
**Insist that MyVnetName exists.**

describe azure_virtual_networks(resource_group: 'RESOURCE_GROUP').where(name: 'VNET_NAME') do
  it { should exist }
end
```

```ruby
**Insist that you have at least one virtual network that starts with 'prefix'.**

describe azure_virtual_networks(resource_group: 'RESOURCE_GROUP').where { name.include?('project_A') } do
  it { should exist }
end
```

### Filters the networks at Azure API to only those that match the given name via a generic resource (Recommended)

```ruby
**Fuzzy string matching.**

describe azure_generic_resources(resource_group: 'RESOURCE_GROUP', resource_provider: 'Microsoft.Network/virtualNetworks', substring_of_name: 'project_A') do
  it { should exist }
end
```

```ruby

**Exact name matching.**

describe azure_generic_resources(resource_group: 'RESOURCE_GROUP', resource_provider: 'Microsoft.Network/virtualNetworks', name: 'MyVnetName') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no virtual networks are in the resource group.

describe azure_virtual_networks(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
