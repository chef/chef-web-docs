+++
title = "azure_resource_groups Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_resource_groups"
identifier = "inspec/resources/azure/azure_resource_groups Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_resource_groups` InSpec audit resource to test the properties and configuration of multiple Azure resource groups.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_resource_groups` resource block returns all resource groups within a subscription.

```ruby
describe azure_resource_groups do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the unique resource group IDs.

: **Field**: `id`

`names`
: A list of names of all the resource groups.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resource groups.

: **Field**: `tags`

`locations`
: A list of locations of all the resource groups.

: **Field**: `location`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check if a specific resource group is present

```ruby
describe azure_resource_groups do
  its('names')  { should include 'my-resource-group' }
end
```

### Filters the results to include only those resource groups that have the specified name

```ruby
describe azure_resource_groups.where{ name.include?('my-resource-group') } do
  it { should exist }
end
```

### Filters the results to include only the resource groups that have specified tag

```ruby
describe azure_resource_groups.where{ tags.has_key?('owner') && tags['owner'] == "InSpec" } do
  it { should exist }
  its('count') { should be 15 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_resource_groups do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
